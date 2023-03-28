import 'package:day_picker/day_picker.dart';
import 'package:e_sound_reminder_app/widgets/custom_text_title.dart';
import 'package:flutter/material.dart';

import '../models/language.dart';
import '../models/reminder.dart';
import '../models/reminder_screen_arg.dart';
import '../utils/constants.dart';
import '../utils/formatter.dart';
import '../widgets/custom_button_normal.dart';
import '../widgets/custom_button_normal_back.dart';
import '../widgets/custom_button_small.dart';
import '../widgets/custom_scroll_bar.dart';
import '../widgets/custom_text_normal.dart';
import '../widgets/custom_text_small.dart';
import '../widgets/custom_text_small_ex.dart';

class ReminderNewPage2 extends StatefulWidget {
  const ReminderNewPage2({super.key, required this.title, this.arg});

  final String title;
  final ReminderScreenArg? arg;

  @override
  State<ReminderNewPage2> createState() => _ReminderNewPage2State();
}

class _ReminderNewPage2State extends State<ReminderNewPage2> {
  // Data

  DateTime _fromDate = DateTime.now();
  TimeOfDay timeMorning = TimeOfDay(hour: 6, minute: 0);
  TimeOfDay timeNoon = TimeOfDay(hour: 12, minute: 0);
  TimeOfDay timeNight = TimeOfDay(hour: 18, minute: 0);
  // TimeOfDay time = TimeOfDay.now();

  late Reminder reminder = widget.arg?.reminder ??
      Reminder(
          reminderTitle: "",
          time1: DateTime.now(),
          weekdays1: [],
          selectedMedicine: []);

  bool eatMoreThanOnce = false;
  bool setMorning = true;
  bool setNoon = false;
  bool setNight = false;

  // Weekly selector
  List selectedweekdays1 = [];
  List selectedweekdays2 = [];

  // UI rendering
  List<DayInWeek> getweekdaysList1(BuildContext context) {
    return [
      DayInWeek(Language.of(context)!.t("week_mon")),
      DayInWeek(Language.of(context)!.t("week_tue")),
      DayInWeek(Language.of(context)!.t("week_wed")),
    ];
  }

  List<DayInWeek> getweekdaysList2(BuildContext context) {
    return [
      DayInWeek(Language.of(context)!.t("week_thu")),
      DayInWeek(Language.of(context)!.t("week_fri")),
      DayInWeek(Language.of(context)!.t("week_sat")),
      DayInWeek(Language.of(context)!.t("week_sun")),
    ];
  }

  void updateTime1ToModel(TimeOfDay newTime) {
    reminder = reminder.copyWith(
        time1: DateTime(_fromDate.year, _fromDate.month, _fromDate.day,
            newTime.hour, newTime.minute));
  }

  void updateWeekdays1ToModel(BuildContext context) {
    List<int> newWeekdays = [];
    for (var day in selectedweekdays1) {
      newWeekdays.add(fromStringToWeekday(context, day));
    }
    for (var day in selectedweekdays2) {
      newWeekdays.add(fromStringToWeekday(context, day));
    }
    reminder = reminder.copyWith(weekdays1: newWeekdays);
  }

  // UI
  void openTimePicker() {}

  String showingRepeatWeekdays() {
    if (selectedweekdays1.isEmpty && selectedweekdays2.isEmpty) {
      return Language.of(context)!.t("reminder_new2_setrepeat3");
    }
    if (selectedweekdays1.length >= 3 && selectedweekdays2.length >= 4) {
      return Language.of(context)!.t("reminder_new2_setrepeat4");
    }
    final String displayW1 = selectedweekdays1.join(", ");
    final String displayW2 = selectedweekdays2.join(", ");
    if (selectedweekdays2.isEmpty) {
      return displayW1;
    }
    if (selectedweekdays1.isEmpty) {
      return displayW2;
    }
    return "$displayW1, $displayW2";
  }

  @override
  void initState() {
    updateTime1ToModel(timeMorning);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final hoursDisplay1 = timeMorning.hour.toString().padLeft(2, '0');
    final minsDisplay1 = timeMorning.minute.toString().padLeft(2, '0');
    // final hoursDisplay2 = timeNoon.hour.toString().padLeft(2, '0');
    // final minsDisplay2 = timeNoon.minute.toString().padLeft(2, '0');

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(safeAreaPaddingAll),
          child: Center(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CusExSText("${Language.of(context)!.t("common_step")} (2/3)"),
                CusSText(
                  Language.of(context)!.t("reminder_new2_msg"),
                ),
                const Divider(),

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
                  child: ListView(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CusSText(
                          Language.of(context)!.t("reminder_new2_settimer1"),
                        ),
                        CusSButton(
                          "$hoursDisplay1:$minsDisplay1",
                          () async {
                            TimeOfDay? newtime = await showTimePicker(
                                context: context,
                                initialTime: timeMorning,
                                initialEntryMode: TimePickerEntryMode.dialOnly,
                                helpText: Language.of(context)!
                                    .t("reminder_new2_timepicker_help"),
                                confirmText:
                                    Language.of(context)!.t("common_confirm"),
                                cancelText:
                                    Language.of(context)!.t("common_cancel"));
                            if (newtime == null) return;

                            setState(() {
                              timeMorning = newtime;
                              updateTime1ToModel(timeMorning);
                            });
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
                        CusSText(
                          Language.of(context)!.t("reminder_new2_setrepeat1"),
                        ),
                        SelectWeekDays(
                          padding: selectWeekDaysPadding,
                          fontSize: selectWeekDaysFontSize,
                          fontWeight: FontWeight.bold,
                          days: getweekdaysList1(context),
                          // backgroundColor: Color.fromARGB(255, 129, 199, 132),
                          border: false,
                          boxDecoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.only(
                                topLeft:
                                    Radius.circular(selectWeekDaysBorderRadius),
                                topRight: Radius.circular(
                                    selectWeekDaysBorderRadius)),
                          ),
                          onSelect: (values) {
                            setState(() {
                              print(values);
                              selectedweekdays1 = values;
                              updateWeekdays1ToModel(context);
                            });
                          },
                        ),
                        SelectWeekDays(
                          padding: selectWeekDaysPadding,
                          fontSize: selectWeekDaysFontSize,
                          fontWeight: FontWeight.bold,
                          days: getweekdaysList2(context),
                          // backgroundColor: Color.fromARGB(255, 76, 175, 80),
                          border: false,
                          boxDecoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.only(
                                bottomLeft:
                                    Radius.circular(selectWeekDaysBorderRadius),
                                bottomRight: Radius.circular(
                                    selectWeekDaysBorderRadius)),
                          ),
                          onSelect: (values) {
                            setState(() {
                              print(values);
                              selectedweekdays2 = values;
                              updateWeekdays1ToModel(context);
                            });
                          },
                        ),
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
                        margin: const EdgeInsets.only(
                            bottom: reminderCardBottomMargin),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.greenAccent,
                          ),
                          borderRadius:
                              BorderRadius.circular(cardsBorderRadius),
                        ),
                        elevation: cardsElevation,
                        child: SizedBox(
                            height: MediaQuery.of(context).size.height *
                                reminderCardHeightRatio,
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
                                  child: Row(children: [
                                    Icon(Icons.alarm_on_outlined),
                                    SizedBox(width: 6),
                                    CusSText(Language.of(context)!
                                        .t("reminder_new2_settimer2")),
                                  ]),
                                ),
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      // Icon(Icons.alarm),
                                      // SizedBox(width: 8),
                                      CusTitleText(
                                          "$hoursDisplay1:$minsDisplay1")
                                    ]),
                                Visibility(
                                  maintainSize: true,
                                  maintainAnimation: true,
                                  maintainState: true,
                                  visible: true,
                                  child: Row(children: [
                                    Icon(Icons.event_repeat_outlined),
                                    SizedBox(width: 6),
                                    CusSText(Language.of(context)!
                                        .t("reminder_new2_setrepeat2")),
                                  ]),
                                ),
                                Visibility(
                                    maintainSize: true,
                                    maintainAnimation: true,
                                    maintainState: true,
                                    visible: true,
                                    child: CusNText(showingRepeatWeekdays())),
                              ],
                            ))),
                    Row(
                      children: [
                        Expanded(
                          child: CusNBackButton(
                              Language.of(context)!.t("common_back"),
                              () => {Navigator.pop(context)}),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: CusNButton(
                              Language.of(context)!.t("common_next"),
                              () => {
                                    Navigator.pushNamed(
                                        context, pageRouteReminderDetail,
                                        arguments: ReminderScreenArg(reminder))
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
