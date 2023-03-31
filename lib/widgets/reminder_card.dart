import 'package:day_picker/model/day_in_week.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../models/language.dart';
import '../models/reminder.dart';
import '../utils/assetslink.dart';
import '../utils/constants.dart';
import '../utils/formatter.dart';
import 'custom_card.dart';
import 'reminder_weekdays.dart';
import 'reminder_weekdays_display.dart';

class CardReminderItem extends StatelessWidget {
  final Reminder reminder;
  final VoidCallback? onPressed;
  final Animation<double> animation;

  const CardReminderItem({
    Key? key,
    required this.reminder,
    required this.animation,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // List<DayInWeek> getweekdaysList(BuildContext context, Reminder reminder) {
    //   List<DayInWeek> newDisplay = [
    //     DayInWeek(Language.of(context)!.t("week_mon")),
    //     DayInWeek(Language.of(context)!.t("week_tue")),
    //     DayInWeek(Language.of(context)!.t("week_wed")),
    //     DayInWeek(Language.of(context)!.t("week_thu")),
    //     DayInWeek(Language.of(context)!.t("week_fri")),
    //     DayInWeek(Language.of(context)!.t("week_sat")),
    //     DayInWeek(Language.of(context)!.t("week_sun"))
    //   ];
    //   if (reminder.weekdays1.isEmpty) {
    //     return newDisplay;
    //   }
    //   for (var i = 1; i <= reminder.weekdays1.length; i++) {
    //     if (reminder.weekdays1[i - 1] == (i)) {
    //       newDisplay[i - 1].isSelected = true;
    //     }
    //   }
    //   return newDisplay;
    // }

    // Widget createWeekdaysLine(BuildContext context, Reminder reminder) {
    //   return Container(
    //       padding: EdgeInsets.only(bottom: 4, left: 4, right: 4),
    //       child: WeekdaysSelector(
    //           boxDecoration: BoxDecoration(
    //             // color: Colors.green[400],
    //             borderRadius: BorderRadius.all(Radius.circular(4.0)),
    //           ),
    //           days: getweekdaysList(context, reminder),
    //           onSelect: (values) {
    //             // weekdayNum = reminder.weekdays1;
    //           }));
    // }

    return SlideTransition(
        position: animation.drive(Tween<Offset>(
          begin: const Offset(1.1, 0),
          end: const Offset(0, 0),
        ).chain(CurveTween(curve: Curves.decelerate))),
        child:
            createCard(context, subline: WeekdaysDisplay(reminder: reminder)));
  }

  Widget createCard(BuildContext context, {subline}) {
    return CusCard(
        Lottie.asset(
          assetslinkLottie('61069-medicine-pills'),
          width: 60,
          height: 60,
        ),
        // "${Language.of(context)!.t("home_card_remind_title")} - ${reminder.selectedMedicine.join(",")}",
        reminder.selectedMedicine.join(","),
        fromTimeToString(reminder.time1),
        reminder.weekdays1.isNotEmpty
            ? "${Language.of(context)!.t("home_card_repeat")} \n${showingRepeatWeekdays(context, reminder)}"
            : '',
        subline1: subline,
        onPressed: onPressed);
  }
}
