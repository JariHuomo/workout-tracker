import 'package:fpdart/fpdart.dart';
import 'package:workouttracker/src/core/data/datasources/local/template_local_data_source.dart';
import 'package:workouttracker/src/core/domain/entities/template.dart';
import 'package:workouttracker/src/core/domain/failures.dart';
import 'package:workouttracker/src/core/domain/repositories/template_repository.dart';

class TemplateRepositoryImpl implements TemplateRepository {
  TemplateRepositoryImpl(this._localDataSource);

  final TemplateLocalDataSource _localDataSource;

  List<ProgressionTemplate>? _cache;

  @override
  Future<Either<Failure, List<ProgressionTemplate>>> getTemplates() async {
    if (_cache != null) return right(_cache!);
    try {
      final raw = await _localDataSource.loadTemplates();
      _cache = raw.map(ProgressionTemplate.fromJson).toList();
      return right(_cache!);
    } catch (error) {
      return left(Failure.general('Load templates failed: $error'));
    }
  }

  @override
  void invalidateCache() {
    _cache = null;
  }
}
