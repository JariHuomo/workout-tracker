import 'package:fpdart/fpdart.dart';
import 'package:workouttracker/src/core/domain/entities/session.dart';
import 'package:workouttracker/src/core/domain/failures.dart';
import 'package:workouttracker/src/core/domain/repositories/session_repository.dart';

class RecordSetAttempt {
  RecordSetAttempt(this.repo);
  final SessionRepository repo;

  Future<Either<Failure, WorkoutSession>> call({
    required String sessionId,
    required int setIndex,
    required int reps,
  }) {
    return repo.recordSetAttempt(
      sessionId: sessionId,
      setIndex: setIndex,
      reps: reps,
    );
  }
}
