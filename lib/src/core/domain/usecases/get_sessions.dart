import 'package:fpdart/fpdart.dart';
import 'package:workouttracker/src/core/domain/entities/session.dart';
import 'package:workouttracker/src/core/domain/failures.dart';
import 'package:workouttracker/src/core/domain/repositories/session_repository.dart';

class GetSessions {
  GetSessions(this._repository);

  final SessionRepository _repository;

  Future<Either<Failure, List<WorkoutSession>>> call() {
    return _repository.getSessions();
  }
}
