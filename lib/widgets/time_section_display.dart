import 'package:e_sound_reminder_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../utils/assetslink.dart';
import 'time_box_display.dart';

class TimeSectionDisplay extends StatelessWidget {
  final List<String> times;
  final Alignment? alignment;
  final bool largeTxt;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final bool expiredTime1;

  const TimeSectionDisplay(
      {Key? key,
      required this.times,
      this.alignment,
      this.largeTxt = false,
      this.padding,
      this.color,
      this.expiredTime1 = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.all(16),
      alignment: alignment ?? Alignment.centerLeft,
      child: Wrap(
        spacing: 8.0,
        runSpacing: 6.0,
        children: createTimeBoxDisplays(times),
      ),
    );
  }

  List<Widget> createTimeBoxDisplays(List<String> times) {
    List<Widget> tdList = [];
    for (var time in times) {
      tdList.add(TimeBoxDisplay(
          largeTxt: largeTxt,
          icon: expiredTime1
              ? Padding(
                  padding: EdgeInsets.only(right: elementSSPadding),
                  child: Icon(
                    Icons.alarm_off,
                    color: color,
                  ))
              : Lottie.asset(
                  assetslinkLottie('73220-alarm'),
                  width: largeTxt ? 40 : 30,
                  height: largeTxt ? 40 : 30,
                ),
          time: time,
          color: color));
    }
    return tdList;
  }
}
