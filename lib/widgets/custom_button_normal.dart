import 'package:flutter/material.dart';

import '../utils/constants.dart';

class CusNButton extends StatefulWidget {
  final String text;
  Widget? icon;
  VoidCallback? onPressed;
  bool disabled = false;
  bool readOnly = false;

  CusNButton(this.text, this.onPressed,
      {this.icon, this.disabled = false, this.readOnly = false});

  @override
  _CusNButtonState createState() =>
      _CusNButtonState(text, onPressed, icon, disabled, readOnly);
}

class _CusNButtonState extends State<CusNButton> {
  String text;
  VoidCallback? onPressed;
  Widget? icon;
  bool disabled;
  bool readOnly;

  _CusNButtonState(
      this.text, this.onPressed, this.icon, this.disabled, this.readOnly);

  @override
  Widget build(BuildContext context) {
    ButtonStyle btnStyle() {
      return ElevatedButton.styleFrom(
        backgroundColor: readOnly ? Colors.white : null,
        surfaceTintColor: readOnly ? Colors.white : null,
        foregroundColor: readOnly ? Colors.black : null,
        textStyle:
            const TextStyle(fontSize: textBtnSize, fontWeight: FontWeight.bold),
        minimumSize: const Size.fromHeight(60),
        side: BorderSide(
          color: Colors.green[900]!,
          width: 1.0,
        ),
      );
    }

    if (widget.icon != null) {
      return ElevatedButton.icon(
        icon: widget.icon!,
        style: btnStyle(),
        onPressed: disabled ? null : widget.onPressed,
        label: Text(widget.text),
      );
    }
    return ElevatedButton(
      style: btnStyle(),
      onPressed: disabled ? null : widget.onPressed,
      child: Text(widget.text),
    );
  }
}
