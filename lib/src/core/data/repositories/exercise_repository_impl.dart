import 'package:fpdart/fpdart.dart';
import 'package:workouttracker/src/core/data/datasources/local/exercise_local_data_source.dart';
import 'package:workouttracker/src/core/domain/entities/exercise.dart';
import 'package:workouttracker/src/core/domain/failures.dart';
import 'package:workouttracker/src/core/domain/repositories/exercise_repository.dart';

class ExerciseRepositoryImpl implements ExerciseRepository {
  ExerciseRepositoryImpl(this.local);
  final ExerciseLocalDataSource local;

  @override
  Future<Either<Failure, Unit>> deleteExercise(String id) async {
    try {
      final list = await local.load();
      list.removeWhere((e) => e['id'] == id);
      await local.save(list);
      return right(unit);
    } catch (e) {
      return left(Failure.storage('Delete failed: $e'));
    }
  }

  @override
  Future<Either<Failure, Exercise>> getExercise(String id) async {
    try {
      final list = await local.load();
      final found = list.cast<Map<String, dynamic>>().firstWhere(
            (e) => e['id'] == id,
            orElse: () => throw StateError('Not found'),
          );
      return right(Exercise.fromJson(found));
    } catch (e) {
      return left(Failure.storage('Load failed: $e'));
    }
  }

  @override
  Future<Either<Failure, List<Exercise>>> getExercises() async {
    try {
      final list = await local.load();
      return right(list.map(Exercise.fromJson).toList());
    } catch (e) {
      return left(Failure.storage('Load failed: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> setCurrentLevel(
    String exerciseId,
    int levelIndex,
  ) async {
    try {
      final list = await local.load();
      final idx = list.indexWhere((e) => e['id'] == exerciseId);
      if (idx == -1) return left(const Failure.storage('Exercise not found'));
      final map = Map<String, dynamic>.from(list[idx]);
      map['currentLevelIndex'] = levelIndex;
      list[idx] = map;
      await local.save(list);
      return right(unit);
    } catch (e) {
      return left(Failure.storage('Update failed: $e'));
    }
  }

  @override
  Future<Either<Failure, Exercise>> upsertExercise(Exercise exercise) async {
    try {
      final list = await local.load();
      final idx = list.indexWhere((e) => e['id'] == exercise.id);
      final json = exercise.toJson();
      if (idx == -1) {
        list.add(json);
      } else {
        list[idx] = json;
      }
      await local.save(list);
      return right(exercise);
    } catch (e) {
      return left(Failure.storage('Save failed: $e'));
    }
  }
}
