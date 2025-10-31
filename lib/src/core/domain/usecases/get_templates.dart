import 'package:fpdart/fpdart.dart';
import 'package:workouttracker/src/core/domain/entities/template.dart';
import 'package:workouttracker/src/core/domain/failures.dart';
import 'package:workouttracker/src/core/domain/repositories/template_repository.dart';

class GetTemplates {
  GetTemplates(this._repository);

  final TemplateRepository _repository;

  Future<Either<Failure, List<ProgressionTemplate>>> call() {
    return _repository.getTemplates();
  }
}
