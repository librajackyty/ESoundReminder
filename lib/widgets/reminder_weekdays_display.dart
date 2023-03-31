import 'package:day_picker/model/day_in_week.dart';
import 'package:e_sound_reminder_app/utils/formatter.dart';
import 'package:e_sound_reminder_app/widgets/custom_text_small_ex.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../models/language.dart';
import '../models/reminder.dart';
import 'custom_button_small.dart';
import 'custom_text_small.dart';

class WeekdaysDisplay extends StatelessWidget {
  final Reminder reminder;

  const WeekdaysDisplay({
    Key? key,
    required this.reminder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> getweekdaysList(BuildContext context, Reminder reminder) {
      List<String> newDisplay = [];
      if (reminder.weekdays1.isEmpty) {
        newDisplay.add(Language.of(context)!.t("reminder_new2_setrepeat3"));
      } else if (reminder.weekdays1.isNotEmpty &&
          reminder.weekdays1.length == 7) {
        newDisplay.add(Language.of(context)!.t("reminder_new2_setrepeat4"));
      } else {
        for (var day in reminder.weekdays1) {
          newDisplay.add(fromWeekdayToString(context, day));
        }
      }
      return newDisplay;
    }

    Widget createWeekdaysList(BuildContext context, List<String> weekdays) {
      List<Widget> wdItm = [];
      for (var dayStr in weekdays) {
        wdItm.add(Padding(
            padding: EdgeInsets.all(4),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                surfaceTintColor: Colors.white,
                foregroundColor: Colors.black,
                textStyle: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.normal,
                    color: Colors.black),
                fixedSize: const Size.fromHeight(60),
                side: BorderSide(
                  color: Colors.green[900]!,
                  width: 1.0,
                ),
              ),
              onPressed: () {},
              child: Text(
                dayStr,
                textAlign: TextAlign.center,
              ),
            )));
      }
      return Container(
          padding: EdgeInsets.only(bottom: 4, left: 16, right: 16),
          alignment: Alignment.centerLeft,
          child: Wrap(
            children: [...wdItm],
          ));
    }

    return createWeekdaysList(context, getweekdaysList(context, reminder));
  }
}
