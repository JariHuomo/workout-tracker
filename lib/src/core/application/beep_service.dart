import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final beepServiceProvider = Provider<BeepService>((ref) => BeepService());

class BeepService {
  final _audioPlayer = AudioPlayer();

  /// Plays a countdown tick sound for final seconds warning
  Future<void> playCountdownTick() async {
    try {
      await _audioPlayer.play(AssetSource('sounds/countdown_tick.mp3'));
      // Light haptic feedback for countdown ticks
      if (defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS ||
          defaultTargetPlatform == TargetPlatform.macOS) {
        await HapticFeedback.lightImpact();
      }
    } catch (_) {
      // ignore errors triggered on unsupported platforms
    }
  }

  /// Plays rest completion sound with haptic feedback
  Future<void> playRestEndCue() async {
    try {
      await _audioPlayer.play(AssetSource('sounds/rest_complete.mp3'));
    } catch (_) {
      // Fallback to system sound if custom sound fails
      try {
        await SystemSound.play(SystemSoundType.alert);
      } catch (_) {
        // ignore errors triggered on unsupported platforms
      }
    }
    // Medium haptic feedback for rest completion
    if (defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS) {
      await HapticFeedback.mediumImpact();
    }
  }

  /// Dispose audio player resources
  void dispose() {
    _audioPlayer.dispose();
  }
}
