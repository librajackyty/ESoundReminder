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
    return SlideTransition(
        position: animation.drive(Tween<Offset>(
          begin: const Offset(0, 1),
          end: const Offset(0, 0),
        ).chain(CurveTween(curve: Curves.decelerate))),
        child:
            createCard(context, subline: WeekdaysDisplay(reminder: reminder)));
  }

  Widget createCard(BuildContext context, {subline}) {
    return CusCard(
        Lottie.asset(
          assetslinkLottie('61069-medicine-pills'),
          reverse: true,
          width: 60,
          height: 60,
        ),
        reminder.selectedMedicine.join(","),
        fromTimeToString(reminder.time1),
        reminder.weekdays1.isNotEmpty
            ? "${Language.of(context)!.t("home_card_repeat")} \n${showingRepeatWeekdays(context, reminder)}"
            : '',
        subline1: subline,
        onPressed: onPressed);
  }
}
