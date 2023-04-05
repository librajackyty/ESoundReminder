import 'package:flutter/services.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

import 'assetslink.dart';

enum HapticFeedbackType { vibrate, onselection, heavy, medium, light }

void runHapticSound({HapticFeedbackType type = HapticFeedbackType.light}) {
  switch (type) {
    case HapticFeedbackType.heavy:
      HapticFeedback.heavyImpact();
      break;
    case HapticFeedbackType.medium:
      HapticFeedback.mediumImpact();
      break;
    case HapticFeedbackType.light:
      HapticFeedback.lightImpact();
      break;
    case HapticFeedbackType.onselection:
      HapticFeedback.selectionClick();
      break;
    case HapticFeedbackType.vibrate:
      HapticFeedback.vibrate();
      break;
    default:
      HapticFeedback.lightImpact();
  }
  // SystemSound.play(SystemSoundType.click);
  Future.delayed(Duration.zero, () {
    FlutterRingtonePlayer.play(fromAsset: assetslinkSounds("tap"));
  });
}

void runSaveFeedback() {
  HapticFeedback.heavyImpact();
  FlutterRingtonePlayer.play(fromAsset: assetslinkSounds("success"));
}

void runDeleteFeedback() {
  HapticFeedback.heavyImpact();
  FlutterRingtonePlayer.play(fromAsset: assetslinkSounds("remove"));
}
