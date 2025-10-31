// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TimerSettingsImpl _$$TimerSettingsImplFromJson(Map<String, dynamic> json) =>
    _$TimerSettingsImpl(
      defaultRestSeconds: (json['defaultRestSeconds'] as num?)?.toInt() ?? 90,
      preciseAlarms: json['preciseAlarms'] as bool? ?? false,
      beeps: $enumDecodeNullable(_$CountdownBeepsEnumMap, json['beeps']) ??
          CountdownBeeps.last3,
    );

Map<String, dynamic> _$$TimerSettingsImplToJson(_$TimerSettingsImpl instance) =>
    <String, dynamic>{
      'defaultRestSeconds': instance.defaultRestSeconds,
      'preciseAlarms': instance.preciseAlarms,
      'beeps': _$CountdownBeepsEnumMap[instance.beeps]!,
    };

const _$CountdownBeepsEnumMap = {
  CountdownBeeps.off: 'off',
  CountdownBeeps.last3: 'last3',
  CountdownBeeps.last10: 'last10',
};
