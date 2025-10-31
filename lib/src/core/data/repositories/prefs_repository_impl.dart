import 'package:fpdart/fpdart.dart';
import 'package:workouttracker/src/core/data/datasources/local/prefs_local_data_source.dart';
import 'package:workouttracker/src/core/domain/entities/timer.dart';
import 'package:workouttracker/src/core/domain/failures.dart';
import 'package:workouttracker/src/core/domain/repositories/prefs_repository.dart';

class PrefsRepositoryImpl implements PrefsRepository {
  PrefsRepositoryImpl(this.local);
  final PrefsLocalDataSource local;

  @override
  Future<Either<Failure, TimerSettings>> loadTimerSettings() async {
    try {
      final map = await local.loadTimerSettings();
      return right(
        map == null ? const TimerSettings() : TimerSettings.fromJson(map),
      );
    } catch (e) {
      return left(Failure.storage('Load settings failed: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> saveTimerSettings(
    TimerSettings settings,
  ) async {
    try {
      await local.saveTimerSettings(settings.toJson());
      return right(unit);
    } catch (e) {
      return left(Failure.storage('Save settings failed: $e'));
    }
  }
}
