import 'package:flutter/material.dart';

import '../utils/constants.dart';

class CusSText extends StatefulWidget {
  final String text;
  Color? color;

  CusSText(this.text, {this.color});

  @override
  _CusSTextState createState() => _CusSTextState(text, color);
}

class _CusSTextState extends State<CusSText> {
  String text;
  Color? color;

  _CusSTextState(this.text, this.color);

  @override
  Widget build(BuildContext context) {
    return Text(widget.text,
        style: TextStyle(fontSize: textSmallSize, color: color));
  }
}
