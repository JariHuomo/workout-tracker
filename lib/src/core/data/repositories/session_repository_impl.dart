import 'package:fpdart/fpdart.dart';
import 'package:workouttracker/src/core/data/datasources/local/session_local_data_source.dart';
import 'package:workouttracker/src/core/domain/entities/session.dart';
import 'package:workouttracker/src/core/domain/failures.dart';
import 'package:workouttracker/src/core/domain/repositories/session_repository.dart';

class SessionRepositoryImpl implements SessionRepository {
  SessionRepositoryImpl(this.local);

  final SessionLocalDataSource local;

  Future<Map<String, WorkoutSession>> _loadStore() async {
    final entries = await local.load();
    final sessions = entries.map(WorkoutSession.fromJson);
    return {for (final session in sessions) session.id: session};
  }

  Future<void> _persist(Map<String, WorkoutSession> store) async {
    await local.save(store.values.map((session) => session.toJson()).toList());
  }

  @override
  Future<Either<Failure, WorkoutSession>> startSession({
    required String exerciseId,
    required int levelIndex,
    required List<int> targetRepsPerSet,
  }) async {
    try {
      final store = await _loadStore();
      final id = DateTime.now().millisecondsSinceEpoch.toString();
      final session = WorkoutSession(
        id: id,
        exerciseId: exerciseId,
        levelIndex: levelIndex,
        targetRepsPerSet: targetRepsPerSet,
        startedAt: DateTime.now(),
      );
      store[id] = session;
      await _persist(store);
      return right(session);
    } catch (e) {
      return left(Failure.general('Start session failed: $e'));
    }
  }

  @override
  Future<Either<Failure, WorkoutSession>> recordSetAttempt({
    required String sessionId,
    required int setIndex,
    required int reps,
  }) async {
    try {
      final store = await _loadStore();
      final session = store[sessionId];
      if (session == null) {
        return left(const Failure.general('Session not found'));
      }
      final updated = session.copyWith(
        attempts: [
          ...session.attempts.where((a) => a.setIndex != setIndex),
          SetAttempt(setIndex: setIndex, reps: reps, timestamp: DateTime.now()),
        ]..sort((a, b) => a.setIndex.compareTo(b.setIndex)),
      );
      store[sessionId] = updated;
      await _persist(store);
      return right(updated);
    } catch (e) {
      return left(Failure.general('Record attempt failed: $e'));
    }
  }

  @override
  Future<Either<Failure, WorkoutSession>> endSession({
    required String sessionId,
    required bool passed,
  }) async {
    try {
      final store = await _loadStore();
      final session = store[sessionId];
      if (session == null) {
        return left(const Failure.general('Session not found'));
      }
      final updated = session.copyWith(endedAt: DateTime.now(), passed: passed);
      store[sessionId] = updated;
      await _persist(store);
      return right(updated);
    } catch (e) {
      return left(Failure.general('End session failed: $e'));
    }
  }

  @override
  Future<Either<Failure, WorkoutSession?>> getSession(String sessionId) async {
    try {
      final store = await _loadStore();
      return right(store[sessionId]);
    } catch (e) {
      return left(Failure.general('Get session failed: $e'));
    }
  }

  @override
  Future<Either<Failure, List<WorkoutSession>>> getSessions() async {
    try {
      final store = await _loadStore();
      final sessions = store.values.toList()
        ..sort((a, b) => (b.startedAt ?? DateTime.fromMillisecondsSinceEpoch(0))
            .compareTo(a.startedAt ?? DateTime.fromMillisecondsSinceEpoch(0)),);
      return right(sessions);
    } catch (e) {
      return left(Failure.general('Get sessions failed: $e'));
    }
  }
}
