import 'package:flutter/material.dart';

import '../utils/constants.dart';

class CusNBackButton extends StatefulWidget {
  final String text;
  VoidCallback? onPressed;

  CusNBackButton(this.text, this.onPressed);

  @override
  _CusNBackButtonState createState() => _CusNBackButtonState(text, onPressed!);
}

class _CusNBackButtonState extends State<CusNBackButton> {
  String text;
  VoidCallback onPressed;
  final ButtonStyle backstyle = ElevatedButton.styleFrom(
    foregroundColor: Colors.red,
    textStyle: const TextStyle(fontSize: textBtnSize),
    minimumSize: const Size.fromHeight(60),
    side: BorderSide(
      color: Colors.red[900]!,
      width: 1.0,
    ),
  );

  _CusNBackButtonState(this.text, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: backstyle,
      onPressed: widget.onPressed,
      child: Text(widget.text),
    );
  }
}
