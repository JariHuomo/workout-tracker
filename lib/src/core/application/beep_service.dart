import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final beepServiceProvider = Provider<BeepService>((ref) => BeepService());

class BeepService {
  Future<void> playRestEndCue() async {
    try {
      await SystemSound.play(SystemSoundType.alert);
    } catch (_) {
      // ignore errors triggered on unsupported platforms
    }
    if (defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS) {
      await HapticFeedback.mediumImpact();
    }
  }
}
