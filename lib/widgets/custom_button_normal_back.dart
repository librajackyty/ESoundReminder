import 'package:flutter/material.dart';

import '../utils/constants.dart';

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

  final ButtonStyle backstyle = ElevatedButton.styleFrom(
    foregroundColor: buttonForegroundColor2,
    textStyle: const TextStyle(fontSize: textBtnSize),
    minimumSize: const Size.fromHeight(buttonHeight),
    side: BorderSide(
      color: buttonBorderColor2,
      width: buttonBorderWidth,
    ),
  );

  _CusNBackButtonState(this.text, this.onPressed, this.icon);

  @override
  Widget build(BuildContext context) {
    if (widget.icon != null) {
      return ElevatedButton.icon(
        icon: widget.icon!,
        style: backstyle,
        onPressed: widget.onPressed,
        label: Text(widget.text),
      );
    }
    return ElevatedButton(
      style: backstyle,
      onPressed: widget.onPressed,
      child: Text(widget.text),
    );
  }
}
