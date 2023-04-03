import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../utils/feedback.dart';

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
        backgroundColor: readOnly ? buttonReadOnlyColor : null,
        surfaceTintColor: readOnly ? buttonReadOnlyColor : null,
        foregroundColor: readOnly ? buttonReadOnlyForegroundColor : null,
        textStyle:
            const TextStyle(fontSize: textBtnSize, fontWeight: FontWeight.bold),
        minimumSize: const Size.fromHeight(buttonHeight),
        side: BorderSide(
          color: buttonBorderColor,
          width: readOnly ? buttonBorderWidthReadOnly : buttonBorderWidth,
        ),
      );
    }

    if (widget.icon != null) {
      return ElevatedButton.icon(
        icon: widget.icon!,
        style: btnStyle(),
        onPressed: disabled
            ? null
            : () {
                if (readOnly) return;
                widget.onPressed?.call();
                runHapticSound();
              },
        label: Text(widget.text),
      );
    }
    return ElevatedButton(
      style: btnStyle(),
      onPressed: disabled
          ? null
          : () {
              if (readOnly) return;
              widget.onPressed?.call();
              runHapticSound();
            },
      child: Text(widget.text),
    );
  }
}
