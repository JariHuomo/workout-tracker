import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workouttracker/src/core/domain/entities/exercise.dart';
import 'package:workouttracker/src/features/exercises/application/exercises_notifier.dart';
import 'package:workouttracker/src/features/exercises/presentation/exercises_screen.dart';

void main() {
  testWidgets('ExercisesScreen shows empty state when no items',
      (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          exercisesProvider.overrideWith(
            (ref) => _FakeExercisesNotifier(ref, const []),
          ),
        ],
        child: const MaterialApp(home: ExercisesScreen()),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('No Exercises Yet'), findsOneWidget);
    expect(find.text('Create Exercise'), findsOneWidget);
  });

  testWidgets('ExercisesScreen renders an exercise card', (tester) async {
    const exercise = Exercise(
      id: 'ex1',
      name: 'Pull-ups',
      levels: [
        Level(index: 1, repsPerSet: [5, 5, 5, 5, 5]),
      ],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          exercisesProvider.overrideWith(
            (ref) => _FakeExercisesNotifier(ref, const [exercise]),
          ),
        ],
        child: const MaterialApp(home: ExercisesScreen()),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Pull-ups'), findsOneWidget);
    expect(find.text('Start Workout'), findsOneWidget);
    expect(find.text('OVERALL PROGRESS'), findsOneWidget);
  });
}

class _FakeExercisesNotifier extends ExercisesNotifier {
  _FakeExercisesNotifier(super.ref, List<Exercise> exercises) {
    state = AsyncValue.data(exercises);
  }
  @override
  Future<void> refresh() async {
    // no-op for tests
  }
}
