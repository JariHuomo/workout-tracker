import 'package:fpdart/fpdart.dart';
import 'package:workouttracker/src/core/domain/failures.dart';
import 'package:workouttracker/src/core/domain/repositories/session_rating_repository.dart';

class GetSessionRating {
  GetSessionRating(this.repo);
  final SessionRatingRepository repo;

  Future<Either<Failure, int?>> call({
    required String sessionId,
  }) {
    return repo.getRating(sessionId);
  }
}

