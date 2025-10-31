import 'package:freezed_annotation/freezed_annotation.dart';

part 'session.freezed.dart';
part 'session.g.dart';

@freezed
class SetAttempt with _$SetAttempt {
  const factory SetAttempt({
    required int setIndex,
    required int reps,
    required DateTime timestamp,
  }) = _SetAttempt;

  factory SetAttempt.fromJson(Map<String, dynamic> json) => _$SetAttemptFromJson(json);
}

@freezed
class WorkoutSession with _$WorkoutSession {
  const factory WorkoutSession({
    required String id,
    required String exerciseId,
    required int levelIndex,
    required List<int> targetRepsPerSet,
    @Default(<SetAttempt>[]) List<SetAttempt> attempts,
    DateTime? startedAt,
    DateTime? endedAt,
    @Default(false) bool passed,
  }) = _WorkoutSession;

  factory WorkoutSession.fromJson(Map<String, dynamic> json) => _$WorkoutSessionFromJson(json);
}
