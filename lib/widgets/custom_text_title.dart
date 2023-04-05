import 'package:auto_size_text/auto_size_text.dart';
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
    return AutoSizeText(widget.text,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        textAlign: widget.textAlign,
        style: TextStyle(fontSize: textTitleSize, color: widget.color));
  }
}
