import 'package:e_sound_reminder_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../utils/assetslink.dart';
import 'custom_text_normal.dart';
import 'custom_text_title.dart';
import 'time_box_display.dart';

class TimeSectionDisplay extends StatelessWidget {
  final List<String> times;
  final Alignment? alignment;
  final bool largeTxt;
  final EdgeInsetsGeometry? padding;
  // final Color? color;
  final List<bool>? expiredTimes;
  final bool allTimeAreExpired;
  final String? header;

  TimeSectionDisplay(
      {Key? key,
      required this.times,
      this.alignment,
      this.largeTxt = false,
      this.padding,
      // this.color,
      this.expiredTimes,
      this.allTimeAreExpired = false,
      this.header})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: padding ?? EdgeInsets.all(16),
        alignment: alignment ?? Alignment.centerLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            header != null ? createHeader(header!) : const SizedBox.shrink(),
            Wrap(
              alignment: alignment != null && alignment == Alignment.center
                  ? WrapAlignment.center
                  : WrapAlignment.start,
              spacing: 8.0,
              runSpacing: 6.0,
              children: createTimeBoxDisplays(times),
            ),
          ],
        ));
  }

  Widget createHeader(String text) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: elementSPadding),
        child: Column(children: [
          TimeBoxDisplay(
            text: text,
            largeTxt: largeTxt,
            color: allTimeAreExpired ? errorColor : null,
          ),
          const Divider(),
        ]));
  }

  List<Widget> createTimeBoxDisplays(List<String> times) {
    List<Widget> tdList = [];
    for (var i = 0; i < times.length; i++) {
      tdList.add(TimeBoxDisplay(
          largeTxt: largeTxt,
          icon: checkExpireds(i)
              ? Padding(
                  padding: largeTxt
                      ? EdgeInsets.symmetric(horizontal: elementSSSPadding)
                      : EdgeInsets.symmetric(horizontal: elementSSPadding),
                  child: Icon(
                    Icons.alarm_off,
                    color: errorColor,
                    size: largeTxt ? 34 : 25,
                  ))
              : Lottie.asset(
                  assetslinkLottie('73220-alarm'),
                  width: largeTxt ? 40 : 30,
                  height: largeTxt ? 40 : 30,
                ),
          text: times[i],
          color: checkExpireds(i) ? errorColor : null));
    }
    return tdList;
  }

  bool checkExpireds(int i) {
    if (expiredTimes != null && expiredTimes!.length > i) {
      return expiredTimes![i];
    }
    return false;
  }
}
