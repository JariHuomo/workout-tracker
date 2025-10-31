import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

const _kTimerSettingsKey = 'timer_settings';

class PrefsLocalDataSource {
  Future<Map<String, dynamic>?> loadTimerSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final str = prefs.getString(_kTimerSettingsKey);
    if (str == null) return null;
    return json.decode(str) as Map<String, dynamic>;
  }

  Future<void> saveTimerSettings(Map<String, dynamic> jsonMap) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kTimerSettingsKey, json.encode(jsonMap));
  }
}
