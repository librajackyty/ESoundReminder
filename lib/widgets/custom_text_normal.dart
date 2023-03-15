import 'package:flutter/material.dart';

import '../utils/constants.dart';

class CusNText extends StatefulWidget {
  final String text;

  CusNText(this.text);

  @override
  _CusNTextState createState() => _CusNTextState(text);
}

class _CusNTextState extends State<CusNText> {
  String text;

  _CusNTextState(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(widget.text, style: TextStyle(fontSize: textNormalSize));
  }
}
