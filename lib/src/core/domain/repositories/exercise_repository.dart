import 'package:fpdart/fpdart.dart';
import 'package:workouttracker/src/core/domain/entities/exercise.dart';
import 'package:workouttracker/src/core/domain/failures.dart';

abstract class ExerciseRepository {
  Future<Either<Failure, List<Exercise>>> getExercises();
  Future<Either<Failure, Exercise>> getExercise(String id);
  Future<Either<Failure, Exercise>> upsertExercise(Exercise exercise);
  Future<Either<Failure, Unit>> deleteExercise(String id);
  Future<Either<Failure, Unit>> setCurrentLevel(
    String exerciseId,
    int levelIndex,
  );
}
