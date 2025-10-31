// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'timer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TimerSettings _$TimerSettingsFromJson(Map<String, dynamic> json) {
  return _TimerSettings.fromJson(json);
}

/// @nodoc
mixin _$TimerSettings {
  int get defaultRestSeconds => throw _privateConstructorUsedError;
  bool get preciseAlarms =>
      throw _privateConstructorUsedError; // When enabled, keeps the device screen awake during rest periods.
  bool get keepAwakeDuringRest => throw _privateConstructorUsedError;
  CountdownBeeps get beeps => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TimerSettingsCopyWith<TimerSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimerSettingsCopyWith<$Res> {
  factory $TimerSettingsCopyWith(
          TimerSettings value, $Res Function(TimerSettings) then) =
      _$TimerSettingsCopyWithImpl<$Res, TimerSettings>;
  @useResult
  $Res call(
      {int defaultRestSeconds,
      bool preciseAlarms,
      bool keepAwakeDuringRest,
      CountdownBeeps beeps});
}

/// @nodoc
class _$TimerSettingsCopyWithImpl<$Res, $Val extends TimerSettings>
    implements $TimerSettingsCopyWith<$Res> {
  _$TimerSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? defaultRestSeconds = null,
    Object? preciseAlarms = null,
    Object? keepAwakeDuringRest = null,
    Object? beeps = null,
  }) {
    return _then(_value.copyWith(
      defaultRestSeconds: null == defaultRestSeconds
          ? _value.defaultRestSeconds
          : defaultRestSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      preciseAlarms: null == preciseAlarms
          ? _value.preciseAlarms
          : preciseAlarms // ignore: cast_nullable_to_non_nullable
              as bool,
      keepAwakeDuringRest: null == keepAwakeDuringRest
          ? _value.keepAwakeDuringRest
          : keepAwakeDuringRest // ignore: cast_nullable_to_non_nullable
              as bool,
      beeps: null == beeps
          ? _value.beeps
          : beeps // ignore: cast_nullable_to_non_nullable
              as CountdownBeeps,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TimerSettingsImplCopyWith<$Res>
    implements $TimerSettingsCopyWith<$Res> {
  factory _$$TimerSettingsImplCopyWith(
          _$TimerSettingsImpl value, $Res Function(_$TimerSettingsImpl) then) =
      __$$TimerSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int defaultRestSeconds,
      bool preciseAlarms,
      bool keepAwakeDuringRest,
      CountdownBeeps beeps});
}

/// @nodoc
class __$$TimerSettingsImplCopyWithImpl<$Res>
    extends _$TimerSettingsCopyWithImpl<$Res, _$TimerSettingsImpl>
    implements _$$TimerSettingsImplCopyWith<$Res> {
  __$$TimerSettingsImplCopyWithImpl(
      _$TimerSettingsImpl _value, $Res Function(_$TimerSettingsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? defaultRestSeconds = null,
    Object? preciseAlarms = null,
    Object? keepAwakeDuringRest = null,
    Object? beeps = null,
  }) {
    return _then(_$TimerSettingsImpl(
      defaultRestSeconds: null == defaultRestSeconds
          ? _value.defaultRestSeconds
          : defaultRestSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      preciseAlarms: null == preciseAlarms
          ? _value.preciseAlarms
          : preciseAlarms // ignore: cast_nullable_to_non_nullable
              as bool,
      keepAwakeDuringRest: null == keepAwakeDuringRest
          ? _value.keepAwakeDuringRest
          : keepAwakeDuringRest // ignore: cast_nullable_to_non_nullable
              as bool,
      beeps: null == beeps
          ? _value.beeps
          : beeps // ignore: cast_nullable_to_non_nullable
              as CountdownBeeps,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TimerSettingsImpl implements _TimerSettings {
  const _$TimerSettingsImpl(
      {this.defaultRestSeconds = 90,
      this.preciseAlarms = false,
      this.keepAwakeDuringRest = false,
      this.beeps = CountdownBeeps.last3});

  factory _$TimerSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$TimerSettingsImplFromJson(json);

  @override
  @JsonKey()
  final int defaultRestSeconds;
  @override
  @JsonKey()
  final bool preciseAlarms;
// When enabled, keeps the device screen awake during rest periods.
  @override
  @JsonKey()
  final bool keepAwakeDuringRest;
  @override
  @JsonKey()
  final CountdownBeeps beeps;

  @override
  String toString() {
    return 'TimerSettings(defaultRestSeconds: $defaultRestSeconds, preciseAlarms: $preciseAlarms, keepAwakeDuringRest: $keepAwakeDuringRest, beeps: $beeps)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimerSettingsImpl &&
            (identical(other.defaultRestSeconds, defaultRestSeconds) ||
                other.defaultRestSeconds == defaultRestSeconds) &&
            (identical(other.preciseAlarms, preciseAlarms) ||
                other.preciseAlarms == preciseAlarms) &&
            (identical(other.keepAwakeDuringRest, keepAwakeDuringRest) ||
                other.keepAwakeDuringRest == keepAwakeDuringRest) &&
            (identical(other.beeps, beeps) || other.beeps == beeps));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, defaultRestSeconds,
      preciseAlarms, keepAwakeDuringRest, beeps);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TimerSettingsImplCopyWith<_$TimerSettingsImpl> get copyWith =>
      __$$TimerSettingsImplCopyWithImpl<_$TimerSettingsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TimerSettingsImplToJson(
      this,
    );
  }
}

abstract class _TimerSettings implements TimerSettings {
  const factory _TimerSettings(
      {final int defaultRestSeconds,
      final bool preciseAlarms,
      final bool keepAwakeDuringRest,
      final CountdownBeeps beeps}) = _$TimerSettingsImpl;

  factory _TimerSettings.fromJson(Map<String, dynamic> json) =
      _$TimerSettingsImpl.fromJson;

  @override
  int get defaultRestSeconds;
  @override
  bool get preciseAlarms;
  @override // When enabled, keeps the device screen awake during rest periods.
  bool get keepAwakeDuringRest;
  @override
  CountdownBeeps get beeps;
  @override
  @JsonKey(ignore: true)
  _$$TimerSettingsImplCopyWith<_$TimerSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
