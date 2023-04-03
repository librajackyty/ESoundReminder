import 'package:e_sound_reminder_app/utils/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/constants.dart';

class CusSButton extends StatefulWidget {
  final String text;
  Widget? icon;
  VoidCallback? onPressed;
  bool maxWidth;

  CusSButton(this.text, this.onPressed, {this.icon, this.maxWidth = true});

  @override
  _CusSButtonState createState() =>
      _CusSButtonState(text, onPressed, icon, maxWidth);
}

class _CusSButtonState extends State<CusSButton> {
  String text;
  VoidCallback? onPressed;
  Widget? icon;
  bool maxWidth;

  _CusSButtonState(this.text, this.onPressed, this.icon, this.maxWidth);

  @override
  Widget build(BuildContext context) {
    ButtonStyle btnstyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(
          fontSize: textBtnSmallSize, fontWeight: FontWeight.bold),
      minimumSize: maxWidth
          ? const Size.fromHeight(buttonHeightSmall)
          : Size(buttonWidthSmall, buttonHeightSmall),
      side: BorderSide(
        color: buttonBorderColor,
        width: buttonBorderWidth,
      ),
    );

    if (widget.icon != null) {
      return ElevatedButton.icon(
        icon: widget.icon!,
        style: btnstyle,
        onPressed: () {
          widget.onPressed?.call();
          runHapticSound();
        },
        label: Text(
          widget.text,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      );
    }
    return ElevatedButton(
      style: btnstyle,
      onPressed: () {
        widget.onPressed?.call();
        runHapticSound();
      },
      child: Text(
        widget.text,
        textAlign: TextAlign.center,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
