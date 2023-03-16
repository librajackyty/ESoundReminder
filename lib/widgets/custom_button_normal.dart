import 'package:flutter/material.dart';

import '../utils/constants.dart';

class CusNButton extends StatefulWidget {
  final String text;
  Widget? icon;
  VoidCallback? onPressed;

  CusNButton(this.text, this.onPressed, {this.icon});

  @override
  _CusNButtonState createState() => _CusNButtonState(text, onPressed!, icon);
}

class _CusNButtonState extends State<CusNButton> {
  String text;
  VoidCallback onPressed;
  Widget? icon;

  final ButtonStyle backstyle = ElevatedButton.styleFrom(
    textStyle:
        const TextStyle(fontSize: textBtnSize, fontWeight: FontWeight.bold),
    minimumSize: const Size.fromHeight(60),
    side: BorderSide(
      color: Colors.green[900]!,
      width: 1.0,
    ),
  );

  _CusNButtonState(this.text, this.onPressed, this.icon);

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
