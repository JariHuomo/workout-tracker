import 'package:fpdart/fpdart.dart';
import 'package:workouttracker/src/core/domain/entities/timer.dart';
import 'package:workouttracker/src/core/domain/failures.dart';

abstract class PrefsRepository {
  Future<Either<Failure, TimerSettings>> loadTimerSettings();
  Future<Either<Failure, Unit>> saveTimerSettings(TimerSettings settings);
}
