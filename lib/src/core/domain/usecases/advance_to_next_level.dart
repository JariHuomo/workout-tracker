import 'package:fpdart/fpdart.dart';
import 'package:workouttracker/src/core/domain/entities/exercise.dart';
import 'package:workouttracker/src/core/domain/failures.dart';
import 'package:workouttracker/src/core/domain/repositories/exercise_repository.dart';

class AdvanceToNextLevel {
  AdvanceToNextLevel(this.repo);
  final ExerciseRepository repo;

  Future<Either<Failure, Exercise>> call(Exercise exercise) async {
    final nextIndex =
        (exercise.currentLevelIndex + 1).clamp(0, exercise.levels.length - 1);
    final updated = exercise.copyWith(currentLevelIndex: nextIndex);
    final res = await repo.upsertExercise(updated);
    return res;
  }
}
