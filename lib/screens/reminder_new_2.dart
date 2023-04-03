import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:day_picker/day_picker.dart';
import 'package:e_sound_reminder_app/widgets/custom_text_title.dart';
import 'package:flutter/material.dart';

import '../models/language.dart';
import '../models/reminder.dart';
import '../models/reminder_screen_arg.dart';
import '../utils/constants.dart';
import '../utils/formatter.dart';
import '../utils/time_picker.dart';
import '../widgets/ani_progress_bar.dart';
import '../widgets/custom_button_normal.dart';
import '../widgets/custom_button_normal_back.dart';
import '../widgets/custom_button_small.dart';
import '../widgets/custom_card_container.dart';
import '../widgets/custom_scroll_bar.dart';
import '../widgets/custom_text_normal.dart';
import '../widgets/custom_text_small.dart';
import '../widgets/custom_text_small_ex.dart';
import '../widgets/reminder_header.dart';
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
  double progressIdx = 0;
  double progressIdxStep1 = 50;
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
  void openTimePicker() async {
    TimeOfDay? newtime = await showStyledTimePicker(context, timeMorning,
        errorInvalidText:
            Language.of(context)!.t("reminder_new2_timepicker_error"),
        helpText: Language.of(context)!.t("reminder_new2_settimer1"),
        confirmText: Language.of(context)!.t("common_confirm"),
        cancelText: Language.of(context)!.t("common_cancel"));

    updatingAlarmTime(newtime);
  }

  void openDayNightTimePicker() {
    showDayNightTimePicker(context, timeMorning,
        confirmText: Language.of(context)!.t("common_confirm"),
        cancelText: Language.of(context)!.t("common_cancel"),
        hourLabel: Language.of(context)!.t("timepicker_hr"),
        minuteLabel: Language.of(context)!.t("timepicker_min"),
        onChangeDateTime: (datetime) {
      debugPrint("onChangeDateTime: ${datetime.hour}:${datetime.minute}");

      updatingAlarmTime(TimeOfDay.fromDateTime(datetime));
    });
  }

  void updatingAlarmTime(TimeOfDay? newtime) {
    if (newtime == null) return;

    setState(() {
      timeMorning = newtime;
      updateTime1ToModel(timeMorning);
    });
  }

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
    Future.delayed(const Duration(milliseconds: progressBarDelayShowTime))
        .then((value) => setState(() {
              progressIdx = progressIdxStep1;
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(safeAreaPaddingAll),
          child: Center(
            child: Column(
              children: <Widget>[
                ReminderHeader(
                  progressText:
                      "${Language.of(context)!.t("common_step")} ( 2 / 3 )",
                  progressValue: progressIdx,
                  headerText: Language.of(context)!.t("reminder_new2_msg"),
                ),
                Expanded(
                  child: ListView(children: [
                    CusSText(
                      Language.of(context)!.t("reminder_new2_settimer1"),
                    ),
                    CusNButton(
                      fromTimeOfDayToString(timeMorning),
                      () => openDayNightTimePicker(),
                      // openTimePicker,
                      icon: Icon(Icons.alarm_add),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    CusSText(
                      Language.of(context)!.t("reminder_new2_setrepeat1"),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: buttonBorderColor,
                              width: buttonBorderWidth),
                          borderRadius: BorderRadius.circular(
                              selectWeekDaysBorderRadius)),
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        WeekdaysSelector(
                            boxDecoration: BoxDecoration(
                              color: Colors.green.shade50,
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
                              color: Colors.green.shade50,
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
                  ]),
                ),
                Column(
                  children: [
                    Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border(top: BorderSide()),
                        )),
                    CusCardContainer(
                        child: SizedBox(
                            height: MediaQuery.of(context).size.height *
                                reminderCardHeightRatio,
                            child: ListView(
                              padding: EdgeInsets.all(12),
                              children: [
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
                                    child: WeekdaysDisplay(
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
