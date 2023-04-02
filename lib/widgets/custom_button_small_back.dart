import 'package:flutter/material.dart';

import '../utils/constants.dart';

class CusSBackButton extends StatefulWidget {
  final String text;
  Widget? icon;
  VoidCallback? onPressed;

  CusSBackButton(this.text, this.onPressed, {this.icon});

  @override
  _CusSBackButtonState createState() =>
      _CusSBackButtonState(text, onPressed, icon);
}

class _CusSBackButtonState extends State<CusSBackButton> {
  String text;
  VoidCallback? onPressed;
  Widget? icon;

  final ButtonStyle btnstyle = ElevatedButton.styleFrom(
    foregroundColor: buttonForegroundColor2,
    textStyle: const TextStyle(
        fontSize: textBtnSmallSize, fontWeight: FontWeight.bold),
    minimumSize: const Size.fromHeight(buttonHeightSmall),
    side: BorderSide(
      color: buttonBorderColor2,
      width: buttonBorderWidth,
    ),
  );

  _CusSBackButtonState(this.text, this.onPressed, this.icon);

  @override
  Widget build(BuildContext context) {
    if (widget.icon != null) {
      return ElevatedButton.icon(
        icon: widget.icon!,
        style: btnstyle,
        onPressed: widget.onPressed,
        label: Text(widget.text),
      );
    }
    return ElevatedButton(
      style: btnstyle,
      onPressed: widget.onPressed,
      child: Text(
        widget.text,
        textAlign: TextAlign.center,
      ),
    );
  }
}
