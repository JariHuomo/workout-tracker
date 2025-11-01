import 'package:fpdart/fpdart.dart';
import 'package:workouttracker/src/core/domain/entities/template.dart';
import 'package:workouttracker/src/core/domain/failures.dart';

abstract class TemplateRepository {
  Future<Either<Failure, List<ProgressionTemplate>>> getTemplates();

  /// Clears any cached templates so that the next fetch refreshes from source.
  void invalidateCache();
}
