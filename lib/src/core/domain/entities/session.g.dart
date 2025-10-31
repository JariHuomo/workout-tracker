// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SetAttemptImpl _$$SetAttemptImplFromJson(Map<String, dynamic> json) =>
    _$SetAttemptImpl(
      setIndex: (json['setIndex'] as num).toInt(),
      reps: (json['reps'] as num).toInt(),
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$SetAttemptImplToJson(_$SetAttemptImpl instance) =>
    <String, dynamic>{
      'setIndex': instance.setIndex,
      'reps': instance.reps,
      'timestamp': instance.timestamp.toIso8601String(),
    };

_$WorkoutSessionImpl _$$WorkoutSessionImplFromJson(Map<String, dynamic> json) =>
    _$WorkoutSessionImpl(
      id: json['id'] as String,
      exerciseId: json['exerciseId'] as String,
      levelIndex: (json['levelIndex'] as num).toInt(),
      targetRepsPerSet: (json['targetRepsPerSet'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      attempts: (json['attempts'] as List<dynamic>?)
              ?.map((e) => SetAttempt.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <SetAttempt>[],
      startedAt: json['startedAt'] == null
          ? null
          : DateTime.parse(json['startedAt'] as String),
      endedAt: json['endedAt'] == null
          ? null
          : DateTime.parse(json['endedAt'] as String),
      passed: json['passed'] as bool? ?? false,
      difficulty: (json['difficulty'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$WorkoutSessionImplToJson(
        _$WorkoutSessionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'exerciseId': instance.exerciseId,
      'levelIndex': instance.levelIndex,
      'targetRepsPerSet': instance.targetRepsPerSet,
      'attempts': instance.attempts,
      'startedAt': instance.startedAt?.toIso8601String(),
      'endedAt': instance.endedAt?.toIso8601String(),
      'passed': instance.passed,
      'difficulty': instance.difficulty,
    };
