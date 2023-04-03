import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../utils/feedback.dart';
import 'custom_text_normal.dart';
import 'custom_text_small.dart';

class CusListItm extends StatefulWidget {
  final IconData? iconData;
  final String text;
  VoidCallback? onTap;
  bool selected;

  CusListItm(this.text, {this.iconData, this.onTap, this.selected = false});

  @override
  _CusListItmState createState() =>
      _CusListItmState(iconData, text, onTap, selected);
}

class _CusListItmState extends State<CusListItm> {
  IconData? iconData;
  String text;
  VoidCallback? onTap;
  bool selected;

  _CusListItmState(this.iconData, this.text, this.onTap, this.selected);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: InkWell(
        borderRadius: BorderRadius.circular(cardsBorderRadius),
        onTap: () {
          debugPrint("Go to ${widget.text}");
          widget.onTap?.call();
          runHapticSound();
        },
        child: Padding(
          padding: const EdgeInsets.all(elementSPadding),
          child: ListTile(
            splashColor: buttonForegroundColor,
            shape: RoundedRectangleBorder(
                side: BorderSide(
                    color: buttonBorderColor, width: buttonBorderWidth),
                borderRadius:
                    BorderRadius.all(Radius.circular(cardsBorderRadius))),
            tileColor: buttonReadOnlyColor,
            selectedTileColor: buttonBorderColor,
            selectedColor: buttonReadOnlyColor,
            selected: selected,
            leading: iconData != null
                ? Icon(
                    iconData,
                    size: 36.0,
                    semanticLabel: widget.text,
                    color: selected ? buttonReadOnlyColor : Colors.black54,
                  )
                : null,
            title: CusNText(widget.text),
          ),
        ),
      ),
    );
  }
}
