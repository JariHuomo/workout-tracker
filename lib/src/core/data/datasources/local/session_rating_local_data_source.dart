import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

const _kSessionRatingsKey = 'session_ratings';

class SessionRatingLocalDataSource {
  Future<Map<String, int>> load() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString(_kSessionRatingsKey);
    if (jsonStr == null) return {};
    final raw = json.decode(jsonStr) as Map<String, dynamic>;
    final map = <String, int>{};
    for (final entry in raw.entries) {
      final v = entry.value;
      if (v is int) map[entry.key] = v;
    }
    return map;
  }

  Future<void> save(Map<String, int> store) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kSessionRatingsKey, json.encode(store));
  }
}
