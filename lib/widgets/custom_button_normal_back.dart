import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../utils/feedback.dart';

class CusNBackButton extends StatefulWidget {
  final String text;
  Widget? icon;
  VoidCallback? onPressed;

  CusNBackButton(this.text, this.onPressed, {this.icon});

  @override
  _CusNBackButtonState createState() =>
      _CusNBackButtonState(text, onPressed, icon);
}

class _CusNBackButtonState extends State<CusNBackButton> {
  String text;
  VoidCallback? onPressed;
  Widget? icon;

  _CusNBackButtonState(this.text, this.onPressed, this.icon);

  @override
  Widget build(BuildContext context) {
    ButtonStyle backstyle = ElevatedButton.styleFrom(
      padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
      foregroundColor: buttonForegroundColor2,
      textStyle: const TextStyle(fontSize: textBtnSize),
      minimumSize: const Size.fromHeight(buttonHeight),
      side: BorderSide(
        color: buttonBorderColor2,
        width: buttonBorderWidth,
      ),
    );

    if (widget.icon != null) {
      return ElevatedButton.icon(
        icon: widget.icon!,
        style: backstyle,
        onPressed: () {
          widget.onPressed?.call();
          runHapticSound();
        },
        label: Text(
          widget.text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      );
    }
    return ElevatedButton(
      style: backstyle,
      onPressed: () {
        widget.onPressed?.call();
        runHapticSound();
      },
      child: Text(
        widget.text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
