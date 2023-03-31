import 'package:e_sound_reminder_app/widgets/custom_text_title.dart';
import 'package:flutter/material.dart';

import 'custom_text_normal.dart';

class TimeBoxDisplay extends StatelessWidget {
  final String time;
  final Widget? icon;
  final bool largeTxt;

  const TimeBoxDisplay(
      {Key? key, required this.time, this.icon, this.largeTxt = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.green[800]!),
          borderRadius: BorderRadius.all(Radius.circular(16.0))),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        icon ?? const SizedBox(),
        largeTxt ? CusTitleText(time) : CusNText(time)
      ]),
    );
  }
}