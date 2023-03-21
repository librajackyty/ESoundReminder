import 'package:flutter/material.dart';

class CusExSText extends StatefulWidget {
  final String text;
  Color? color;

  CusExSText(this.text, {this.color});

  @override
  _CusExSTextState createState() => _CusExSTextState(text, color);
}

class _CusExSTextState extends State<CusExSText> {
  String text;
  Color? color;

  _CusExSTextState(this.text, this.color);

  @override
  Widget build(BuildContext context) {
    return Text(widget.text, style: TextStyle(color: color));
  }
}
