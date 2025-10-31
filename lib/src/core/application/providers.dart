import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import 'package:workouttracker/src/core/data/datasources/local/exercise_local_data_source.dart';
import 'package:workouttracker/src/core/data/datasources/local/prefs_local_data_source.dart';
import 'package:workouttracker/src/core/data/datasources/local/session_local_data_source.dart';
import 'package:workouttracker/src/core/data/datasources/local/template_local_data_source.dart';
import 'package:workouttracker/src/core/data/repositories/exercise_repository_impl.dart';
import 'package:workouttracker/src/core/data/repositories/prefs_repository_impl.dart';
import 'package:workouttracker/src/core/data/repositories/session_repository_impl.dart';
import 'package:workouttracker/src/core/data/repositories/template_repository_impl.dart';
import 'package:workouttracker/src/core/domain/entities/exercise.dart';
import 'package:workouttracker/src/core/domain/entities/template.dart';
import 'package:workouttracker/src/core/domain/entities/timer.dart';
import 'package:workouttracker/src/core/domain/failures.dart';
import 'package:workouttracker/src/core/domain/repositories/exercise_repository.dart';
import 'package:workouttracker/src/core/domain/repositories/prefs_repository.dart';
import 'package:workouttracker/src/core/domain/repositories/session_repository.dart';
import 'package:workouttracker/src/core/domain/repositories/template_repository.dart';
import 'package:workouttracker/src/core/domain/usecases/advance_to_next_level.dart';
import 'package:workouttracker/src/core/domain/usecases/apply_template_to_exercise.dart';
import 'package:workouttracker/src/core/domain/usecases/create_exercise.dart';
import 'package:workouttracker/src/core/domain/usecases/evaluate_level_pass.dart';
import 'package:workouttracker/src/core/domain/usecases/end_session.dart';
import 'package:workouttracker/src/core/domain/usecases/generate_levels_from_template.dart';
import 'package:workouttracker/src/core/domain/usecases/get_sessions.dart';
import 'package:workouttracker/src/core/domain/usecases/get_templates.dart';
import 'package:workouttracker/src/core/domain/usecases/record_set_attempt.dart';
import 'package:workouttracker/src/core/domain/usecases/start_session.dart';

// Data layer providers
final exerciseLocalDataSourceProvider =
    Provider((ref) => ExerciseLocalDataSource());
final prefsLocalDataSourceProvider = Provider((ref) => PrefsLocalDataSource());

final exerciseRepositoryProvider = Provider<ExerciseRepository>(
  (ref) => ExerciseRepositoryImpl(ref.read(exerciseLocalDataSourceProvider)),
);

final sessionLocalDataSourceProvider =
    Provider((ref) => SessionLocalDataSource());
final templateLocalDataSourceProvider =
    Provider((ref) => TemplateLocalDataSource());

final sessionRepositoryProvider = Provider<SessionRepository>(
  (ref) => SessionRepositoryImpl(ref.read(sessionLocalDataSourceProvider)),
);
final templateRepositoryProvider = Provider<TemplateRepository>(
  (ref) => TemplateRepositoryImpl(ref.read(templateLocalDataSourceProvider)),
);

final prefsRepositoryProvider = Provider<PrefsRepository>((ref) {
  return PrefsRepositoryImpl(ref.read(prefsLocalDataSourceProvider));
});

final clockProvider = Provider<DateTime Function()>((ref) => DateTime.now);

// Use cases
final createExerciseUseCaseProvider = Provider(
  (ref) => CreateOrUpdateExercise(ref.read(exerciseRepositoryProvider)),
);
final startSessionUseCaseProvider =
    Provider((ref) => StartSession(ref.read(sessionRepositoryProvider)));
final recordSetAttemptUseCaseProvider =
    Provider((ref) => RecordSetAttempt(ref.read(sessionRepositoryProvider)));
final advanceToNextLevelUseCaseProvider =
    Provider((ref) => AdvanceToNextLevel(ref.read(exerciseRepositoryProvider)));
final evaluateLevelPassUseCaseProvider = Provider((ref) => EvaluateLevelPass());
final endSessionUseCaseProvider =
    Provider((ref) => EndSession(ref.read(sessionRepositoryProvider)));
final getSessionsUseCaseProvider =
    Provider((ref) => GetSessions(ref.read(sessionRepositoryProvider)));
final getTemplatesUseCaseProvider =
    Provider((ref) => GetTemplates(ref.read(templateRepositoryProvider)));
final generateLevelsFromTemplateProvider =
    Provider((ref) => const GenerateLevelsFromTemplate());
final applyTemplateToExerciseUseCaseProvider = Provider(
  (ref) => ApplyTemplateToExercise(
    ref.read(exerciseRepositoryProvider),
    ref.read(generateLevelsFromTemplateProvider),
  ),
);

// Timer settings as state
class TimerSettingsNotifier extends StateNotifier<AsyncValue<TimerSettings>> {
  TimerSettingsNotifier(this._repo) : super(const AsyncValue.loading()) {
    _load();
  }
  final PrefsRepository _repo;
  Future<void> _load() async {
    final res = await _repo.loadTimerSettings();
    res.match(
      (l) => state = AsyncValue.error(l, StackTrace.current),
      (r) => state = AsyncValue.data(r),
    );
  }

  Future<void> save(TimerSettings settings) async {
    state = AsyncValue.data(settings);
    await _repo.saveTimerSettings(settings);
  }
}

final timerSettingsProvider =
    StateNotifierProvider<TimerSettingsNotifier, AsyncValue<TimerSettings>>(
        (ref) {
  return TimerSettingsNotifier(ref.read(prefsRepositoryProvider));
});

// Exercises list as stream-ish (reloads on demand)
class ExercisesNotifier extends StateNotifier<AsyncValue<List<Exercise>>> {
  ExercisesNotifier(this._ref) : super(const AsyncValue.loading()) {
    refresh();
  }
  final Ref _ref;

  ExerciseRepository get _repo => _ref.read(exerciseRepositoryProvider);

  Future<void> refresh() async {
    final res = await _repo.getExercises();
    res.match(
      (l) => state = AsyncValue.error(l, StackTrace.current),
      (r) => state = AsyncValue.data(r),
    );
  }

  Future<void> upsert(Exercise ex) async {
    await _repo.upsertExercise(ex);
    await refresh();
  }

  Future<void> setCurrentLevel(String id, int idx) async {
    await _repo.setCurrentLevel(id, idx);
    await refresh();
  }

  Future<Either<Failure, Exercise>> advanceLevel(Exercise exercise) async {
    final result = await _ref.read(advanceToNextLevelUseCaseProvider)(exercise);
    if (result.isRight()) {
      await refresh();
    }
    return result;
  }

  Future<Either<Failure, Exercise>> applyTemplate({
    required Exercise exercise,
    required ProgressionTemplate template,
    required int restSeconds,
  }) async {
    final result = await _ref.read(applyTemplateToExerciseUseCaseProvider)(
      exercise: exercise,
      template: template,
      restSeconds: restSeconds,
    );
    if (result.isRight()) {
      await refresh();
    }
    result.match(
      (failure) => state = AsyncValue.error(failure, StackTrace.current),
      (_) {},
    );
    return result;
  }
}

final exercisesProvider =
    StateNotifierProvider<ExercisesNotifier, AsyncValue<List<Exercise>>>(
  ExercisesNotifier.new,
);

final templatesProvider =
    FutureProvider.autoDispose<List<ProgressionTemplate>>((ref) async {
  final result = await ref.read(getTemplatesUseCaseProvider)();
  return result.match(
    (failure) => throw failure,
    (templates) => templates,
  );
});
