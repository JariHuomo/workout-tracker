import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workouttracker/src/core/application/providers.dart';
import 'package:workouttracker/src/core/domain/entities/exercise.dart';
import 'package:workouttracker/src/core/domain/entities/session.dart';
import 'package:workouttracker/src/features/exercises/application/exercises_notifier.dart';
import 'package:workouttracker/src/features/session/application/session_controller.dart';
import 'package:workouttracker/src/features/session/presentation/session_screen.dart';

void main() {
  testWidgets('SessionScreen renders in-progress view', (tester) async {
    final fake = _FakeSessionController.withState(
      const SessionState.inProgress(
        session: WorkoutSession(
          id: 's1',
          exerciseId: 'ex1',
          levelIndex: 0,
          targetRepsPerSet: [5, 5],
        ),
        currentSetIndex: 0,
      ),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sessionControllerProvider.overrideWith((ref) => fake..attach(ref)),
        ],
        child: const MaterialApp(home: SessionScreen(sessionId: 's1')),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.textContaining('TARGET REPS'), findsOneWidget);
    expect(find.text('Log 5 Reps'), findsOneWidget);
    expect(find.text('QUICK ADJUST'), findsOneWidget);
  });

  testWidgets('SessionScreen renders resting view', (tester) async {
    final now = DateTime(2025, 1, 1, 12);
    final fake = _FakeSessionController.withState(
      SessionState.resting(
        session: const WorkoutSession(
          id: 's2',
          exerciseId: 'ex1',
          levelIndex: 0,
          targetRepsPerSet: [5, 5],
        ),
        nextSetIndex: 1,
        restEndsAt: now.add(const Duration(seconds: 30)),
        remainingSeconds: 30,
      ),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          clockProvider.overrideWithValue(() => now),
          sessionControllerProvider.overrideWith((ref) => fake..attach(ref)),
        ],
        child: const MaterialApp(home: SessionScreen(sessionId: 's2')),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Skip Rest'), findsOneWidget);
    expect(find.text('NEXT UP'), findsOneWidget);
    expect(find.text('−15s'), findsOneWidget);
    expect(find.text('+15s'), findsOneWidget);
  });

  testWidgets('SessionScreen renders completed view', (tester) async {
    const session = WorkoutSession(
      id: 's3',
      exerciseId: 'exX',
      levelIndex: 0,
      targetRepsPerSet: [5, 5],
      passed: true,
    );
    final fake = _FakeSessionController.withState(
      const SessionState.completed(session: session),
    );

    // Exercise matches the session and allows advancing
    const exercise = Exercise(
      id: 'exX',
      name: 'Dips',
      levels: [
        Level(index: 1, repsPerSet: [5, 5], restSeconds: 60),
        Level(index: 2, repsPerSet: [6, 6], restSeconds: 60),
      ],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          exercisesProvider.overrideWith(
            (ref) => _FakeExercisesNotifier(ref, const [exercise]),
          ),
          sessionControllerProvider.overrideWith((ref) => fake..attach(ref)),
        ],
        child: const MaterialApp(home: SessionScreen(sessionId: 's3')),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Session complete'), findsOneWidget);
    expect(find.textContaining('Passed'), findsOneWidget);
    expect(find.text('Advance Level'), findsOneWidget);
  });
}

class _FakeSessionController extends SessionController {
  _FakeSessionController(this._initial) : super(_PendingRef());

  _FakeSessionController.withState(SessionState state) : this(state);
  final SessionState _initial;
  void attach(Ref ref) {
    // Swap to real ref and set initial state
    // ignore: invalid_use_of_visible_for_testing_member
    final _ = state; // ensure state is initialized
    // Replace the private field via super constructor already done;
    // just set state.
    state = _initial;
  }
}

class _PendingRef implements Ref {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeExercisesNotifier extends ExercisesNotifier {
  _FakeExercisesNotifier(super.ref, List<Exercise> exercises) {
    state = AsyncValue.data(exercises);
  }
  @override
  Future<void> refresh() async {}
}
