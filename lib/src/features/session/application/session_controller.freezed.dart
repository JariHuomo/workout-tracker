// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SessionState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(WorkoutSession session, int currentSetIndex)
        inProgress,
    required TResult Function(WorkoutSession session, int nextSetIndex,
            DateTime restEndsAt, int remainingSeconds)
        resting,
    required TResult Function(WorkoutSession session) completed,
    required TResult Function(Failure failure) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(WorkoutSession session, int currentSetIndex)? inProgress,
    TResult? Function(WorkoutSession session, int nextSetIndex,
            DateTime restEndsAt, int remainingSeconds)?
        resting,
    TResult? Function(WorkoutSession session)? completed,
    TResult? Function(Failure failure)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(WorkoutSession session, int currentSetIndex)? inProgress,
    TResult Function(WorkoutSession session, int nextSetIndex,
            DateTime restEndsAt, int remainingSeconds)?
        resting,
    TResult Function(WorkoutSession session)? completed,
    TResult Function(Failure failure)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Idle value) idle,
    required TResult Function(_InProgress value) inProgress,
    required TResult Function(_Resting value) resting,
    required TResult Function(_Completed value) completed,
    required TResult Function(_Failure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Idle value)? idle,
    TResult? Function(_InProgress value)? inProgress,
    TResult? Function(_Resting value)? resting,
    TResult? Function(_Completed value)? completed,
    TResult? Function(_Failure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Idle value)? idle,
    TResult Function(_InProgress value)? inProgress,
    TResult Function(_Resting value)? resting,
    TResult Function(_Completed value)? completed,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionStateCopyWith<$Res> {
  factory $SessionStateCopyWith(
          SessionState value, $Res Function(SessionState) then) =
      _$SessionStateCopyWithImpl<$Res, SessionState>;
}

/// @nodoc
class _$SessionStateCopyWithImpl<$Res, $Val extends SessionState>
    implements $SessionStateCopyWith<$Res> {
  _$SessionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SessionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$IdleImplCopyWith<$Res> {
  factory _$$IdleImplCopyWith(
          _$IdleImpl value, $Res Function(_$IdleImpl) then) =
      __$$IdleImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$IdleImplCopyWithImpl<$Res>
    extends _$SessionStateCopyWithImpl<$Res, _$IdleImpl>
    implements _$$IdleImplCopyWith<$Res> {
  __$$IdleImplCopyWithImpl(_$IdleImpl _value, $Res Function(_$IdleImpl) _then)
      : super(_value, _then);

  /// Create a copy of SessionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$IdleImpl implements _Idle {
  const _$IdleImpl();

  @override
  String toString() {
    return 'SessionState.idle()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$IdleImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(WorkoutSession session, int currentSetIndex)
        inProgress,
    required TResult Function(WorkoutSession session, int nextSetIndex,
            DateTime restEndsAt, int remainingSeconds)
        resting,
    required TResult Function(WorkoutSession session) completed,
    required TResult Function(Failure failure) failure,
  }) {
    return idle();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(WorkoutSession session, int currentSetIndex)? inProgress,
    TResult? Function(WorkoutSession session, int nextSetIndex,
            DateTime restEndsAt, int remainingSeconds)?
        resting,
    TResult? Function(WorkoutSession session)? completed,
    TResult? Function(Failure failure)? failure,
  }) {
    return idle?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(WorkoutSession session, int currentSetIndex)? inProgress,
    TResult Function(WorkoutSession session, int nextSetIndex,
            DateTime restEndsAt, int remainingSeconds)?
        resting,
    TResult Function(WorkoutSession session)? completed,
    TResult Function(Failure failure)? failure,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Idle value) idle,
    required TResult Function(_InProgress value) inProgress,
    required TResult Function(_Resting value) resting,
    required TResult Function(_Completed value) completed,
    required TResult Function(_Failure value) failure,
  }) {
    return idle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Idle value)? idle,
    TResult? Function(_InProgress value)? inProgress,
    TResult? Function(_Resting value)? resting,
    TResult? Function(_Completed value)? completed,
    TResult? Function(_Failure value)? failure,
  }) {
    return idle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Idle value)? idle,
    TResult Function(_InProgress value)? inProgress,
    TResult Function(_Resting value)? resting,
    TResult Function(_Completed value)? completed,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle(this);
    }
    return orElse();
  }
}

abstract class _Idle implements SessionState {
  const factory _Idle() = _$IdleImpl;
}

/// @nodoc
abstract class _$$InProgressImplCopyWith<$Res> {
  factory _$$InProgressImplCopyWith(
          _$InProgressImpl value, $Res Function(_$InProgressImpl) then) =
      __$$InProgressImplCopyWithImpl<$Res>;
  @useResult
  $Res call({WorkoutSession session, int currentSetIndex});

  $WorkoutSessionCopyWith<$Res> get session;
}

/// @nodoc
class __$$InProgressImplCopyWithImpl<$Res>
    extends _$SessionStateCopyWithImpl<$Res, _$InProgressImpl>
    implements _$$InProgressImplCopyWith<$Res> {
  __$$InProgressImplCopyWithImpl(
      _$InProgressImpl _value, $Res Function(_$InProgressImpl) _then)
      : super(_value, _then);

  /// Create a copy of SessionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? session = null,
    Object? currentSetIndex = null,
  }) {
    return _then(_$InProgressImpl(
      session: null == session
          ? _value.session
          : session // ignore: cast_nullable_to_non_nullable
              as WorkoutSession,
      currentSetIndex: null == currentSetIndex
          ? _value.currentSetIndex
          : currentSetIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  /// Create a copy of SessionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WorkoutSessionCopyWith<$Res> get session {
    return $WorkoutSessionCopyWith<$Res>(_value.session, (value) {
      return _then(_value.copyWith(session: value));
    });
  }
}

/// @nodoc

class _$InProgressImpl implements _InProgress {
  const _$InProgressImpl(
      {required this.session, required this.currentSetIndex});

  @override
  final WorkoutSession session;
  @override
  final int currentSetIndex;

  @override
  String toString() {
    return 'SessionState.inProgress(session: $session, currentSetIndex: $currentSetIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InProgressImpl &&
            (identical(other.session, session) || other.session == session) &&
            (identical(other.currentSetIndex, currentSetIndex) ||
                other.currentSetIndex == currentSetIndex));
  }

  @override
  int get hashCode => Object.hash(runtimeType, session, currentSetIndex);

  /// Create a copy of SessionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InProgressImplCopyWith<_$InProgressImpl> get copyWith =>
      __$$InProgressImplCopyWithImpl<_$InProgressImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(WorkoutSession session, int currentSetIndex)
        inProgress,
    required TResult Function(WorkoutSession session, int nextSetIndex,
            DateTime restEndsAt, int remainingSeconds)
        resting,
    required TResult Function(WorkoutSession session) completed,
    required TResult Function(Failure failure) failure,
  }) {
    return inProgress(session, currentSetIndex);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(WorkoutSession session, int currentSetIndex)? inProgress,
    TResult? Function(WorkoutSession session, int nextSetIndex,
            DateTime restEndsAt, int remainingSeconds)?
        resting,
    TResult? Function(WorkoutSession session)? completed,
    TResult? Function(Failure failure)? failure,
  }) {
    return inProgress?.call(session, currentSetIndex);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(WorkoutSession session, int currentSetIndex)? inProgress,
    TResult Function(WorkoutSession session, int nextSetIndex,
            DateTime restEndsAt, int remainingSeconds)?
        resting,
    TResult Function(WorkoutSession session)? completed,
    TResult Function(Failure failure)? failure,
    required TResult orElse(),
  }) {
    if (inProgress != null) {
      return inProgress(session, currentSetIndex);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Idle value) idle,
    required TResult Function(_InProgress value) inProgress,
    required TResult Function(_Resting value) resting,
    required TResult Function(_Completed value) completed,
    required TResult Function(_Failure value) failure,
  }) {
    return inProgress(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Idle value)? idle,
    TResult? Function(_InProgress value)? inProgress,
    TResult? Function(_Resting value)? resting,
    TResult? Function(_Completed value)? completed,
    TResult? Function(_Failure value)? failure,
  }) {
    return inProgress?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Idle value)? idle,
    TResult Function(_InProgress value)? inProgress,
    TResult Function(_Resting value)? resting,
    TResult Function(_Completed value)? completed,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) {
    if (inProgress != null) {
      return inProgress(this);
    }
    return orElse();
  }
}

abstract class _InProgress implements SessionState {
  const factory _InProgress(
      {required final WorkoutSession session,
      required final int currentSetIndex}) = _$InProgressImpl;

  WorkoutSession get session;
  int get currentSetIndex;

  /// Create a copy of SessionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InProgressImplCopyWith<_$InProgressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RestingImplCopyWith<$Res> {
  factory _$$RestingImplCopyWith(
          _$RestingImpl value, $Res Function(_$RestingImpl) then) =
      __$$RestingImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {WorkoutSession session,
      int nextSetIndex,
      DateTime restEndsAt,
      int remainingSeconds});

  $WorkoutSessionCopyWith<$Res> get session;
}

/// @nodoc
class __$$RestingImplCopyWithImpl<$Res>
    extends _$SessionStateCopyWithImpl<$Res, _$RestingImpl>
    implements _$$RestingImplCopyWith<$Res> {
  __$$RestingImplCopyWithImpl(
      _$RestingImpl _value, $Res Function(_$RestingImpl) _then)
      : super(_value, _then);

  /// Create a copy of SessionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? session = null,
    Object? nextSetIndex = null,
    Object? restEndsAt = null,
    Object? remainingSeconds = null,
  }) {
    return _then(_$RestingImpl(
      session: null == session
          ? _value.session
          : session // ignore: cast_nullable_to_non_nullable
              as WorkoutSession,
      nextSetIndex: null == nextSetIndex
          ? _value.nextSetIndex
          : nextSetIndex // ignore: cast_nullable_to_non_nullable
              as int,
      restEndsAt: null == restEndsAt
          ? _value.restEndsAt
          : restEndsAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      remainingSeconds: null == remainingSeconds
          ? _value.remainingSeconds
          : remainingSeconds // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  /// Create a copy of SessionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WorkoutSessionCopyWith<$Res> get session {
    return $WorkoutSessionCopyWith<$Res>(_value.session, (value) {
      return _then(_value.copyWith(session: value));
    });
  }
}

/// @nodoc

class _$RestingImpl implements _Resting {
  const _$RestingImpl(
      {required this.session,
      required this.nextSetIndex,
      required this.restEndsAt,
      required this.remainingSeconds});

  @override
  final WorkoutSession session;
  @override
  final int nextSetIndex;
  @override
  final DateTime restEndsAt;
  @override
  final int remainingSeconds;

  @override
  String toString() {
    return 'SessionState.resting(session: $session, nextSetIndex: $nextSetIndex, restEndsAt: $restEndsAt, remainingSeconds: $remainingSeconds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RestingImpl &&
            (identical(other.session, session) || other.session == session) &&
            (identical(other.nextSetIndex, nextSetIndex) ||
                other.nextSetIndex == nextSetIndex) &&
            (identical(other.restEndsAt, restEndsAt) ||
                other.restEndsAt == restEndsAt) &&
            (identical(other.remainingSeconds, remainingSeconds) ||
                other.remainingSeconds == remainingSeconds));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, session, nextSetIndex, restEndsAt, remainingSeconds);

  /// Create a copy of SessionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RestingImplCopyWith<_$RestingImpl> get copyWith =>
      __$$RestingImplCopyWithImpl<_$RestingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(WorkoutSession session, int currentSetIndex)
        inProgress,
    required TResult Function(WorkoutSession session, int nextSetIndex,
            DateTime restEndsAt, int remainingSeconds)
        resting,
    required TResult Function(WorkoutSession session) completed,
    required TResult Function(Failure failure) failure,
  }) {
    return resting(session, nextSetIndex, restEndsAt, remainingSeconds);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(WorkoutSession session, int currentSetIndex)? inProgress,
    TResult? Function(WorkoutSession session, int nextSetIndex,
            DateTime restEndsAt, int remainingSeconds)?
        resting,
    TResult? Function(WorkoutSession session)? completed,
    TResult? Function(Failure failure)? failure,
  }) {
    return resting?.call(session, nextSetIndex, restEndsAt, remainingSeconds);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(WorkoutSession session, int currentSetIndex)? inProgress,
    TResult Function(WorkoutSession session, int nextSetIndex,
            DateTime restEndsAt, int remainingSeconds)?
        resting,
    TResult Function(WorkoutSession session)? completed,
    TResult Function(Failure failure)? failure,
    required TResult orElse(),
  }) {
    if (resting != null) {
      return resting(session, nextSetIndex, restEndsAt, remainingSeconds);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Idle value) idle,
    required TResult Function(_InProgress value) inProgress,
    required TResult Function(_Resting value) resting,
    required TResult Function(_Completed value) completed,
    required TResult Function(_Failure value) failure,
  }) {
    return resting(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Idle value)? idle,
    TResult? Function(_InProgress value)? inProgress,
    TResult? Function(_Resting value)? resting,
    TResult? Function(_Completed value)? completed,
    TResult? Function(_Failure value)? failure,
  }) {
    return resting?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Idle value)? idle,
    TResult Function(_InProgress value)? inProgress,
    TResult Function(_Resting value)? resting,
    TResult Function(_Completed value)? completed,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) {
    if (resting != null) {
      return resting(this);
    }
    return orElse();
  }
}

abstract class _Resting implements SessionState {
  const factory _Resting(
      {required final WorkoutSession session,
      required final int nextSetIndex,
      required final DateTime restEndsAt,
      required final int remainingSeconds}) = _$RestingImpl;

  WorkoutSession get session;
  int get nextSetIndex;
  DateTime get restEndsAt;
  int get remainingSeconds;

  /// Create a copy of SessionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RestingImplCopyWith<_$RestingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CompletedImplCopyWith<$Res> {
  factory _$$CompletedImplCopyWith(
          _$CompletedImpl value, $Res Function(_$CompletedImpl) then) =
      __$$CompletedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({WorkoutSession session});

  $WorkoutSessionCopyWith<$Res> get session;
}

/// @nodoc
class __$$CompletedImplCopyWithImpl<$Res>
    extends _$SessionStateCopyWithImpl<$Res, _$CompletedImpl>
    implements _$$CompletedImplCopyWith<$Res> {
  __$$CompletedImplCopyWithImpl(
      _$CompletedImpl _value, $Res Function(_$CompletedImpl) _then)
      : super(_value, _then);

  /// Create a copy of SessionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? session = null,
  }) {
    return _then(_$CompletedImpl(
      session: null == session
          ? _value.session
          : session // ignore: cast_nullable_to_non_nullable
              as WorkoutSession,
    ));
  }

  /// Create a copy of SessionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WorkoutSessionCopyWith<$Res> get session {
    return $WorkoutSessionCopyWith<$Res>(_value.session, (value) {
      return _then(_value.copyWith(session: value));
    });
  }
}

/// @nodoc

class _$CompletedImpl implements _Completed {
  const _$CompletedImpl({required this.session});

  @override
  final WorkoutSession session;

  @override
  String toString() {
    return 'SessionState.completed(session: $session)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CompletedImpl &&
            (identical(other.session, session) || other.session == session));
  }

  @override
  int get hashCode => Object.hash(runtimeType, session);

  /// Create a copy of SessionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CompletedImplCopyWith<_$CompletedImpl> get copyWith =>
      __$$CompletedImplCopyWithImpl<_$CompletedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(WorkoutSession session, int currentSetIndex)
        inProgress,
    required TResult Function(WorkoutSession session, int nextSetIndex,
            DateTime restEndsAt, int remainingSeconds)
        resting,
    required TResult Function(WorkoutSession session) completed,
    required TResult Function(Failure failure) failure,
  }) {
    return completed(session);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(WorkoutSession session, int currentSetIndex)? inProgress,
    TResult? Function(WorkoutSession session, int nextSetIndex,
            DateTime restEndsAt, int remainingSeconds)?
        resting,
    TResult? Function(WorkoutSession session)? completed,
    TResult? Function(Failure failure)? failure,
  }) {
    return completed?.call(session);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(WorkoutSession session, int currentSetIndex)? inProgress,
    TResult Function(WorkoutSession session, int nextSetIndex,
            DateTime restEndsAt, int remainingSeconds)?
        resting,
    TResult Function(WorkoutSession session)? completed,
    TResult Function(Failure failure)? failure,
    required TResult orElse(),
  }) {
    if (completed != null) {
      return completed(session);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Idle value) idle,
    required TResult Function(_InProgress value) inProgress,
    required TResult Function(_Resting value) resting,
    required TResult Function(_Completed value) completed,
    required TResult Function(_Failure value) failure,
  }) {
    return completed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Idle value)? idle,
    TResult? Function(_InProgress value)? inProgress,
    TResult? Function(_Resting value)? resting,
    TResult? Function(_Completed value)? completed,
    TResult? Function(_Failure value)? failure,
  }) {
    return completed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Idle value)? idle,
    TResult Function(_InProgress value)? inProgress,
    TResult Function(_Resting value)? resting,
    TResult Function(_Completed value)? completed,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) {
    if (completed != null) {
      return completed(this);
    }
    return orElse();
  }
}

abstract class _Completed implements SessionState {
  const factory _Completed({required final WorkoutSession session}) =
      _$CompletedImpl;

  WorkoutSession get session;

  /// Create a copy of SessionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CompletedImplCopyWith<_$CompletedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FailureImplCopyWith<$Res> {
  factory _$$FailureImplCopyWith(
          _$FailureImpl value, $Res Function(_$FailureImpl) then) =
      __$$FailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Failure failure});

  $FailureCopyWith<$Res> get failure;
}

/// @nodoc
class __$$FailureImplCopyWithImpl<$Res>
    extends _$SessionStateCopyWithImpl<$Res, _$FailureImpl>
    implements _$$FailureImplCopyWith<$Res> {
  __$$FailureImplCopyWithImpl(
      _$FailureImpl _value, $Res Function(_$FailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of SessionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? failure = null,
  }) {
    return _then(_$FailureImpl(
      failure: null == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure,
    ));
  }

  /// Create a copy of SessionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FailureCopyWith<$Res> get failure {
    return $FailureCopyWith<$Res>(_value.failure, (value) {
      return _then(_value.copyWith(failure: value));
    });
  }
}

/// @nodoc

class _$FailureImpl implements _Failure {
  const _$FailureImpl({required this.failure});

  @override
  final Failure failure;

  @override
  String toString() {
    return 'SessionState.failure(failure: $failure)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailureImpl &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(runtimeType, failure);

  /// Create a copy of SessionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FailureImplCopyWith<_$FailureImpl> get copyWith =>
      __$$FailureImplCopyWithImpl<_$FailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(WorkoutSession session, int currentSetIndex)
        inProgress,
    required TResult Function(WorkoutSession session, int nextSetIndex,
            DateTime restEndsAt, int remainingSeconds)
        resting,
    required TResult Function(WorkoutSession session) completed,
    required TResult Function(Failure failure) failure,
  }) {
    return failure(this.failure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(WorkoutSession session, int currentSetIndex)? inProgress,
    TResult? Function(WorkoutSession session, int nextSetIndex,
            DateTime restEndsAt, int remainingSeconds)?
        resting,
    TResult? Function(WorkoutSession session)? completed,
    TResult? Function(Failure failure)? failure,
  }) {
    return failure?.call(this.failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(WorkoutSession session, int currentSetIndex)? inProgress,
    TResult Function(WorkoutSession session, int nextSetIndex,
            DateTime restEndsAt, int remainingSeconds)?
        resting,
    TResult Function(WorkoutSession session)? completed,
    TResult Function(Failure failure)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this.failure);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Idle value) idle,
    required TResult Function(_InProgress value) inProgress,
    required TResult Function(_Resting value) resting,
    required TResult Function(_Completed value) completed,
    required TResult Function(_Failure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Idle value)? idle,
    TResult? Function(_InProgress value)? inProgress,
    TResult? Function(_Resting value)? resting,
    TResult? Function(_Completed value)? completed,
    TResult? Function(_Failure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Idle value)? idle,
    TResult Function(_InProgress value)? inProgress,
    TResult Function(_Resting value)? resting,
    TResult Function(_Completed value)? completed,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class _Failure implements SessionState {
  const factory _Failure({required final Failure failure}) = _$FailureImpl;

  Failure get failure;

  /// Create a copy of SessionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FailureImplCopyWith<_$FailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
