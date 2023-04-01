import 'package:day_picker/model/day_in_week.dart';
import 'package:e_sound_reminder_app/utils/formatter.dart';
import 'package:e_sound_reminder_app/widgets/custom_text_small_ex.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../models/language.dart';
import '../models/reminder.dart';
import '../utils/assetslink.dart';
import '../utils/constants.dart';
import 'custom_button_small.dart';
import 'custom_text_small.dart';
import 'time_box_display.dart';

class WeekdaysDisplay extends StatelessWidget {
  final Reminder reminder;
  final Alignment? alignment;
  final bool largeTxt;
  final EdgeInsetsGeometry? padding;
  final bool displayAll;

  const WeekdaysDisplay(
      {Key? key,
      required this.reminder,
      this.alignment,
      this.largeTxt = false,
      this.padding,
      this.displayAll = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> getweekdaysList(BuildContext context, Reminder reminder) {
      List<String> newDisplay = [];
      for (var day in reminder.weekdays1) {
        newDisplay.add(fromWeekdayToShortString(context, day));
      }
      return newDisplay;
    }

    Widget createWeekdaySummary(String text) {
      return TimeBoxDisplay(
        time: text,
        icon: Lottie.asset(
          assetslinkLottie('24038-calendar-icon'),
          width: largeTxt ? 40 : 30,
          height: largeTxt ? 40 : 30,
        ),
      );
    }

    Widget createWeekdayItm(String dayStr, {disabled = false}) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          foregroundColor: Colors.black,
          textStyle: TextStyle(
              fontSize: largeTxt ? textNormalSize : textSmallSize,
              fontWeight: FontWeight.normal,
              color: Colors.black),
          fixedSize:
              largeTxt ? const Size.fromHeight(60) : const Size.fromHeight(50),
          side: BorderSide(
            color: Colors.green[900]!,
            width: 1.0,
          ),
        ),
        onPressed: disabled ? null : () {},
        child: Text(
          dayStr,
          textAlign: TextAlign.center,
        ),
      );
    }

    Widget createWeekdaysList(BuildContext context, Reminder reminder) {
      List<Widget> wdSum = [];
      List<Widget> wdItm = [];
      if (displayAll) {
        if (reminder.weekdays1.isEmpty) {
          wdSum.add(createWeekdaySummary(
              Language.of(context)!.t("reminder_new2_setrepeat3")));
        } else if (reminder.weekdays1.isNotEmpty &&
            reminder.weekdays1.length == 7) {
          wdSum.add(createWeekdaySummary(
              Language.of(context)!.t("reminder_new2_setrepeat4")));
        }
        for (var i = 0; i < 7; i++) {
          final hasDay = reminder.weekdays1
              .firstWhere((element) => element == (i + 1), orElse: () {
            return -1;
          });
          wdItm.add(createWeekdayItm(fromWeekdayToString(context, (i + 1)),
              disabled: hasDay < 0));
        }
      } else {
        if (reminder.weekdays1.isEmpty) {
          wdItm.add(createWeekdaySummary(
              Language.of(context)!.t("reminder_new2_setrepeat3")));
        } else if (reminder.weekdays1.isNotEmpty &&
            reminder.weekdays1.length == 7) {
          wdItm.add(createWeekdaySummary(
              Language.of(context)!.t("reminder_new2_setrepeat4")));
        } else {
          List<String> weekdays = getweekdaysList(context, reminder);
          for (var dayStr in weekdays) {
            wdItm.add(createWeekdayItm(dayStr));
          }
        }
      }

      return Container(
          padding: padding ?? EdgeInsets.only(bottom: 4, left: 16, right: 16),
          alignment: alignment ?? Alignment.centerLeft,
          child: !displayAll
              ? Wrap(
                  alignment: alignment == Alignment.center
                      ? WrapAlignment.center
                      : WrapAlignment.start,
                  spacing: alignment == Alignment.center ? 8.0 : 2.0,
                  runSpacing: alignment == Alignment.center ? 8.0 : 2.0,
                  children: [...wdItm],
                )
              : Column(
                  children: [
                    ...wdSum,
                    wdSum.isNotEmpty
                        ? const Divider()
                        : const SizedBox.shrink(),
                    Wrap(
                      alignment: alignment == Alignment.center
                          ? WrapAlignment.center
                          : WrapAlignment.start,
                      spacing: alignment == Alignment.center ? 8.0 : 2.0,
                      runSpacing: alignment == Alignment.center ? 8.0 : 2.0,
                      children: [...wdItm],
                    )
                  ],
                ));
    }

    return createWeekdaysList(context, reminder);
  }
}
