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

  // time picker
  static const int codeTimepickerStyle1 = 1;
  static const int codeTimepickerStyle2 = 2;

  static currenTimepickerStyle(BuildContext context) {
    return of(context)?.timepickerStyle;
  }

  static updateTimepickerStyle(BuildContext context, int style) {
    of(context)?.saveTimepickerStyle(style);
  }

  // tutorial setting
  static const int codeTutorialModeInitial = 0; // 1st time show tutorial
  static const int codeTutorialModeOn = 1; // should show tutorial
  static const int codeTutorialModeOff = 2; // stop auto show show tutorial

  static currenTutorialSetting(BuildContext context) {
    return of(context)?.tutorialSetting;
  }

  static updateTutorialSetting(BuildContext context, int setting) {
    of(context)?.saveTutorialSetting(setting);
  }
}
