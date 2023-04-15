import 'package:e_sound_reminder_app/utils/constants.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_text_small.dart';

void showSnackMsg(BuildContext context, String msg) {
  removeCurrentSnavkBar(context);
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: elementActiveColor,
    content: CusSText(msg),
  ));
}

void removeCurrentSnavkBar(BuildContext context) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
}
