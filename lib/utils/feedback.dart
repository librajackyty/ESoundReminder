import 'package:flutter/services.dart';

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
  SystemSound.play(SystemSoundType.click);
}
