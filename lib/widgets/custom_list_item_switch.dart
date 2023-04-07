import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../utils/feedback.dart';
import 'custom_text_normal.dart';
import 'custom_text_small.dart';

class CusListItmSwitch extends StatefulWidget {
  final Widget? imageData;
  final IconData? iconData;
  final bool value;
  final String? text;
  void Function(bool)? onTap;
  bool selected;
  bool noBorder;

  CusListItmSwitch(this.value,
      {this.text,
      this.imageData,
      this.iconData,
      required this.onTap,
      this.selected = false,
      this.noBorder = false});

  @override
  _CusListItmSwitchState createState() => _CusListItmSwitchState(
      imageData, iconData, text, onTap, selected, noBorder);
}

class _CusListItmSwitchState extends State<CusListItmSwitch> {
  Widget? imageData;
  IconData? iconData;
  String? text;
  void Function(bool)? onTap;
  bool selected;
  bool noBorder;

  _CusListItmSwitchState(this.imageData, this.iconData, this.text, this.onTap,
      this.selected, this.noBorder);

  @override
  Widget build(BuildContext context) {
    Widget createImg() {
      return imageData ?? const SizedBox.shrink();
    }

    return SizedBox(
      // child: InkWell(
      //   borderRadius: BorderRadius.circular(cardsBorderRadius),
      //   onTap: () {
      //     debugPrint("Go to ${widget.text}");
      //     widget.onTap?.call();
      //     runHapticSound();
      //   },
      child: Padding(
          padding: const EdgeInsets.all(elementSPadding),
          child: Row(children: [
            createImg(),
            Expanded(
                child: SwitchListTile(
              value: widget.value,
              onChanged: (value) {
                widget.onTap!(value);
                runHapticSound();
              },
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(cardsBorderRadius))),
              // shape: noBorder
              //     ? null
              // : RoundedRectangleBorder(
              //     side: BorderSide(
              //         color: buttonBorderColor, width: buttonBorderWidth),
              //     borderRadius:
              //         BorderRadius.all(Radius.circular(cardsBorderRadius))),
              // tileColor: buttonReadOnlyColor,
              // selectedTileColor: buttonBorderColor,
              // selectedColor: buttonReadOnlyColor,
              selected: selected,
              title: widget.text != null ? CusNText(widget.text!) : null,
            )),
          ])),
      // ),
    );
  }
}
