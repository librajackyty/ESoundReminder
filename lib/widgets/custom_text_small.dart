import 'package:flutter/material.dart';

import '../utils/constants.dart';

class CusSText extends StatefulWidget {
  final String text;
  Color? color;
  TextAlign? textAlign;

  CusSText(this.text, {Key? key, this.color, this.textAlign}) : super(key: key);

  @override
  _CusSTextState createState() => _CusSTextState();
}

class _CusSTextState extends State<CusSText> {
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
