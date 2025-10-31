import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:workouttracker/src/core/application/beep_service.dart';
import 'package:workouttracker/src/core/application/notification_service.dart';
import 'package:workouttracker/src/core/application/providers.dart';
import 'package:workouttracker/src/core/domain/entities/exercise.dart';
import 'package:workouttracker/src/core/domain/entities/session.dart';
import 'package:workouttracker/src/core/domain/entities/timer.dart';
import 'package:workouttracker/src/core/domain/failures.dart';

part 'session_controller.freezed.dart';

@freezed
class SessionState with _$SessionState {
  const factory SessionState.idle() = _Idle;
  const factory SessionState.inProgress({
    required WorkoutSession session,
    required int currentSetIndex,
  }) = _InProgress;
  const factory SessionState.resting({
    required WorkoutSession session,
    required int nextSetIndex,
    required DateTime restEndsAt,
    required int remainingSeconds,
  }) = _Resting;
  const factory SessionState.completed({
    required WorkoutSession session,
  }) = _Completed;
  const factory SessionState.failure({
    required Failure failure,
  }) = _Failure;
}

class SessionController extends StateNotifier<SessionState> {
  SessionController(this._ref) : super(const SessionState.idle());

  final Ref _ref;
  Timer? _ticker;

  DateTime _now() => _ref.read(clockProvider).call();

  Future<void> start(Exercise exercise, {int? levelIndex}) async {
    disposeTicker();
    if (exercise.levels.isEmpty) {
      _emitFailure(const Failure.general('Exercise has no defined levels.'));
      return;
    }
    final intendedIndex = (levelIndex ?? exercise.currentLevelIndex).clamp(
      0,
      exercise.levels.length - 1,
    );
    final usecase = _ref.read(startSessionUseCaseProvider);
    final result =
        await usecase(exercise: exercise, overrideLevelIndex: intendedIndex);
    result.match(
      _emitFailure,
      (session) async {
        await _ref.read(notificationServiceProvider).requestPermissions();
        state = SessionState.inProgress(session: session, currentSetIndex: 0);
      },
    );
  }

  Future<void> logSet({required int reps}) async {
    final currentState = state;
    if (currentState is _InProgress) {
      final session = currentState.session;
      final setIndex = currentState.currentSetIndex;
      final record = _ref.read(recordSetAttemptUseCaseProvider);
      final result =
          await record(sessionId: session.id, setIndex: setIndex, reps: reps);
      await result.match(
        (failure) async => _emitFailure(failure),
        (updated) async {
          final nextSetIndex = setIndex + 1;
          if (nextSetIndex < updated.targetRepsPerSet.length) {
            await _startRest(updated, nextSetIndex);
          } else {
            await _evaluateAndComplete(updated);
          }
        },
      );
    }
  }

  Future<void> skipRest() async {
    final currentState = state;
    if (currentState is _Resting) {
      disposeTicker();
      await _ref
          .read(notificationServiceProvider)
          .cancelRestEnd(currentState.session.id);
      state = SessionState.inProgress(
        session: currentState.session,
        currentSetIndex: currentState.nextSetIndex,
      );
    }
  }

  Future<void> adjustRest(int deltaSeconds) async {
    final currentState = state;
    if (currentState is _Resting) {
      final restEndsAt =
          currentState.restEndsAt.add(Duration(seconds: deltaSeconds));
      final now = _now();
      var adjustedEnd = restEndsAt.isBefore(now) ? now : restEndsAt;
      final maxEnd = now.add(const Duration(hours: 1));
      if (adjustedEnd.isAfter(maxEnd)) {
        adjustedEnd = maxEnd;
      }
      final remaining = _remainingSeconds(adjustedEnd);
      state = SessionState.resting(
        session: currentState.session,
        nextSetIndex: currentState.nextSetIndex,
        restEndsAt: adjustedEnd,
        remainingSeconds: remaining,
      );
      await _ref.read(notificationServiceProvider).scheduleRestEnd(
            adjustedEnd,
            sessionId: currentState.session.id,
          );
    }
  }

  Future<void> syncWithClock() async {
    final currentState = state;
    if (currentState is _Resting) {
      final remaining = _remainingSeconds(currentState.restEndsAt);
      if (remaining <= 0) {
        await _completeRest(currentState.session, currentState.nextSetIndex);
      } else {
        state = SessionState.resting(
          session: currentState.session,
          nextSetIndex: currentState.nextSetIndex,
          restEndsAt: currentState.restEndsAt,
          remainingSeconds: remaining,
        );
      }
    }
  }

  void disposeTicker() {
    _ticker?.cancel();
    _ticker = null;
  }

  int _defaultRest(WorkoutSession session) {
    final timerSettingsAsync = _ref.read(timerSettingsProvider);
    final timerSettings = timerSettingsAsync.value ?? const TimerSettings();
    return timerSettings.defaultRestSeconds;
  }

  Future<void> _startRest(WorkoutSession session, int nextSetIndex) async {
    disposeTicker();
    final duration = Duration(seconds: _defaultRest(session));
    final restEndsAt = _now().add(duration);
    state = SessionState.resting(
      session: session,
      nextSetIndex: nextSetIndex,
      restEndsAt: restEndsAt,
      remainingSeconds: duration.inSeconds,
    );
    await _ref.read(notificationServiceProvider).scheduleRestEnd(
          restEndsAt,
          sessionId: session.id,
        );
    // Tick more frequently than once per second to avoid visible drift on
    // some devices/builds, but only emit when the whole second changes.
    _ticker =
        Timer.periodic(const Duration(milliseconds: 250), (_) => _onRestTick());
  }

  void _onRestTick() {
    final currentState = state;
    if (currentState is _Resting) {
      final remaining = _remainingSeconds(currentState.restEndsAt);
      if (remaining <= 0) {
        unawaited(
          _completeRest(currentState.session, currentState.nextSetIndex),
        );
      } else if (remaining != currentState.remainingSeconds) {
        // Only update when the displayed second actually changes to
        // prevent unnecessary rebuilds while ensuring smooth countdown.
        state = SessionState.resting(
          session: currentState.session,
          nextSetIndex: currentState.nextSetIndex,
          restEndsAt: currentState.restEndsAt,
          remainingSeconds: remaining,
        );
      }
    } else {
      disposeTicker();
    }
  }

  Future<void> _completeRest(WorkoutSession session, int nextSetIndex) async {
    disposeTicker();
    await _ref.read(notificationServiceProvider).cancelRestEnd(session.id);
    await _ref.read(beepServiceProvider).playRestEndCue();
    state = SessionState.inProgress(
      session: session,
      currentSetIndex: nextSetIndex,
    );
  }

  Future<void> _evaluateAndComplete(WorkoutSession session) async {
    disposeTicker();
    await _ref.read(notificationServiceProvider).cancelRestEnd(session.id);
    final eval = _ref.read(evaluateLevelPassUseCaseProvider);
    final passed = eval(
      targetRepsPerSet: session.targetRepsPerSet,
      attempts: session.attempts,
    );
    final endSession = _ref.read(endSessionUseCaseProvider);
    final result =
        await endSession(sessionId: session.id, passed: passed);
    result.match(
      _emitFailure,
      (completed) => state = SessionState.completed(session: completed),
    );
  }

  int _remainingSeconds(DateTime restEndsAt) {
    final diff = restEndsAt.difference(_now()).inSeconds;
    return diff < 0 ? 0 : diff;
  }

  void _emitFailure(Failure failure) {
    disposeTicker();
    state = SessionState.failure(failure: failure);
  }
}

final sessionControllerProvider =
    StateNotifierProvider<SessionController, SessionState>(
  SessionController.new,
);
