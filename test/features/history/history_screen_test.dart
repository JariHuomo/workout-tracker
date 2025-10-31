import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workouttracker/src/core/application/providers.dart';
import 'package:workouttracker/src/core/domain/entities/exercise.dart';
import 'package:workouttracker/src/core/domain/entities/session.dart';
import 'package:workouttracker/src/features/history/application/history_sessions_provider.dart';
import 'package:workouttracker/src/features/history/presentation/history_screen.dart';

void main() {
  testWidgets('HistoryScreen renders session cards', (tester) async {
    final session = WorkoutSession(
      id: 's1',
      exerciseId: 'ex1',
      levelIndex: 0,
      targetRepsPerSet: const [5, 5],
      attempts: [
        SetAttempt(
          setIndex: 0,
          reps: 5,
          timestamp: DateTime(2025, 1, 1, 10, 31),
        ),
        SetAttempt(
          setIndex: 1,
          reps: 6,
          timestamp: DateTime(2025, 1, 1, 10, 34),
        ),
      ],
      startedAt: DateTime(2025, 1, 1, 10, 30),
      endedAt: DateTime(2025, 1, 1, 10, 45),
      passed: true,
    );

    final exercise = Exercise(
      id: 'ex1',
      name: 'Ring Rows',
      levels: const [],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          historySessionsProvider.overrideWith(
            (ref) async => [session],
          ),
          exercisesProvider.overrideWith(
            (ref) => _FakeExercisesNotifier(ref, [exercise]),
          ),
        ],
        child: const MaterialApp(
          home: HistoryScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Ring Rows'), findsOneWidget);
    expect(find.textContaining('Logged:'), findsOneWidget);
    expect(find.text('Passed'), findsOneWidget);
  });
}

class _FakeExercisesNotifier extends ExercisesNotifier {
  _FakeExercisesNotifier(Ref ref, List<Exercise> exercises) : super(ref) {
    state = AsyncValue.data(exercises);
  }
  @override
  Future<void> refresh() async {}
}
