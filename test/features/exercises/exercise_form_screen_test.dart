import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workouttracker/src/core/application/providers.dart';
import 'package:fpdart/fpdart.dart';
import 'package:workouttracker/src/core/domain/entities/exercise.dart';
import 'package:workouttracker/src/core/domain/entities/template.dart';
import 'package:workouttracker/src/core/domain/failures.dart';
import 'package:workouttracker/src/core/domain/repositories/exercise_repository.dart';
import 'package:workouttracker/src/features/exercises/presentation/exercise_form_screen.dart';

void main() {
  final template = ProgressionTemplate(
    id: 'standard',
    name: 'Standard',
    description: 'Add 1 rep per week.',
    targetAudience: 'All',
    estimatedWeeks: 12,
    deloadFrequency: 4,
    deloadPercentage: 0.33,
    difficulty: 'medium',
    weeks: const [
      WeekProtocol(week: 1, sets: 5, reps: 1, isDeload: false),
      WeekProtocol(week: 2, sets: 5, reps: 2, isDeload: false),
      WeekProtocol(week: 3, sets: 5, reps: 3, isDeload: false),
      WeekProtocol(week: 4, sets: 5, reps: 2, isDeload: true),
    ],
  );

  testWidgets('ExerciseFormScreen enables Save after name + template', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          templatesProvider.overrideWith((ref) async => [template]),
          // Repository used by ExercisesNotifier during refresh
          exerciseRepositoryProvider.overrideWithValue(_FakeExerciseRepo()),
          exercisesProvider.overrideWith(_SpyExercisesNotifierWithRef.new),
        ],
        child: const MaterialApp(home: ExerciseFormScreen()),
      ),
    );

    await tester.pumpAndSettle();

    // Initially, Save is disabled
    final saveButton = find.byWidgetPredicate(
      (widget) => widget is FilledButton && widget.onPressed == null,
    );
    expect(saveButton, findsOneWidget);

    // Enter a name
    await tester.enterText(
      find.byType(TextField).first,
      'Ring Rows',
    );
    await tester.pump();

    // Select template
    await tester.tap(find.byType(DropdownButtonFormField<String?>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Standard').last);
    await tester.pumpAndSettle();

    // Template summary appears
    expect(find.text('Deload every 4 weeks'), findsOneWidget);

    // Save is now enabled - find the enabled button
    final enabledSaveButton = find.byWidgetPredicate(
      (widget) => widget is FilledButton && widget.onPressed != null,
    );
    expect(enabledSaveButton, findsOneWidget);

    await tester.tap(enabledSaveButton);
    await tester.pumpAndSettle();

    // Verify that our spy captured the upsert call
    final containerFinder = find.byType(ProviderScope);
    final element = tester.element(containerFinder);
    final container = ProviderScope.containerOf(element);
    final spy = container.read(exercisesProvider.notifier) as _SpyExercisesNotifierWithRef;
    expect(spy.upsertCalled, isTrue);
  });
}

class _SpyExercisesNotifierWithRef extends ExercisesNotifier {
  _SpyExercisesNotifierWithRef(Ref ref) : super(ref);
  bool upsertCalled = false;

  @override
  Future<void> upsert(Exercise ex) async {
    upsertCalled = true;
  }
}

class _FakeExerciseRepo implements ExerciseRepository {
  @override
  Future<Either<Failure, List<Exercise>>> getExercises() async => Right(const []);

  @override
  Future<Either<Failure, Exercise>> upsertExercise(Exercise exercise) async => Right(exercise);

  @override
  Future<Either<Failure, Unit>> setCurrentLevel(String id, int index) async => Right(unit);

  @override
  Future<Either<Failure, Exercise>> getExercise(String id) async =>
      Right(const Exercise(id: '', name: ''));

  @override
  Future<Either<Failure, Unit>> deleteExercise(String id) async => Right(unit);
}
