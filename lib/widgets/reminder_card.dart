import 'package:e_sound_reminder_app/widgets/time_section_display.dart';
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
        child: createCard(context,
            subline0: settedTime(context, reminder),
            subline1: WeekdaysDisplay(reminder: reminder)));
  }

  Widget createCard(BuildContext context, {subline0, subline1}) {
    return CusCard(
      Lottie.asset(
        assetslinkLottie('61069-medicine-pills'),
        reverse: true,
        width: 60,
        height: 60,
      ),
      reminder.selectedMedicine.join(","),
      // fromTimeToString(reminder.time1, weekdays: reminder.weekdays1, dateTxts: [
      //   Language.of(context)!.t("day_today"),
      //   Language.of(context)!.t("day_tmr"),
      //   Language.of(context)!.t("day_expired"),
      // ]),
      // reminder.weekdays1.isNotEmpty
      //     ? "${Language.of(context)!.t("home_card_repeat")} \n${showingRepeatWeekdays(context, reminder)}"
      //     : '',
      subline0: subline0,
      subline1: subline1,
      onPressed: onPressed,
      expiredTime1: checkReminderTime1IsExpired(reminder),
      expiredColor: checkReminderTime1IsExpired(reminder) ? errorColor : null,
    );
  }

  Widget settedTime(BuildContext context, Reminder reminder) {
    List<String> times = [];
    for (var i = 0; i < reminder.reminderType; i++) {
      DateTime dt;
      switch (i) {
        case 0:
          dt = reminder.time1;
          break;
        case 1:
          dt = reminder.time2!;
          break;
        case 2:
          dt = reminder.time3!;
          break;
        case 3:
          dt = reminder.time4!;
          break;
        default:
          dt = reminder.time1;
      }
      times.add(fromTimeToString(dt, weekdays: reminder.weekdays1, dateTxts: [
        Language.of(context)!.t("day_today"),
        Language.of(context)!.t("day_tmr"),
        Language.of(context)!.t("day_expired"),
      ]));
    }
    return TimeSectionDisplay(
      // header: reminder.reminderType > 1 &&
      //         reminder.weekdays1.isEmpty &&
      //         checkReminderTimesAreSameDay(reminder)
      //     ? fromTimeToDateLongString(reminder.time1, dateTxts: [
      //         Language.of(context)!.t("day_today"),
      //         Language.of(context)!.t("day_tmr"),
      //         Language.of(context)!.t("day_expired"),
      //       ])
      //     : null,
      times: times,
      // expiredTime1: checkReminderTime1IsExpired(reminder),
      expiredTimes: getReminderAllTimeExpired(reminder),
      // allTimeAreExpired:
      //     checkReminderAllTimeAreExpired(getReminderAllTimeExpired(reminder))
      // color: checkReminderTime1IsExpired(reminder) ? errorColor : null,
    );
  }
}
