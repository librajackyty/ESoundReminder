import 'package:e_sound_reminder_app/widgets/custom_text_title.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../widgets/custom_button_normal.dart';
import '../widgets/custom_button_normal_back.dart';
import '../widgets/custom_button_small.dart';
import '../widgets/custom_scroll_bar.dart';
import '../widgets/custom_text_small.dart';

class ReminderNewPage2 extends StatefulWidget {
  const ReminderNewPage2({super.key, required this.title});

  final String title;

  @override
  State<ReminderNewPage2> createState() => _ReminderNewPage2State();
}

class _ReminderNewPage2State extends State<ReminderNewPage2> {
  // Data
  TimeOfDay time = TimeOfDay.now();
  DateTime date = DateTime.now();

  // UI rendering
  void openTimePicker() {}

  @override
  Widget build(BuildContext context) {
    final hoursDisplay = time.hour.toString().padLeft(2, '0');
    final minsDisplay = time.minute.toString().padLeft(2, '0');

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(safeAreaPaddingAll),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CusSText(
                  'Please set the time to remind you:',
                ),
                Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CusNButton(
                          "Setting Date",
                          () async {
                            DateTime? newdate = await showDatePicker(
                                context: context,
                                initialDate: date,
                                firstDate: date,
                                lastDate: date.add(const Duration(days: 300)));
                            if (newdate == null) return;

                            setState(() => date = newdate);
                          },
                          icon: Icon(Icons.edit_calendar),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CusNButton(
                          "Setting Time",
                          () async {
                            TimeOfDay? newtime = await showTimePicker(
                                context: context, initialTime: time);
                            if (newtime == null) return;

                            setState(() => time = newtime);
                          },
                          icon: Icon(Icons.alarm_add),
                        )
                      ]),
                ),
                Column(
                  children: [
                    Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border(top: BorderSide()),
                        )),
                    Card(
                        margin: const EdgeInsets.only(bottom: 16.0),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.greenAccent,
                          ),
                          borderRadius:
                              BorderRadius.circular(cardsBorderRadius),
                        ),
                        elevation: 6.0,
                        child: SizedBox(
                            height: 200,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CusSText("Set to:"),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.calendar_today),
                                      SizedBox(width: 8),
                                      CusTitleText(
                                          "${date.year} / ${date.month} / ${date.day}")
                                    ]),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.alarm),
                                      SizedBox(width: 8),
                                      CusTitleText("$hoursDisplay:$minsDisplay")
                                    ]),
                              ],
                            ))),
                    Row(
                      children: [
                        Expanded(
                          child: CusNBackButton(
                              'Back', () => {Navigator.pop(context)}),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: CusNButton(
                              'Next',
                              () => {
                                    Navigator.pushNamed(
                                        context, pageRouteReminderDetail)
                                  }),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
