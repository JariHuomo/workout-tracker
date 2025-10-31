// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SetAttempt _$SetAttemptFromJson(Map<String, dynamic> json) {
  return _SetAttempt.fromJson(json);
}

/// @nodoc
mixin _$SetAttempt {
  int get setIndex => throw _privateConstructorUsedError;
  int get reps => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SetAttemptCopyWith<SetAttempt> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SetAttemptCopyWith<$Res> {
  factory $SetAttemptCopyWith(
          SetAttempt value, $Res Function(SetAttempt) then) =
      _$SetAttemptCopyWithImpl<$Res, SetAttempt>;
  @useResult
  $Res call({int setIndex, int reps, DateTime timestamp});
}

/// @nodoc
class _$SetAttemptCopyWithImpl<$Res, $Val extends SetAttempt>
    implements $SetAttemptCopyWith<$Res> {
  _$SetAttemptCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? setIndex = null,
    Object? reps = null,
    Object? timestamp = null,
  }) {
    return _then(_value.copyWith(
      setIndex: null == setIndex
          ? _value.setIndex
          : setIndex // ignore: cast_nullable_to_non_nullable
              as int,
      reps: null == reps
          ? _value.reps
          : reps // ignore: cast_nullable_to_non_nullable
              as int,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SetAttemptImplCopyWith<$Res>
    implements $SetAttemptCopyWith<$Res> {
  factory _$$SetAttemptImplCopyWith(
          _$SetAttemptImpl value, $Res Function(_$SetAttemptImpl) then) =
      __$$SetAttemptImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int setIndex, int reps, DateTime timestamp});
}

/// @nodoc
class __$$SetAttemptImplCopyWithImpl<$Res>
    extends _$SetAttemptCopyWithImpl<$Res, _$SetAttemptImpl>
    implements _$$SetAttemptImplCopyWith<$Res> {
  __$$SetAttemptImplCopyWithImpl(
      _$SetAttemptImpl _value, $Res Function(_$SetAttemptImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? setIndex = null,
    Object? reps = null,
    Object? timestamp = null,
  }) {
    return _then(_$SetAttemptImpl(
      setIndex: null == setIndex
          ? _value.setIndex
          : setIndex // ignore: cast_nullable_to_non_nullable
              as int,
      reps: null == reps
          ? _value.reps
          : reps // ignore: cast_nullable_to_non_nullable
              as int,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SetAttemptImpl implements _SetAttempt {
  const _$SetAttemptImpl(
      {required this.setIndex, required this.reps, required this.timestamp});

  factory _$SetAttemptImpl.fromJson(Map<String, dynamic> json) =>
      _$$SetAttemptImplFromJson(json);

  @override
  final int setIndex;
  @override
  final int reps;
  @override
  final DateTime timestamp;

  @override
  String toString() {
    return 'SetAttempt(setIndex: $setIndex, reps: $reps, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetAttemptImpl &&
            (identical(other.setIndex, setIndex) ||
                other.setIndex == setIndex) &&
            (identical(other.reps, reps) || other.reps == reps) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, setIndex, reps, timestamp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SetAttemptImplCopyWith<_$SetAttemptImpl> get copyWith =>
      __$$SetAttemptImplCopyWithImpl<_$SetAttemptImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SetAttemptImplToJson(
      this,
    );
  }
}

abstract class _SetAttempt implements SetAttempt {
  const factory _SetAttempt(
      {required final int setIndex,
      required final int reps,
      required final DateTime timestamp}) = _$SetAttemptImpl;

  factory _SetAttempt.fromJson(Map<String, dynamic> json) =
      _$SetAttemptImpl.fromJson;

  @override
  int get setIndex;
  @override
  int get reps;
  @override
  DateTime get timestamp;
  @override
  @JsonKey(ignore: true)
  _$$SetAttemptImplCopyWith<_$SetAttemptImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WorkoutSession _$WorkoutSessionFromJson(Map<String, dynamic> json) {
  return _WorkoutSession.fromJson(json);
}

/// @nodoc
mixin _$WorkoutSession {
  String get id => throw _privateConstructorUsedError;
  String get exerciseId => throw _privateConstructorUsedError;
  int get levelIndex => throw _privateConstructorUsedError;
  List<int> get targetRepsPerSet => throw _privateConstructorUsedError;
  List<SetAttempt> get attempts => throw _privateConstructorUsedError;
  DateTime? get startedAt => throw _privateConstructorUsedError;
  DateTime? get endedAt => throw _privateConstructorUsedError;
  bool get passed => throw _privateConstructorUsedError;
  int? get difficulty => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WorkoutSessionCopyWith<WorkoutSession> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkoutSessionCopyWith<$Res> {
  factory $WorkoutSessionCopyWith(
          WorkoutSession value, $Res Function(WorkoutSession) then) =
      _$WorkoutSessionCopyWithImpl<$Res, WorkoutSession>;
  @useResult
  $Res call(
      {String id,
      String exerciseId,
      int levelIndex,
      List<int> targetRepsPerSet,
      List<SetAttempt> attempts,
      DateTime? startedAt,
      DateTime? endedAt,
      bool passed,
      int? difficulty});
}

/// @nodoc
class _$WorkoutSessionCopyWithImpl<$Res, $Val extends WorkoutSession>
    implements $WorkoutSessionCopyWith<$Res> {
  _$WorkoutSessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? exerciseId = null,
    Object? levelIndex = null,
    Object? targetRepsPerSet = null,
    Object? attempts = null,
    Object? startedAt = freezed,
    Object? endedAt = freezed,
    Object? passed = null,
    Object? difficulty = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      exerciseId: null == exerciseId
          ? _value.exerciseId
          : exerciseId // ignore: cast_nullable_to_non_nullable
              as String,
      levelIndex: null == levelIndex
          ? _value.levelIndex
          : levelIndex // ignore: cast_nullable_to_non_nullable
              as int,
      targetRepsPerSet: null == targetRepsPerSet
          ? _value.targetRepsPerSet
          : targetRepsPerSet // ignore: cast_nullable_to_non_nullable
              as List<int>,
      attempts: null == attempts
          ? _value.attempts
          : attempts // ignore: cast_nullable_to_non_nullable
              as List<SetAttempt>,
      startedAt: freezed == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endedAt: freezed == endedAt
          ? _value.endedAt
          : endedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      passed: null == passed
          ? _value.passed
          : passed // ignore: cast_nullable_to_non_nullable
              as bool,
      difficulty: freezed == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WorkoutSessionImplCopyWith<$Res>
    implements $WorkoutSessionCopyWith<$Res> {
  factory _$$WorkoutSessionImplCopyWith(_$WorkoutSessionImpl value,
          $Res Function(_$WorkoutSessionImpl) then) =
      __$$WorkoutSessionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String exerciseId,
      int levelIndex,
      List<int> targetRepsPerSet,
      List<SetAttempt> attempts,
      DateTime? startedAt,
      DateTime? endedAt,
      bool passed,
      int? difficulty});
}

/// @nodoc
class __$$WorkoutSessionImplCopyWithImpl<$Res>
    extends _$WorkoutSessionCopyWithImpl<$Res, _$WorkoutSessionImpl>
    implements _$$WorkoutSessionImplCopyWith<$Res> {
  __$$WorkoutSessionImplCopyWithImpl(
      _$WorkoutSessionImpl _value, $Res Function(_$WorkoutSessionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? exerciseId = null,
    Object? levelIndex = null,
    Object? targetRepsPerSet = null,
    Object? attempts = null,
    Object? startedAt = freezed,
    Object? endedAt = freezed,
    Object? passed = null,
    Object? difficulty = freezed,
  }) {
    return _then(_$WorkoutSessionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      exerciseId: null == exerciseId
          ? _value.exerciseId
          : exerciseId // ignore: cast_nullable_to_non_nullable
              as String,
      levelIndex: null == levelIndex
          ? _value.levelIndex
          : levelIndex // ignore: cast_nullable_to_non_nullable
              as int,
      targetRepsPerSet: null == targetRepsPerSet
          ? _value._targetRepsPerSet
          : targetRepsPerSet // ignore: cast_nullable_to_non_nullable
              as List<int>,
      attempts: null == attempts
          ? _value._attempts
          : attempts // ignore: cast_nullable_to_non_nullable
              as List<SetAttempt>,
      startedAt: freezed == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endedAt: freezed == endedAt
          ? _value.endedAt
          : endedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      passed: null == passed
          ? _value.passed
          : passed // ignore: cast_nullable_to_non_nullable
              as bool,
      difficulty: freezed == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WorkoutSessionImpl implements _WorkoutSession {
  const _$WorkoutSessionImpl(
      {required this.id,
      required this.exerciseId,
      required this.levelIndex,
      required final List<int> targetRepsPerSet,
      final List<SetAttempt> attempts = const <SetAttempt>[],
      this.startedAt,
      this.endedAt,
      this.passed = false,
      this.difficulty})
      : _targetRepsPerSet = targetRepsPerSet,
        _attempts = attempts;

  factory _$WorkoutSessionImpl.fromJson(Map<String, dynamic> json) =>
      _$$WorkoutSessionImplFromJson(json);

  @override
  final String id;
  @override
  final String exerciseId;
  @override
  final int levelIndex;
  final List<int> _targetRepsPerSet;
  @override
  List<int> get targetRepsPerSet {
    if (_targetRepsPerSet is EqualUnmodifiableListView)
      return _targetRepsPerSet;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_targetRepsPerSet);
  }

  final List<SetAttempt> _attempts;
  @override
  @JsonKey()
  List<SetAttempt> get attempts {
    if (_attempts is EqualUnmodifiableListView) return _attempts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attempts);
  }

  @override
  final DateTime? startedAt;
  @override
  final DateTime? endedAt;
  @override
  @JsonKey()
  final bool passed;
  @override
  final int? difficulty;

  @override
  String toString() {
    return 'WorkoutSession(id: $id, exerciseId: $exerciseId, levelIndex: $levelIndex, targetRepsPerSet: $targetRepsPerSet, attempts: $attempts, startedAt: $startedAt, endedAt: $endedAt, passed: $passed, difficulty: $difficulty)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkoutSessionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.exerciseId, exerciseId) ||
                other.exerciseId == exerciseId) &&
            (identical(other.levelIndex, levelIndex) ||
                other.levelIndex == levelIndex) &&
            const DeepCollectionEquality()
                .equals(other._targetRepsPerSet, _targetRepsPerSet) &&
            const DeepCollectionEquality().equals(other._attempts, _attempts) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.endedAt, endedAt) || other.endedAt == endedAt) &&
            (identical(other.passed, passed) || other.passed == passed) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      exerciseId,
      levelIndex,
      const DeepCollectionEquality().hash(_targetRepsPerSet),
      const DeepCollectionEquality().hash(_attempts),
      startedAt,
      endedAt,
      passed,
      difficulty);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkoutSessionImplCopyWith<_$WorkoutSessionImpl> get copyWith =>
      __$$WorkoutSessionImplCopyWithImpl<_$WorkoutSessionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WorkoutSessionImplToJson(
      this,
    );
  }
}

abstract class _WorkoutSession implements WorkoutSession {
  const factory _WorkoutSession(
      {required final String id,
      required final String exerciseId,
      required final int levelIndex,
      required final List<int> targetRepsPerSet,
      final List<SetAttempt> attempts,
      final DateTime? startedAt,
      final DateTime? endedAt,
      final bool passed,
      final int? difficulty}) = _$WorkoutSessionImpl;

  factory _WorkoutSession.fromJson(Map<String, dynamic> json) =
      _$WorkoutSessionImpl.fromJson;

  @override
  String get id;
  @override
  String get exerciseId;
  @override
  int get levelIndex;
  @override
  List<int> get targetRepsPerSet;
  @override
  List<SetAttempt> get attempts;
  @override
  DateTime? get startedAt;
  @override
  DateTime? get endedAt;
  @override
  bool get passed;
  @override
  int? get difficulty;
  @override
  @JsonKey(ignore: true)
  _$$WorkoutSessionImplCopyWith<_$WorkoutSessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
