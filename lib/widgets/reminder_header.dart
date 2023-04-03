import 'package:flutter/material.dart';

import '../utils/constants.dart';
import 'ani_progress_bar.dart';
import 'custom_text_small.dart';
import 'custom_text_small_ex.dart';

class ReminderHeader extends StatelessWidget {
  final String progressText;
  final double progressValue;
  final String headerText;
  final bool hasBottomDivider;

  const ReminderHeader(
      {Key? key,
      required this.progressText,
      required this.progressValue,
      required this.headerText,
      this.hasBottomDivider = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        margin: EdgeInsets.only(bottom: 8),
        child: Row(
          children: [
            CusExSText(progressText),
            Expanded(
                child: Container(
                    padding: EdgeInsets.only(left: elementSPadding),
                    child: AniProgressBar(currentValue: progressValue))),
          ],
        ),
      ),
      CusSText(
        headerText,
        textAlign: TextAlign.center,
      ),
      hasBottomDivider ? const Divider() : const SizedBox.shrink(),
    ]);
  }
}
