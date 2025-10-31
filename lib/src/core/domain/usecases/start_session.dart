import 'package:fpdart/fpdart.dart';
import 'package:workouttracker/src/core/domain/entities/exercise.dart';
import 'package:workouttracker/src/core/domain/entities/session.dart';
import 'package:workouttracker/src/core/domain/failures.dart';
import 'package:workouttracker/src/core/domain/repositories/session_repository.dart';

class StartSession {
  StartSession(this.repo);
  final SessionRepository repo;

  Future<Either<Failure, WorkoutSession>> call({
    required Exercise exercise,
    int? overrideLevelIndex,
  }) {
    final levelIndex = overrideLevelIndex ?? exercise.currentLevelIndex;
    final level = exercise.levels[levelIndex];
    return repo.startSession(
      exerciseId: exercise.id,
      levelIndex: levelIndex,
      targetRepsPerSet: level.repsPerSet,
    );
  }
}
