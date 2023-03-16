import 'package:flutter/material.dart';

import '../utils/constants.dart';

class CusSButton extends StatefulWidget {
  final String text;
  Widget? icon;
  VoidCallback? onPressed;

  CusSButton(this.text, this.onPressed, {this.icon});

  @override
  _CusSButtonState createState() => _CusSButtonState(text, onPressed!, icon);
}

class _CusSButtonState extends State<CusSButton> {
  String text;
  VoidCallback onPressed;
  Widget? icon;

  final ButtonStyle backstyle = ElevatedButton.styleFrom(
    textStyle: const TextStyle(
        fontSize: textBtnSmallSize, fontWeight: FontWeight.bold),
    minimumSize: const Size.fromHeight(40),
    side: BorderSide(
      color: Colors.green[900]!,
      width: 1.0,
    ),
  );

  _CusSButtonState(this.text, this.onPressed, this.icon);

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
