import 'package:test/test.dart';
import 'package:workouttracker/src/core/domain/entities/session.dart';
import 'package:workouttracker/src/core/domain/usecases/evaluate_level_pass.dart';

void main() {
  final usecase = EvaluateLevelPass();

  group('EvaluateLevelPass', () {
    test('returns true when every set meets or exceeds target', () {
      final result = usecase(
        targetRepsPerSet: const [5, 5, 5, 5, 5],
        attempts: [
          SetAttempt(setIndex: 0, reps: 5, timestamp: nullTime),
          SetAttempt(setIndex: 1, reps: 6, timestamp: nullTime),
          SetAttempt(setIndex: 2, reps: 5, timestamp: nullTime),
          SetAttempt(setIndex: 3, reps: 7, timestamp: nullTime),
          SetAttempt(setIndex: 4, reps: 5, timestamp: nullTime),
        ],
      );
      expect(result, isTrue);
    });

    test('returns false when any set is below target', () {
      final result = usecase(
        targetRepsPerSet: const [5, 5, 5],
        attempts: [
          SetAttempt(setIndex: 0, reps: 5, timestamp: nullTime),
          SetAttempt(setIndex: 1, reps: 4, timestamp: nullTime),
        ],
      );
      expect(result, isFalse);
    });

    test('uses last attempt per set when multiple attempts exist', () {
      final result = usecase(
        targetRepsPerSet: const [5, 5],
        attempts: [
          SetAttempt(setIndex: 0, reps: 4, timestamp: nullTime),
          SetAttempt(setIndex: 0, reps: 5, timestamp: nullTime),
          SetAttempt(setIndex: 1, reps: 5, timestamp: nullTime),
        ],
      );
      expect(result, isTrue);
    });
  });
}

final nullTime = DateTime.fromMillisecondsSinceEpoch(0);
