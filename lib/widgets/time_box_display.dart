import 'package:e_sound_reminder_app/widgets/custom_text_title.dart';
import 'package:flutter/material.dart';

import 'custom_text_normal.dart';

class TimeBoxDisplay extends StatelessWidget {
  final String text;
  final Widget? icon;
  final bool largeTxt;
  final Color? color;
  final TextAlign? textAlign;

  const TimeBoxDisplay(
      {Key? key,
      required this.text,
      this.icon,
      this.largeTxt = false,
      this.color,
      this.textAlign})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: icon != null
          ? EdgeInsets.fromLTRB(6, 6, 10, 6)
          : EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: color ?? Colors.green[800]!),
          borderRadius: BorderRadius.all(Radius.circular(16.0))),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon ?? const SizedBox.shrink(),
            largeTxt
                ? Flexible(
                    child: CusTitleText(text,
                        textAlign: textAlign ?? TextAlign.center, color: color))
                : Flexible(
                    child: CusNText(text,
                        textAlign: textAlign ?? TextAlign.center, color: color))
          ]),
    );
  }
}
