import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import 'package:workouttracker/src/core/application/providers.dart';
import 'package:workouttracker/src/core/domain/entities/exercise.dart';
import 'package:workouttracker/src/core/domain/entities/template.dart';
import 'package:workouttracker/src/core/domain/failures.dart';
import 'package:workouttracker/src/core/domain/repositories/exercise_repository.dart';

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

  Future<void> delete(String id) async {
    await _repo.deleteExercise(id);
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
