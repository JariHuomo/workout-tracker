import 'package:fake_async/fake_async.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart' as flutter_test;
import 'package:fpdart/fpdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';
import 'package:workouttracker/src/core/application/beep_service.dart';
import 'package:workouttracker/src/core/application/notification_service.dart';
import 'package:workouttracker/src/core/application/providers.dart';
import 'package:workouttracker/src/core/domain/entities/exercise.dart';
import 'package:workouttracker/src/core/domain/entities/session.dart';
import 'package:workouttracker/src/core/domain/entities/timer.dart';
import 'package:workouttracker/src/core/domain/failures.dart';
import 'package:workouttracker/src/core/domain/repositories/prefs_repository.dart';
import 'package:workouttracker/src/features/session/application/session_controller.dart';

void main() {
  const restSeconds = 30;

  test('rest timer transitions back to in-progress after countdown', () {
    flutter_test.TestWidgetsFlutterBinding.ensureInitialized();
    fakeAsync((async) {
      final clock = async.getClock(DateTime(2025, 1, 1, 12));
      final prefs = _FakePrefsRepository(restSeconds: restSeconds);
      final notifications = _FakeNotificationService();
      final beeps = _FakeBeepService();

      SharedPreferences.setMockInitialValues({});
      final container = ProviderContainer(
        overrides: [
          prefsRepositoryProvider.overrideWithValue(prefs),
          notificationServiceProvider.overrideWithValue(notifications),
          beepServiceProvider.overrideWithValue(beeps),
          clockProvider.overrideWithValue(clock.now),
        ],
      );

      try {
        // Prime timer settings so the overridden rest duration is used.
        container.read(timerSettingsProvider);
        async.flushMicrotasks();

        final controller = container.read(sessionControllerProvider.notifier);
        const exercise = Exercise(
          id: 'ex1',
          name: 'Push Ups',
          levels: [
            Level(index: 1, repsPerSet: [5, 5], restSeconds: restSeconds),
          ],
        );

        controller.start(exercise);
        async.flushMicrotasks();

        final afterStart = container.read(sessionControllerProvider);
        final currentIndex = afterStart.maybeWhen<int?>(
          inProgress: (session, index) => index,
          orElse: () => null,
        );
        expect(currentIndex, 0);

        controller.logSet(reps: 5);
        async.flushMicrotasks();

        late DateTime restEndsAt;
        late String sessionId;
        final afterLog = container.read(sessionControllerProvider);
        final restState = afterLog.maybeWhen<
            (
              WorkoutSession session,
              int next,
              DateTime endsAt,
              int remaining,
            )?>(
          resting: (session, next, endsAt, remaining) => (session, next, endsAt, remaining),
          orElse: () => null,
        );
        expect(restState, isNotNull);
        final (session, next, endsAt, remaining) = restState!;
        expect(next, 1);
        expect(remaining, restSeconds);
        expect(notifications.scheduledSession, session.id);
        expect(notifications.scheduledAt, endsAt);
        restEndsAt = endsAt;
        sessionId = session.id;

        async
          ..elapse(const Duration(seconds: restSeconds))
          ..flushMicrotasks();

        final afterRest = container.read(sessionControllerProvider);
        final resumedIndex = afterRest.maybeWhen<int?>(
          inProgress: (session, index) {
            expect(session.attempts.length, 1);
            expect(beeps.playCount, 1);
            return index;
          },
          orElse: () => null,
        );
        expect(resumedIndex, 1);

        expect(notifications.cancelledSessions.contains(sessionId), isTrue);
        expect(
          restEndsAt.isAfter(
            clock.now().subtract(const Duration(seconds: restSeconds)),
          ),
          isTrue,
        );
      } finally {
        container.dispose();
      }
    });
  });
}

class _FakePrefsRepository implements PrefsRepository {
  _FakePrefsRepository({required this.restSeconds});

  int restSeconds;
  TimerSettings _settings() => TimerSettings(defaultRestSeconds: restSeconds);

  @override
  Future<Either<Failure, TimerSettings>> loadTimerSettings() async => right(_settings());

  @override
  Future<Either<Failure, Unit>> saveTimerSettings(
    TimerSettings settings,
  ) async {
    restSeconds = settings.defaultRestSeconds;
    return right(unit);
  }
}

class _FakeNotificationService extends NotificationService {
  DateTime? scheduledAt;
  String? scheduledSession;
  final Set<String> cancelledSessions = {};

  @override
  Future<void> init() async {}

  @override
  Future<void> requestPermissions() async {}

  @override
  Future<void> scheduleRestEnd(
    DateTime when, {
    required String sessionId,
  }) async {
    scheduledAt = when;
    scheduledSession = sessionId;
  }

  @override
  Future<void> cancelRestEnd(String sessionId) async {
    cancelledSessions.add(sessionId);
    if (scheduledSession == sessionId) {
      scheduledAt = null;
      scheduledSession = null;
    }
  }
}

class _FakeBeepService implements BeepService {
  int playCount = 0;

  @override
  Future<void> playCountdownTick() async {}

  @override
  Future<void> playRestEndCue() async {
    playCount++;
  }

  @override
  void dispose() {}
}
