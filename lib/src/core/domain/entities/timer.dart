import 'package:freezed_annotation/freezed_annotation.dart';

part 'timer.freezed.dart';
part 'timer.g.dart';

enum CountdownBeeps { off, last3, last10 }

@freezed
class TimerSettings with _$TimerSettings {
  const factory TimerSettings({
    @Default(90) int defaultRestSeconds,
    @Default(false) bool preciseAlarms,
    // When enabled, keeps the device screen awake during rest periods.
    @Default(false) bool keepAwakeDuringRest,
    @Default(CountdownBeeps.last3) CountdownBeeps beeps,
  }) = _TimerSettings;

  factory TimerSettings.fromJson(Map<String, dynamic> json) => _$TimerSettingsFromJson(json);
}
