// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExerciseImpl _$$ExerciseImplFromJson(Map<String, dynamic> json) =>
    _$ExerciseImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      category: json['category'] as String? ?? 'Custom',
      templateId: json['templateId'] as String?,
      levels: (json['levels'] as List<dynamic>?)
              ?.map((e) => Level.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <Level>[],
      currentLevelIndex: (json['currentLevelIndex'] as num?)?.toInt() ?? 0,
      notes: json['notes'] as String? ?? '',
    );

Map<String, dynamic> _$$ExerciseImplToJson(_$ExerciseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category': instance.category,
      'templateId': instance.templateId,
      'levels': instance.levels,
      'currentLevelIndex': instance.currentLevelIndex,
      'notes': instance.notes,
    };

_$LevelImpl _$$LevelImplFromJson(Map<String, dynamic> json) => _$LevelImpl(
      index: (json['index'] as num).toInt(),
      repsPerSet: (json['repsPerSet'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      restSeconds: (json['restSeconds'] as num?)?.toInt() ?? 90,
      isDeload: json['isDeload'] as bool? ?? false,
    );

Map<String, dynamic> _$$LevelImplToJson(_$LevelImpl instance) =>
    <String, dynamic>{
      'index': instance.index,
      'repsPerSet': instance.repsPerSet,
      'restSeconds': instance.restSeconds,
      'isDeload': instance.isDeload,
    };
