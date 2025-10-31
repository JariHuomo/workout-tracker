import 'package:fpdart/fpdart.dart';
import 'package:workouttracker/src/core/data/datasources/local/session_rating_local_data_source.dart';
import 'package:workouttracker/src/core/domain/failures.dart';
import 'package:workouttracker/src/core/domain/repositories/session_rating_repository.dart';

class SessionRatingRepositoryImpl implements SessionRatingRepository {
  SessionRatingRepositoryImpl(this.local);
  final SessionRatingLocalDataSource local;

  @override
  Future<Either<Failure, Unit>> setRating({
    required String sessionId,
    required int rating,
  }) async {
    try {
      final store = await local.load();
      final safeRating = rating < 1
          ? 1
          : rating > 5
              ? 5
              : rating;
      store[sessionId] = safeRating;
      await local.save(store);
      return right(unit);
    } catch (e) {
      return left(Failure.general('Failed to save rating: $e'));
    }
  }

  @override
  Future<Either<Failure, int?>> getRating(String sessionId) async {
    try {
      final store = await local.load();
      return right(store[sessionId]);
    } catch (e) {
      return left(Failure.general('Failed to load rating: $e'));
    }
  }
}
