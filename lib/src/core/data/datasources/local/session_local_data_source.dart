import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

const _kSessionsKey = 'sessions';

class SessionLocalDataSource {
  Future<List<Map<String, dynamic>>> load() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString(_kSessionsKey);
    if (jsonStr == null) return [];
    final raw = json.decode(jsonStr) as List<dynamic>;
    return raw
        .map<Map<String, dynamic>>(
          (item) => Map<String, dynamic>.from(item as Map),
        )
        .toList();
  }

  Future<void> save(List<Map<String, dynamic>> list) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kSessionsKey, json.encode(list));
  }
}
