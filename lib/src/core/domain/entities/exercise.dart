import 'package:freezed_annotation/freezed_annotation.dart';

part 'exercise.freezed.dart';
part 'exercise.g.dart';

@freezed
class Exercise with _$Exercise {
  const factory Exercise({
    required String id,
    required String name,
    @Default('Custom') String category,
    String? templateId,
    @Default(<Level>[]) List<Level> levels,
    @Default(0) int currentLevelIndex,
    @Default('') String notes,
  }) = _Exercise;

  factory Exercise.fromJson(Map<String, dynamic> json) => _$ExerciseFromJson(json);
}

@freezed
class Level with _$Level {
  const factory Level({
    required int index,
    required List<int> repsPerSet,
    @Default(90) int restSeconds,
    @Default(false) bool isDeload,
  }) = _Level;

  factory Level.fromJson(Map<String, dynamic> json) => _$LevelFromJson(json);
}
