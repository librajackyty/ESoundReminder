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
  TimeOfDay timeMorning = TimeOfDay(hour: 6, minute: 0);
  TimeOfDay timeNoon = TimeOfDay(hour: 12, minute: 0);
  TimeOfDay timeNight = TimeOfDay(hour: 18, minute: 0);
  // TimeOfDay time = TimeOfDay.now();
  // DateTime date = DateTime.now();

  bool eatMoreThanOnce = false;
  bool setMorning = true;
  bool setNoon = false;
  bool setNight = false;

  // UI rendering
  void openTimePicker() {}

  @override
  Widget build(BuildContext context) {
    final hoursDisplay1 = timeMorning.hour.toString().padLeft(2, '0');
    final minsDisplay1 = timeMorning.minute.toString().padLeft(2, '0');
    final hoursDisplay2 = timeNoon.hour.toString().padLeft(2, '0');
    final minsDisplay2 = timeNoon.minute.toString().padLeft(2, '0');

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

                // const SizedBox(height: 20),
                // Row(
                //   children: [
                //     Expanded(child: CusSText('Take more than once a day?')),
                //     Transform.scale(
                //         scale: 1.8,
                //         child: Switch(
                //           // This bool value toggles the switch.
                //           value: eatMoreThanOnce,
                //           onChanged: (bool value) {
                //             // This is called when the user toggles the switch.
                //             setState(() {
                //               eatMoreThanOnce = value;
                //             });
                //           },
                //         ))
                //   ],
                // ),
                // Row(
                //   children: [
                //     Expanded(child: CusSText('Take medince in morning?')),
                //     Transform.scale(
                //         scale: 1.8,
                //         child: Switch(
                //           // This bool value toggles the switch.
                //           value: setMorning,
                //           onChanged: (bool value) {
                //             // This is called when the user toggles the switch.
                //             setState(() {
                //               setMorning = value;
                //             });
                //           },
                //         ))
                //   ],
                // ),
                // Row(
                //   children: [
                //     Expanded(child: CusSText('Take medince at noon?')),
                //     Transform.scale(
                //         scale: 1.8,
                //         child: Switch(
                //           // This bool value toggles the switch.
                //           value: setNight,
                //           onChanged: (bool value) {
                //             // This is called when the user toggles the switch.
                //             setState(() {
                //               setNight = value;
                //             });
                //           },
                //         ))
                //   ],
                // ),
                // Row(
                //   children: [
                //     Expanded(child: CusSText('Take medince at night?')),
                //     Transform.scale(
                //         scale: 1.8,
                //         child: Switch(
                //           // This bool value toggles the switch.
                //           value: setNoon,
                //           onChanged: (bool value) {
                //             // This is called when the user toggles the switch.
                //             setState(() {
                //               setNoon = value;
                //             });
                //           },
                //         ))
                //   ],
                // ),
                Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CusNButton(
                          "$hoursDisplay1:$minsDisplay1",
                          () async {
                            TimeOfDay? newtime = await showTimePicker(
                                context: context,
                                initialTime: timeMorning,
                                initialEntryMode: TimePickerEntryMode.dialOnly);
                            if (newtime == null) return;

                            setState(() => timeMorning = newtime);
                          },
                          icon: Icon(Icons.alarm),
                        ),
                        // CusNButton(
                        //   "Setting Date",
                        //   () async {
                        //     DateTime? newdate = await showDatePicker(
                        //         context: context,
                        //         initialDate: date,
                        //         firstDate: date,
                        //         lastDate: date.add(const Duration(days: 300)),
                        //         initialEntryMode: DatePickerEntryMode.calendarOnly,
                        //         builder: (context, child) {
                        //           return Theme(
                        //             data: Theme.of(context).copyWith(
                        //               textButtonTheme: TextButtonThemeData(
                        //                 style: TextButton.styleFrom(
                        //                   textStyle: TextStyle(
                        //                       fontSize: 20,
                        //                       fontWeight: FontWeight.bold),
                        //                 ),
                        //               ),
                        //             ),
                        //             child: child!,
                        //           );
                        //         });
                        //     if (newdate == null) return;

                        //     setState(() => date = newdate);
                        //   },
                        //   icon: Icon(Icons.edit_calendar),
                        // ),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        // Visibility(
                        //     maintainSize: true,
                        //     maintainAnimation: true,
                        //     maintainState: true,
                        //     visible: setMorning,
                        //     child: CusNButton(
                        //       "Select Time (Morning)",
                        //       () async {
                        //         TimeOfDay? newtime = await showTimePicker(
                        //             context: context,
                        //             initialTime: timeMorning,
                        //             initialEntryMode:
                        //                 TimePickerEntryMode.dialOnly);
                        //         if (newtime == null) return;

                        //         setState(() => timeMorning = newtime);
                        //       },
                        //       icon: Icon(Icons.alarm_add),
                        //     )),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        // CusNButton(
                        //   "Select Time (Noon)",
                        //   () async {
                        //     TimeOfDay? newtime = await showTimePicker(
                        //         context: context,
                        //         initialTime: timeNoon,
                        //         initialEntryMode: TimePickerEntryMode.dialOnly);
                        //     if (newtime == null) return;

                        //     setState(() => timeNoon = newtime);
                        //   },
                        //   icon: Icon(Icons.alarm_add),
                        // ),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        // CusNButton(
                        //   "Select Time (Night)",
                        //   () async {
                        //     TimeOfDay? newtime = await showTimePicker(
                        //         context: context,
                        //         initialTime: timeNight,
                        //         initialEntryMode: TimePickerEntryMode.dialOnly);
                        //     if (newtime == null) return;

                        //     setState(() => timeNight = newtime);
                        //   },
                        //   icon: Icon(Icons.alarm_add),
                        // )
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
                            child: ListView(
                              padding: EdgeInsets.all(12),
                              children: [
                                // Row(
                                //     mainAxisAlignment: MainAxisAlignment.center,
                                //     children: [
                                //       Icon(Icons.calendar_today),
                                //       SizedBox(width: 8),
                                //       CusTitleText(
                                //           "${date.year} / ${date.month} / ${date.day}")
                                //     ]),
                                Visibility(
                                    maintainSize: true,
                                    maintainAnimation: true,
                                    maintainState: true,
                                    visible: setMorning,
                                    child: CusSText("Set timer to:")),
                                // Visibility(
                                //     maintainSize: true,
                                //     maintainAnimation: true,
                                //     maintainState: true,
                                //     visible: setMorning,
                                //     child: CusNButton(
                                //       "$hoursDisplay1:$minsDisplay1",
                                //       () async {
                                //         TimeOfDay? newtime =
                                //             await showTimePicker(
                                //                 context: context,
                                //                 initialTime: timeMorning,
                                //                 initialEntryMode:
                                //                     TimePickerEntryMode
                                //                         .dialOnly);
                                //         if (newtime == null) return;

                                //         setState(() => timeMorning = newtime);
                                //       },
                                //       icon: Icon(Icons.alarm),
                                //     )),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.alarm),
                                      SizedBox(width: 8),
                                      CusTitleText(
                                          "$hoursDisplay1:$minsDisplay1")
                                    ]),
                                Visibility(
                                    maintainSize: true,
                                    maintainAnimation: true,
                                    maintainState: true,
                                    visible: true,
                                    child: CusSText("Set repeat on:")),
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