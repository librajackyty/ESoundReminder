import 'package:flutter/material.dart';

import '../utils/constants.dart';

class CusNButton extends StatefulWidget {
  final String text;
  VoidCallback? onPressed;

  CusNButton(this.text, this.onPressed);

  @override
  _CusNButtonState createState() => _CusNButtonState(text, onPressed!);
}

class _CusNButtonState extends State<CusNButton> {
  String text;
  VoidCallback onPressed;
  final ButtonStyle backstyle = ElevatedButton.styleFrom(
    textStyle:
        const TextStyle(fontSize: textBtnSize, fontWeight: FontWeight.bold),
    minimumSize: const Size.fromHeight(60),
    side: BorderSide(
      color: Colors.green[900]!,
      width: 1.0,
    ),
  );

  _CusNButtonState(this.text, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: backstyle,
      onPressed: widget.onPressed,
      child: Text(widget.text),
    );
  }
}
