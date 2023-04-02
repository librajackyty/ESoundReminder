import 'package:flutter/material.dart';

import '../utils/constants.dart';

class CusSButton extends StatefulWidget {
  final String text;
  Widget? icon;
  VoidCallback? onPressed;

  CusSButton(this.text, this.onPressed, {this.icon});

  @override
  _CusSButtonState createState() => _CusSButtonState(text, onPressed, icon);
}

class _CusSButtonState extends State<CusSButton> {
  String text;
  VoidCallback? onPressed;
  Widget? icon;

  final ButtonStyle btnstyle = ElevatedButton.styleFrom(
    textStyle: const TextStyle(
        fontSize: textBtnSmallSize, fontWeight: FontWeight.bold),
    minimumSize: const Size.fromHeight(buttonHeightSmall),
    side: BorderSide(
      color: buttonBorderColor,
      width: buttonBorderWidth,
    ),
  );

  _CusSButtonState(this.text, this.onPressed, this.icon);

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
