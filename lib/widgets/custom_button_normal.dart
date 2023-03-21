import 'package:flutter/material.dart';

import '../utils/constants.dart';

class CusNButton extends StatefulWidget {
  final String text;
  Widget? icon;
  VoidCallback? onPressed;
  bool disabled = false;

  CusNButton(this.text, this.onPressed, {this.icon, this.disabled = false});

  @override
  _CusNButtonState createState() =>
      _CusNButtonState(text, onPressed, icon, disabled);
}

class _CusNButtonState extends State<CusNButton> {
  String text;
  VoidCallback? onPressed;
  Widget? icon;
  bool disabled;

  final ButtonStyle btnstyle = ElevatedButton.styleFrom(
    textStyle:
        const TextStyle(fontSize: textBtnSize, fontWeight: FontWeight.bold),
    minimumSize: const Size.fromHeight(60),
    side: BorderSide(
      color: Colors.green[900]!,
      width: 1.0,
    ),
  );

  _CusNButtonState(this.text, this.onPressed, this.icon, this.disabled);

  @override
  Widget build(BuildContext context) {
    if (widget.icon != null) {
      return ElevatedButton.icon(
        icon: widget.icon!,
        style: btnstyle,
        onPressed: disabled ? null : widget.onPressed,
        label: Text(widget.text),
      );
    }
    return ElevatedButton(
      style: btnstyle,
      onPressed: disabled ? null : widget.onPressed,
      child: Text(widget.text),
    );
  }
}
