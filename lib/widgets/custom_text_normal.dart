import 'package:flutter/material.dart';

import '../utils/constants.dart';

class CusNText extends StatefulWidget {
  final String text;
  Color? color;
  TextAlign? textAlign;

  CusNText(this.text, {this.color, this.textAlign});

  @override
  _CusNTextState createState() => _CusNTextState();
}

class _CusNTextState extends State<CusNText> {
  _CusNTextState();

  @override
  Widget build(BuildContext context) {
    return Text(widget.text,
        textAlign: widget.textAlign,
        style: TextStyle(fontSize: textNormalSize, color: widget.color));
  }
}
