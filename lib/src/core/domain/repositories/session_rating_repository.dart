import 'package:fpdart/fpdart.dart';
import 'package:workouttracker/src/core/domain/failures.dart';

abstract class SessionRatingRepository {
  Future<Either<Failure, Unit>> setRating({
    required String sessionId,
    required int rating,
  });

  Future<Either<Failure, int?>> getRating(String sessionId);
}
