import 'package:e_sound_reminder_app/providers/displayer_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/text_config.dart';

class Displayer {
  static const String codeSizeL = "L";
  static const String codeSizeM = "M";
  static const String codeSizeS = "S";
  static const Map<String, String> sizeDisplayKey = {
    codeSizeL: "Large",
    codeSizeM: "M",
    codeSizeS: "S"
  };

  // Displayer();

  static DisplayerProvider? of(BuildContext context) {
    return context.read<DisplayerProvider>();
  }

  static currentAppTextSize(BuildContext context) {
    return of(context)?.size;
  }

  static updateAppTextSize(BuildContext context, AppTextSize appTextSize) {
    updateAppTxtSize(size: appTextSize);
    of(context)?.saveAppTextSize(fromTypeToSizeVal(appTextSize));
  }
}
