import 'package:flutter/material.dart';

import '../utils/constants.dart';
import 'custom_text_small.dart';

class CusListItm extends StatefulWidget {
  final IconData iconData;
  final String text;
  VoidCallback? onTap;

  CusListItm(this.iconData, this.text, {this.onTap});

  @override
  _CusListItmState createState() => _CusListItmState(iconData, text, onTap);
}

class _CusListItmState extends State<CusListItm> {
  IconData iconData;
  String text;
  VoidCallback? onTap;

  _CusListItmState(this.iconData, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: InkWell(
        borderRadius: BorderRadius.circular(cardsBorderRadius),
        onTap: () {
          print("Go to ${widget.text}");
          widget.onTap?.call();
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: Icon(
              iconData,
              size: 36.0,
              semanticLabel: widget.text,
            ),
            title: CusSText(widget.text),
          ),
        ),
      ),
    );
  }
}
