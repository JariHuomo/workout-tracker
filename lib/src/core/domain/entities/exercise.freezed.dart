// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exercise.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Exercise _$ExerciseFromJson(Map<String, dynamic> json) {
  return _Exercise.fromJson(json);
}

/// @nodoc
mixin _$Exercise {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String? get templateId => throw _privateConstructorUsedError;
  List<Level> get levels => throw _privateConstructorUsedError;
  int get currentLevelIndex => throw _privateConstructorUsedError;
  String get notes => throw _privateConstructorUsedError;

  /// Serializes this Exercise to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Exercise
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExerciseCopyWith<Exercise> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExerciseCopyWith<$Res> {
  factory $ExerciseCopyWith(Exercise value, $Res Function(Exercise) then) =
      _$ExerciseCopyWithImpl<$Res, Exercise>;
  @useResult
  $Res call(
      {String id,
      String name,
      String category,
      String? templateId,
      List<Level> levels,
      int currentLevelIndex,
      String notes});
}

/// @nodoc
class _$ExerciseCopyWithImpl<$Res, $Val extends Exercise>
    implements $ExerciseCopyWith<$Res> {
  _$ExerciseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Exercise
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? category = null,
    Object? templateId = freezed,
    Object? levels = null,
    Object? currentLevelIndex = null,
    Object? notes = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      templateId: freezed == templateId
          ? _value.templateId
          : templateId // ignore: cast_nullable_to_non_nullable
              as String?,
      levels: null == levels
          ? _value.levels
          : levels // ignore: cast_nullable_to_non_nullable
              as List<Level>,
      currentLevelIndex: null == currentLevelIndex
          ? _value.currentLevelIndex
          : currentLevelIndex // ignore: cast_nullable_to_non_nullable
              as int,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExerciseImplCopyWith<$Res>
    implements $ExerciseCopyWith<$Res> {
  factory _$$ExerciseImplCopyWith(
          _$ExerciseImpl value, $Res Function(_$ExerciseImpl) then) =
      __$$ExerciseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String category,
      String? templateId,
      List<Level> levels,
      int currentLevelIndex,
      String notes});
}

/// @nodoc
class __$$ExerciseImplCopyWithImpl<$Res>
    extends _$ExerciseCopyWithImpl<$Res, _$ExerciseImpl>
    implements _$$ExerciseImplCopyWith<$Res> {
  __$$ExerciseImplCopyWithImpl(
      _$ExerciseImpl _value, $Res Function(_$ExerciseImpl) _then)
      : super(_value, _then);

  /// Create a copy of Exercise
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? category = null,
    Object? templateId = freezed,
    Object? levels = null,
    Object? currentLevelIndex = null,
    Object? notes = null,
  }) {
    return _then(_$ExerciseImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      templateId: freezed == templateId
          ? _value.templateId
          : templateId // ignore: cast_nullable_to_non_nullable
              as String?,
      levels: null == levels
          ? _value._levels
          : levels // ignore: cast_nullable_to_non_nullable
              as List<Level>,
      currentLevelIndex: null == currentLevelIndex
          ? _value.currentLevelIndex
          : currentLevelIndex // ignore: cast_nullable_to_non_nullable
              as int,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExerciseImpl implements _Exercise {
  const _$ExerciseImpl(
      {required this.id,
      required this.name,
      this.category = 'Custom',
      this.templateId,
      final List<Level> levels = const <Level>[],
      this.currentLevelIndex = 0,
      this.notes = ''})
      : _levels = levels;

  factory _$ExerciseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExerciseImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  @JsonKey()
  final String category;
  @override
  final String? templateId;
  final List<Level> _levels;
  @override
  @JsonKey()
  List<Level> get levels {
    if (_levels is EqualUnmodifiableListView) return _levels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_levels);
  }

  @override
  @JsonKey()
  final int currentLevelIndex;
  @override
  @JsonKey()
  final String notes;

  @override
  String toString() {
    return 'Exercise(id: $id, name: $name, category: $category, templateId: $templateId, levels: $levels, currentLevelIndex: $currentLevelIndex, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExerciseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.templateId, templateId) ||
                other.templateId == templateId) &&
            const DeepCollectionEquality().equals(other._levels, _levels) &&
            (identical(other.currentLevelIndex, currentLevelIndex) ||
                other.currentLevelIndex == currentLevelIndex) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, category, templateId,
      const DeepCollectionEquality().hash(_levels), currentLevelIndex, notes);

  /// Create a copy of Exercise
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExerciseImplCopyWith<_$ExerciseImpl> get copyWith =>
      __$$ExerciseImplCopyWithImpl<_$ExerciseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExerciseImplToJson(
      this,
    );
  }
}

abstract class _Exercise implements Exercise {
  const factory _Exercise(
      {required final String id,
      required final String name,
      final String category,
      final String? templateId,
      final List<Level> levels,
      final int currentLevelIndex,
      final String notes}) = _$ExerciseImpl;

  factory _Exercise.fromJson(Map<String, dynamic> json) =
      _$ExerciseImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get category;
  @override
  String? get templateId;
  @override
  List<Level> get levels;
  @override
  int get currentLevelIndex;
  @override
  String get notes;

  /// Create a copy of Exercise
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExerciseImplCopyWith<_$ExerciseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Level _$LevelFromJson(Map<String, dynamic> json) {
  return _Level.fromJson(json);
}

/// @nodoc
mixin _$Level {
  int get index => throw _privateConstructorUsedError;
  List<int> get repsPerSet => throw _privateConstructorUsedError;
  int get restSeconds => throw _privateConstructorUsedError;
  bool get isDeload => throw _privateConstructorUsedError;

  /// Serializes this Level to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Level
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LevelCopyWith<Level> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LevelCopyWith<$Res> {
  factory $LevelCopyWith(Level value, $Res Function(Level) then) =
      _$LevelCopyWithImpl<$Res, Level>;
  @useResult
  $Res call({int index, List<int> repsPerSet, int restSeconds, bool isDeload});
}

/// @nodoc
class _$LevelCopyWithImpl<$Res, $Val extends Level>
    implements $LevelCopyWith<$Res> {
  _$LevelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Level
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
    Object? repsPerSet = null,
    Object? restSeconds = null,
    Object? isDeload = null,
  }) {
    return _then(_value.copyWith(
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      repsPerSet: null == repsPerSet
          ? _value.repsPerSet
          : repsPerSet // ignore: cast_nullable_to_non_nullable
              as List<int>,
      restSeconds: null == restSeconds
          ? _value.restSeconds
          : restSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      isDeload: null == isDeload
          ? _value.isDeload
          : isDeload // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LevelImplCopyWith<$Res> implements $LevelCopyWith<$Res> {
  factory _$$LevelImplCopyWith(
          _$LevelImpl value, $Res Function(_$LevelImpl) then) =
      __$$LevelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int index, List<int> repsPerSet, int restSeconds, bool isDeload});
}

/// @nodoc
class __$$LevelImplCopyWithImpl<$Res>
    extends _$LevelCopyWithImpl<$Res, _$LevelImpl>
    implements _$$LevelImplCopyWith<$Res> {
  __$$LevelImplCopyWithImpl(
      _$LevelImpl _value, $Res Function(_$LevelImpl) _then)
      : super(_value, _then);

  /// Create a copy of Level
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
    Object? repsPerSet = null,
    Object? restSeconds = null,
    Object? isDeload = null,
  }) {
    return _then(_$LevelImpl(
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      repsPerSet: null == repsPerSet
          ? _value._repsPerSet
          : repsPerSet // ignore: cast_nullable_to_non_nullable
              as List<int>,
      restSeconds: null == restSeconds
          ? _value.restSeconds
          : restSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      isDeload: null == isDeload
          ? _value.isDeload
          : isDeload // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LevelImpl implements _Level {
  const _$LevelImpl(
      {required this.index,
      required final List<int> repsPerSet,
      this.restSeconds = 90,
      this.isDeload = false})
      : _repsPerSet = repsPerSet;

  factory _$LevelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LevelImplFromJson(json);

  @override
  final int index;
  final List<int> _repsPerSet;
  @override
  List<int> get repsPerSet {
    if (_repsPerSet is EqualUnmodifiableListView) return _repsPerSet;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_repsPerSet);
  }

  @override
  @JsonKey()
  final int restSeconds;
  @override
  @JsonKey()
  final bool isDeload;

  @override
  String toString() {
    return 'Level(index: $index, repsPerSet: $repsPerSet, restSeconds: $restSeconds, isDeload: $isDeload)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LevelImpl &&
            (identical(other.index, index) || other.index == index) &&
            const DeepCollectionEquality()
                .equals(other._repsPerSet, _repsPerSet) &&
            (identical(other.restSeconds, restSeconds) ||
                other.restSeconds == restSeconds) &&
            (identical(other.isDeload, isDeload) ||
                other.isDeload == isDeload));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, index,
      const DeepCollectionEquality().hash(_repsPerSet), restSeconds, isDeload);

  /// Create a copy of Level
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LevelImplCopyWith<_$LevelImpl> get copyWith =>
      __$$LevelImplCopyWithImpl<_$LevelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LevelImplToJson(
      this,
    );
  }
}

abstract class _Level implements Level {
  const factory _Level(
      {required final int index,
      required final List<int> repsPerSet,
      final int restSeconds,
      final bool isDeload}) = _$LevelImpl;

  factory _Level.fromJson(Map<String, dynamic> json) = _$LevelImpl.fromJson;

  @override
  int get index;
  @override
  List<int> get repsPerSet;
  @override
  int get restSeconds;
  @override
  bool get isDeload;

  /// Create a copy of Level
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LevelImplCopyWith<_$LevelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
