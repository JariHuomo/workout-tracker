import 'package:fpdart/fpdart.dart';
import 'package:workouttracker/src/core/domain/entities/session.dart';
import 'package:workouttracker/src/core/domain/failures.dart';
import 'package:workouttracker/src/core/domain/repositories/session_repository.dart';

class EndSession {
  EndSession(this._repository);

  final SessionRepository _repository;

  Future<Either<Failure, WorkoutSession>> call({
    required String sessionId,
    required bool passed,
  }) {
    return _repository.endSession(sessionId: sessionId, passed: passed);
  }
}
