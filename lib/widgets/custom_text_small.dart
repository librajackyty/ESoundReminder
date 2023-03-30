import 'package:flutter/material.dart';

import '../utils/constants.dart';

class CusSText extends StatefulWidget {
  final String text;
  Color? color;
  TextAlign? textAlign;

  CusSText(this.text, {this.color, this.textAlign});

  @override
  _CusSTextState createState() => _CusSTextState();
}

class _CusSTextState extends State<CusSText> {
  // String text;
  // Color? color;

  _CusSTextState();

  @override
  Widget build(BuildContext context) {
    return Text(widget.text,
        textAlign: widget.textAlign,
        style: TextStyle(
          fontSize: textSmallSize,
          color: widget.color,
        ));
  }
}
