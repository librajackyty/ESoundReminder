import 'package:flutter/material.dart';

import '../models/language.dart';
import '../models/reminder.dart';
import '../utils/formatter.dart';
import 'custom_card.dart';

class CardReminderItem extends StatelessWidget {
  const CardReminderItem({
    Key? key,
    required this.reminder,
    required this.animation,
    // this.onDelete,
    this.onPressed,
  }) : super(key: key);

  final Reminder reminder;
  // final VoidCallback? onDelete;
  final VoidCallback? onPressed;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: animation.drive(
        Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: const Offset(0.0, 0.0),
        ).chain(CurveTween(curve: Curves.elasticInOut)),
      ),
      child: CusCard(
          Icon(Icons.medication, // Icons.sunny
              color: Colors.blue[600]!, // Colors.yellow[900]!
              size: 40.0,
              semanticLabel: 'Reminder to take medicine'),
          "${Language.of(context)!.t("home_card_remind_title")} - ${reminder.selectedMedicine.join(",")}",
          fromTimeToString(reminder.time1),
          reminder.weekdays1.isNotEmpty
              ? "${Language.of(context)!.t("home_card_repeat")} \n${showingRepeatWeekdays(context, reminder)}"
              : '',
          onPressed: onPressed),
    );
  }
}
