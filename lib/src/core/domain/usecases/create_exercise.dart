import 'package:fpdart/fpdart.dart';
import 'package:workouttracker/src/core/domain/entities/exercise.dart';
import 'package:workouttracker/src/core/domain/failures.dart';
import 'package:workouttracker/src/core/domain/repositories/exercise_repository.dart';

class CreateOrUpdateExercise {
  CreateOrUpdateExercise(this.repo);
  final ExerciseRepository repo;

  Future<Either<Failure, Exercise>> call(Exercise exercise) {
    return repo.upsertExercise(exercise);
  }
}
