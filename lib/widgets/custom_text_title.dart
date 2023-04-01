import 'package:flutter/material.dart';

import '../utils/constants.dart';

class CusTitleText extends StatefulWidget {
  final String text;
  Color? color;
  TextAlign? textAlign;

  CusTitleText(this.text, {this.color, this.textAlign});

  @override
  _CusTitleTextState createState() => _CusTitleTextState();
}

class _CusTitleTextState extends State<CusTitleText> {
  _CusTitleTextState();

  @override
  Widget build(BuildContext context) {
    return Text(widget.text,
        textAlign: widget.textAlign,
        style: TextStyle(fontSize: textTitleSize, color: widget.color));
  }
}
