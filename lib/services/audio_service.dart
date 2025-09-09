import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

class AudioService {
  static final AudioPlayer _audioPlayer = AudioPlayer();

  // Play bell sound using a simple approach
  static Future<void> playBellSound() async {
    try {
      // Since we don't have audio files, use multiple system sounds with timing
      // to create a bell-like effect

      // First tone
      SystemSound.play(SystemSoundType.alert);

      // Add haptic feedback for better experience
      HapticFeedback.mediumImpact();

      // Second tone with delay
      await Future.delayed(Duration(milliseconds: 150));
      SystemSound.play(SystemSoundType.click);

      // Light haptic feedback
      HapticFeedback.lightImpact();

      // Third subtle tone
      await Future.delayed(Duration(milliseconds: 100));
      HapticFeedback.selectionClick();
    } catch (e) {
      print('Could not play bell sound sequence: $e');
      // Simple fallback
      try {
        SystemSound.play(SystemSoundType.alert);
        HapticFeedback.mediumImpact();
      } catch (e2) {
        print('Could not play fallback sound: $e2');
      }
    }
  }

  // Play notification sound
  static Future<void> playNotificationSound() async {
    try {
      SystemSound.play(SystemSoundType.alert);
      HapticFeedback.mediumImpact();
    } catch (e) {
      print('Could not play notification sound: $e');
    }
  }

  // Play click sound
  static Future<void> playClickSound() async {
    try {
      SystemSound.play(SystemSoundType.click);
      HapticFeedback.selectionClick();
    } catch (e) {
      print('Could not play click sound: $e');
    }
  }

  // Enhanced bell sound with multiple tones
  static Future<void> playEnhancedBellSound() async {
    try {
      // Create a sequence of sounds and haptics for a bell-like experience

      // Initial bell tone
      SystemSound.play(SystemSoundType.alert);
      HapticFeedback.heavyImpact();

      // First echo
      await Future.delayed(Duration(milliseconds: 120));
      SystemSound.play(SystemSoundType.click);
      HapticFeedback.mediumImpact();

      // Second echo
      await Future.delayed(Duration(milliseconds: 100));
      HapticFeedback.lightImpact();

      // Final subtle vibration
      await Future.delayed(Duration(milliseconds: 80));
      HapticFeedback.selectionClick();
    } catch (e) {
      print('Could not play enhanced bell sound: $e');
      // Simple fallback
      SystemSound.play(SystemSoundType.alert);
    }
  }

  // Stop any playing sound
  static Future<void> stopSound() async {
    try {
      await _audioPlayer.stop();
    } catch (e) {
      print('Could not stop sound: $e');
    }
  }

  // Dispose audio player
  static Future<void> dispose() async {
    try {
      await _audioPlayer.dispose();
    } catch (e) {
      print('Could not dispose audio player: $e');
    }
  }
}
