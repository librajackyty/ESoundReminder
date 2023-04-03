import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../utils/feedback.dart';

class CusSBackButton extends StatefulWidget {
  final String text;
  Widget? icon;
  VoidCallback? onPressed;
  bool maxWidth;

  CusSBackButton(this.text, this.onPressed, {this.icon, this.maxWidth = true});

  @override
  _CusSBackButtonState createState() =>
      _CusSBackButtonState(text, onPressed, icon, maxWidth);
}

class _CusSBackButtonState extends State<CusSBackButton> {
  String text;
  VoidCallback? onPressed;
  Widget? icon;
  bool maxWidth;

  _CusSBackButtonState(this.text, this.onPressed, this.icon, this.maxWidth);

  @override
  Widget build(BuildContext context) {
    ButtonStyle btnstyle = ElevatedButton.styleFrom(
      foregroundColor: buttonForegroundColor2,
      textStyle: const TextStyle(
          fontSize: textBtnSmallSize, fontWeight: FontWeight.bold),
      minimumSize: maxWidth
          ? const Size.fromHeight(buttonHeightSmall)
          : Size(buttonWidthSmall, buttonHeightSmall),
      side: BorderSide(
        color: buttonBorderColor2,
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
          maxLines: 1,
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
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
