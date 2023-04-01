import 'package:flutter/material.dart';

class CusExSText extends StatefulWidget {
  final String text;
  Color? color;
  TextAlign? textAlign;

  CusExSText(this.text, {this.color, this.textAlign});

  @override
  _CusExSTextState createState() => _CusExSTextState();
}

class _CusExSTextState extends State<CusExSText> {
  _CusExSTextState();

  @override
  Widget build(BuildContext context) {
    return Text(widget.text,
        textAlign: widget.textAlign, style: TextStyle(color: widget.color));
  }
}
