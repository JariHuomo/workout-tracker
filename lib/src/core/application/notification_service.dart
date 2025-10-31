import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final notificationServiceProvider = Provider<NotificationService>((ref) {
  final service = NotificationService();
  unawaited(service.init());
  return service;
});

class NotificationService {
  final _plugin = FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  bool get _isSupportedPlatform {
    if (kIsWeb) return false;
    // flutter_local_notifications does not register a Windows implementation.
    // Guard to avoid LateInitializationError on Windows runner.
    return defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS ||
        defaultTargetPlatform == TargetPlatform.linux;
  }

  Future<void> init() async {
    if (_initialized) return;
    tz.initializeTimeZones();
    if (_isSupportedPlatform) {
      const android = AndroidInitializationSettings('@mipmap/ic_launcher');
      const darwin = DarwinInitializationSettings();
      const init = InitializationSettings(android: android, iOS: darwin);
      await _plugin.initialize(init);
      const channel = AndroidNotificationChannel(
        'rest_timer',
        'Rest Timer',
        description: 'Notifications for rest timer ending',
        importance: Importance.high,
      );
      await _plugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
    }
    _initialized = true;
  }

  Future<void> requestPermissions() async {
    await init();
    if (!_isSupportedPlatform) return;
    await _plugin
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);
    await _plugin
        .resolvePlatformSpecificImplementation<MacOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }

  Future<void> scheduleRestEnd(
    DateTime when, {
    required String sessionId,
  }) async {
    await init();
    if (!_isSupportedPlatform) return;
    await cancelRestEnd(sessionId);
    final tzDate = tz.TZDateTime.from(when, tz.local);
    await _plugin.zonedSchedule(
      _restNotificationId(sessionId),
      'Rest complete',
      'Tap to resume your session',
      tzDate,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'rest_timer',
          'Rest Timer',
          channelDescription: 'Notifications for rest timer ending',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      payload: sessionId,
    );
  }

  Future<void> cancelRestEnd(String sessionId) async {
    await init();
    if (!_isSupportedPlatform) return;
    await _plugin.cancel(_restNotificationId(sessionId));
  }

  int _restNotificationId(String sessionId) => sessionId.hashCode & 0x7fffffff;
}
