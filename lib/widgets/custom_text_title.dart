import 'package:flutter/material.dart';

import '../utils/constants.dart';

class CusTitleText extends StatefulWidget {
  final String text;

  CusTitleText(this.text);

  @override
  _CusTitleTextState createState() => _CusTitleTextState(text);
}

class _CusTitleTextState extends State<CusTitleText> {
  String text;

  _CusTitleTextState(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(widget.text, style: TextStyle(fontSize: textTitleSize));
  }
}
