import 'package:fpdart/fpdart.dart';
import 'package:workouttracker/src/core/domain/failures.dart';
import 'package:workouttracker/src/core/domain/repositories/session_rating_repository.dart';

class SetSessionRating {
  SetSessionRating(this.repo);
  final SessionRatingRepository repo;

  Future<Either<Failure, Unit>> call({
    required String sessionId,
    required int rating,
  }) {
    return repo.setRating(sessionId: sessionId, rating: rating);
  }
}
