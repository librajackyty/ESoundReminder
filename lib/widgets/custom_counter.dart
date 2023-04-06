import 'package:e_sound_reminder_app/utils/constants.dart';
import 'package:flutter/material.dart';

import '../utils/feedback.dart';
import 'custom_text_small.dart';

class SimpleCounter extends StatelessWidget {
  SimpleCounter({
    super.key,
    required this.value,
    this.onPressedAdd,
    this.onPressedMinus,
    this.padding,
  });

  final EdgeInsets? padding;
  final int value;
  final void Function()? onPressedAdd;
  final void Function()? onPressedMinus;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.zero,
      child: Row(
        children: [
          FloatingActionButton.small(
              backgroundColor: elementActiveColor,
              heroTag: "fabMinus",
              onPressed: () {
                onPressedMinus?.call();
                runHapticSound();
              },
              child: Icon(
                Icons.remove,
                color: elementActiveTxtColor,
              )),
          Container(
              width: 30,
              padding: EdgeInsets.all(elementSPadding),
              margin: EdgeInsets.symmetric(horizontal: elementSSPadding),
              child: CusSText('$value')),
          FloatingActionButton.small(
              backgroundColor: elementActiveColor,
              heroTag: "fabPlus",
              onPressed: () {
                onPressedAdd?.call();
                runHapticSound();
              },
              child: Icon(
                Icons.add,
                color: elementActiveTxtColor,
              ))
        ],
      ),
    );
  }
}
