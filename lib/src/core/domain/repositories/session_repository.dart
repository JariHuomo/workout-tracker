import 'package:fpdart/fpdart.dart';
import 'package:workouttracker/src/core/domain/entities/session.dart';
import 'package:workouttracker/src/core/domain/failures.dart';

abstract class SessionRepository {
  Future<Either<Failure, WorkoutSession>> startSession({
    required String exerciseId,
    required int levelIndex,
    required List<int> targetRepsPerSet,
  });
  Future<Either<Failure, WorkoutSession>> recordSetAttempt({
    required String sessionId,
    required int setIndex,
    required int reps,
  });
  Future<Either<Failure, WorkoutSession>> endSession({
    required String sessionId,
    required bool passed,
  });
  Future<Either<Failure, WorkoutSession?>> getSession(String sessionId);
  Future<Either<Failure, List<WorkoutSession>>> getSessions();
}
