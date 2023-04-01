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
import '../widgets/reminder_weekdays.dart';
import '../widgets/reminder_weekdays_display.dart';
import '../widgets/time_section_display.dart';

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
  TimeOfDay timeMorning = TimeOfDay.now(); //TimeOfDay(hour: 6, minute: 0);
  TimeOfDay timeNoon = TimeOfDay(hour: 12, minute: 0);
  TimeOfDay timeNight = TimeOfDay(hour: 18, minute: 0);
  // TimeOfDay time = TimeOfDay.now();

  late Reminder reminder = widget.arg?.reminder ??
      Reminder(
          reminderTitle: "",
          time1: DateTime.now(),
          weekdays1: [1, 2, 3, 4, 5, 6, 7],
          selectedMedicine: []);

  bool eatMoreThanOnce = false;
  bool setMorning = true;
  bool setNoon = false;
  bool setNight = false;

  // Weekly selector
  List selectedweekdays1 = ['Monday', 'Tuesday', 'Wednesday'];
  List selectedweekdays2 = ['Thursday', 'Friday', 'Saturday', 'Sunday'];

  // UI rendering
  List<DayInWeek> getweekdaysList1(BuildContext context) {
    return [
      DayInWeek(Language.of(context)!.t("week_mon"), isSelected: true),
      DayInWeek(Language.of(context)!.t("week_tue"), isSelected: true),
      DayInWeek(Language.of(context)!.t("week_wed"), isSelected: true),
    ];
  }

  List<DayInWeek> getweekdaysList2(BuildContext context) {
    return [
      DayInWeek(Language.of(context)!.t("week_thu"), isSelected: true),
      DayInWeek(Language.of(context)!.t("week_fri"), isSelected: true),
      DayInWeek(Language.of(context)!.t("week_sat"), isSelected: true),
      DayInWeek(Language.of(context)!.t("week_sun"), isSelected: true),
    ];
  }

  void updateTime1ToModel(TimeOfDay newTime) {
    reminder = reminder.copyWith(
        time1: DateTime(_fromDate.year, _fromDate.month, _fromDate.day,
            newTime.hour, newTime.minute));
  }

  void updateWeekdays1ToModel() {
    List<int> newWeekdays = [];
    for (var day in selectedweekdays1) {
      newWeekdays.add(fromStringToWeekday(day));
    }
    for (var day in selectedweekdays2) {
      newWeekdays.add(fromStringToWeekday(day));
    }
    newWeekdays.sort((a, b) => a.compareTo(b));
    reminder = reminder.copyWith(weekdays1: newWeekdays);
  }

  // UI
  void openTimePicker() {}

  String showingRepeatWeekdays() {
    if (reminder.weekdays1.isEmpty) {
      return Language.of(context)!.t("reminder_new2_setrepeat3");
    }
    if (reminder.weekdays1.isNotEmpty && reminder.weekdays1.length < 7) {
      List weekStr = [];
      for (var weekday in reminder.weekdays1) {
        weekStr.add(fromWeekdayToString(context, weekday));
      }
      return weekStr.join(", ");
    }
    return Language.of(context)!.t("reminder_new2_setrepeat4");
  }

  @override
  void initState() {
    updateTime1ToModel(timeMorning);
    updateWeekdays1ToModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final hoursDisplay1 = timeMorning.hour.toString().padLeft(2, '0');
    // final minsDisplay1 = timeMorning.minute.toString().padLeft(2, '0');
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
                  textAlign: TextAlign.center,
                ),
                const Divider(),
                Expanded(
                  child: ListView(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CusSText(
                          Language.of(context)!.t("reminder_new2_settimer1"),
                        ),
                        CusNButton(
                          // "$hoursDisplay1:$minsDisplay1",
                          fromTimeOfDayToString(timeMorning),
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
                        const SizedBox(
                          height: 12,
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
                        WeekdaysSelector(
                            boxDecoration: BoxDecoration(
                              color: Colors.lightGreen[100],
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(
                                      selectWeekDaysBorderRadius),
                                  topRight: Radius.circular(
                                      selectWeekDaysBorderRadius)),
                            ),
                            days: getweekdaysList1(context),
                            onSelect: (values) {
                              setState(() {
                                print(values);
                                selectedweekdays1 = values;
                                updateWeekdays1ToModel();
                              });
                            }),
                        WeekdaysSelector(
                            boxDecoration: BoxDecoration(
                              color: Colors.lightGreen[100],
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(
                                      selectWeekDaysBorderRadius),
                                  bottomRight: Radius.circular(
                                      selectWeekDaysBorderRadius)),
                            ),
                            days: getweekdaysList2(context),
                            onSelect: (values) {
                              setState(() {
                                print(values);
                                selectedweekdays2 = values;
                                updateWeekdays1ToModel();
                              });
                            }),
                      ]),
                ),
                Column(
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: 8),
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
                                    Icon(
                                      Icons.alarm_on_outlined,
                                      size: 14,
                                    ),
                                    SizedBox(width: 2),
                                    CusExSText(Language.of(context)!
                                        .t("reminder_new2_settimer2")),
                                  ]),
                                ),
                                TimeSectionDisplay(
                                  padding:
                                      const EdgeInsets.only(top: 2, bottom: 8),
                                  times: [fromTimeOfDayToString(timeMorning)],
                                ),
                                Visibility(
                                  maintainSize: true,
                                  maintainAnimation: true,
                                  maintainState: true,
                                  visible: true,
                                  child: Row(children: [
                                    Icon(
                                      Icons.event_repeat_outlined,
                                      size: 14,
                                    ),
                                    SizedBox(width: 2),
                                    CusExSText(Language.of(context)!
                                        .t("reminder_new2_setrepeat2")),
                                  ]),
                                ),
                                Visibility(
                                    maintainSize: true,
                                    maintainAnimation: true,
                                    maintainState: true,
                                    visible: true,
                                    child:
                                        // CusNText(showingRepeatWeekdays())
                                        WeekdaysDisplay(
                                      reminder: reminder,
                                      padding: const EdgeInsets.only(
                                          top: 2, bottom: 8),
                                    )),
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
