import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workouttracker/src/core/data/datasources/local/session_local_data_source.dart';
import 'package:workouttracker/src/core/data/repositories/session_repository_impl.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
  });

  test('SessionRepositoryImpl persists sessions across instances', () async {
    final dataSource = SessionLocalDataSource();
    final repository = SessionRepositoryImpl(dataSource);

    final startResult = await repository.startSession(
      exerciseId: 'ex1',
      levelIndex: 0,
      targetRepsPerSet: const [5, 5],
    );
    final session = startResult.fold((_) => null, (value) => value);
    expect(session, isNotNull);
    final sessionId = session!.id;

    final recordResult = await repository.recordSetAttempt(
      sessionId: sessionId,
      setIndex: 0,
      reps: 5,
    );
    expect(recordResult.isRight(), isTrue);

    final endResult = await repository.endSession(
      sessionId: sessionId,
      passed: true,
    );
    expect(endResult.isRight(), isTrue);

    final newRepository = SessionRepositoryImpl(dataSource);
    final sessionsResult = await newRepository.getSessions();
    final sessions = sessionsResult.fold((_) => null, (value) => value);

    expect(sessions, isNotNull);
    expect(sessions, hasLength(1));
    expect(sessions!.first.id, sessionId);
    expect(sessions.first.passed, isTrue);
    expect(sessions.first.attempts, hasLength(1));
  });
}
