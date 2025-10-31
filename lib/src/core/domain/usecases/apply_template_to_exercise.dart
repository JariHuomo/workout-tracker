import 'package:fpdart/fpdart.dart';
import 'package:workouttracker/src/core/domain/entities/exercise.dart';
import 'package:workouttracker/src/core/domain/entities/template.dart';
import 'package:workouttracker/src/core/domain/failures.dart';
import 'package:workouttracker/src/core/domain/repositories/exercise_repository.dart';
import 'package:workouttracker/src/core/domain/usecases/generate_levels_from_template.dart';

class ApplyTemplateToExercise {
  ApplyTemplateToExercise(
    this._repository,
    this._generateLevelsFromTemplate,
  );

  final ExerciseRepository _repository;
  final GenerateLevelsFromTemplate _generateLevelsFromTemplate;

  Future<Either<Failure, Exercise>> call({
    required Exercise exercise,
    required ProgressionTemplate template,
    int restSeconds = 90,
  }) async {
    final levels = _generateLevelsFromTemplate(
      template: template,
      restSeconds: restSeconds,
    );
    final firstNonDeloadIndex =
        levels.indexWhere((level) => level.isDeload == false);
    final updatedExercise = exercise.copyWith(
      templateId: template.id,
      levels: levels,
      currentLevelIndex:
          firstNonDeloadIndex == -1 ? 0 : firstNonDeloadIndex,
    );
    return _repository.upsertExercise(updatedExercise);
  }
}

