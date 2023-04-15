import 'package:delayed_display/delayed_display.dart';
import 'package:e_sound_reminder_app/models/displayer.dart';
import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../models/language.dart';
import '../models/reminder.dart';
import '../models/reminder_screen_arg.dart';
import '../utils/constants.dart';
import '../utils/dialog.dart';
import '../utils/formatter.dart';
import '../utils/snack_msg.dart';
import '../utils/time_picker.dart';
import '../utils/tutorial.dart';
import '../widgets/custom_button_normal.dart';
import '../widgets/custom_button_normal_back.dart';
import '../widgets/custom_counter.dart';
import '../widgets/custom_labeled_switch.dart';
import '../widgets/custom_scroll_bar.dart';
import '../widgets/custom_text_small.dart';
import '../widgets/reminder_header.dart';
import '../widgets/reminder_weekdays.dart';

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
  TimeOfDay timeOfDay1 = TimeOfDay.now(); //TimeOfDay(hour: 6, minute: 0);
  TimeOfDay timeOfDay2 = TimeOfDay.now(); // TimeOfDay(hour: 12, minute: 0);
  TimeOfDay timeOfDay3 = TimeOfDay.now(); // TimeOfDay(hour: 18, minute: 0);
  TimeOfDay timeOfDay4 = TimeOfDay.now();
  int timerNum = 1;
  List<bool> timeExpireds = [];

  late Reminder reminder = widget.arg?.reminder ??
      Reminder(
          reminderTitle: "",
          time1: DateTime.now(),
          weekdays1: [1, 2, 3, 4, 5, 6, 7],
          selectedMedicine: [],
          reminderType: 1);

  // Weekly selector
  List selectedweekdays1 = List.filled(3, true);
  List selectedweekdays2 = List.filled(4, true);

  // UI rendering
  ScrollController _reminderTimeSelectionController = ScrollController();
  List<bool> weekdaysList1Selected = [true, true, true];
  List<DayInWeek> getweekdaysList1(BuildContext context) {
    debugPrint("getweekdaysList1 ==>");
    return [
      DayInWeek(Language.of(context)!.t("week_mon"),
          isSelected: weekdaysList1Selected[0]),
      DayInWeek(Language.of(context)!.t("week_tue"),
          isSelected: weekdaysList1Selected[1]),
      DayInWeek(Language.of(context)!.t("week_wed"),
          isSelected: weekdaysList1Selected[2]),
    ];
  }

  List<bool> weekdaysList2Selected = [true, true, true, true];
  List<DayInWeek> getweekdaysList2(BuildContext context) {
    debugPrint("getweekdaysList2 ==>");
    return [
      DayInWeek(Language.of(context)!.t("week_thu"),
          isSelected: weekdaysList2Selected[0]),
      DayInWeek(Language.of(context)!.t("week_fri"),
          isSelected: weekdaysList2Selected[1]),
      DayInWeek(Language.of(context)!.t("week_sat"),
          isSelected: weekdaysList2Selected[2]),
      DayInWeek(Language.of(context)!.t("week_sun"),
          isSelected: weekdaysList2Selected[3]),
    ];
  }

  // =========
  void updateExpiredTime() {
    timeExpireds = getReminderAllTimeExpired(reminder);
  }

  DateTime _convertSetAlarmDateTime(TimeOfDay newTime) {
    DateTime newDT = DateTime(_fromDate.year, _fromDate.month, _fromDate.day,
        newTime.hour, newTime.minute);
    if (reminder.weekdays1.isEmpty) {
      newDT = convertSelectTime(DateTime(_fromDate.year, _fromDate.month,
          _fromDate.day, newTime.hour, newTime.minute));
    }
    // debugPrint("_convertSetAlarmDateTime setTime: ${newDT.toString()}");
    return newDT;
  }

  void updateTime1ToModel(TimeOfDay newTime) {
    debugPrint("updateTime1ToModel setTime: ${newTime.toString()}");
    reminder = reminder.copyWith(time1: _convertSetAlarmDateTime(newTime));
  }

  void updateWeekdays1ToModel() {
    debugPrint("updateWeekdays1ToModel ================");
    List<int> newWeekdays = List.empty(growable: true);
    weekdaysList1Selected = List.filled(3, false);
    for (var i = 0; i < selectedweekdays1.length; i++) {
      int intWD = selectedweekdays1[i] ? i + 1 : -1;
      if (intWD > 0) {
        newWeekdays.add(intWD);
        weekdaysList1Selected[intWD - 1] = true;
      }
    }
    weekdaysList2Selected = List.filled(4, false);
    for (var i = 0; i < selectedweekdays2.length; i++) {
      int intWD = selectedweekdays2[i] ? i + 4 : -1;
      if (intWD > 0) {
        newWeekdays.add(intWD);
        weekdaysList2Selected[intWD - 4] = true;
      }
    }
    debugPrint("weekdaysList1Selected ${weekdaysList1Selected.toString()}");
    debugPrint("weekdaysList2Selected ${weekdaysList2Selected.toString()}");
    newWeekdays.sort((a, b) => a.compareTo(b));
    reminder = reminder.copyWith(weekdays1: newWeekdays);

    // reset alarm time -> not adding 1 day if will be loop OR adding back 1day if no loop
    updatingAlarmTime(timeOfDay1, 1);
    updatingAlarmTime(timeOfDay2, 2);
    updatingAlarmTime(timeOfDay3, 3);
    updatingAlarmTime(timeOfDay4, 4);
    debugPrint("updateWeekdays1ToModel ================");
  }

  void updateWeekDaysByOnce(bool all) {
    debugPrint("updateWeekDaysByOnce ================");
    if (all) {
      selectedweekdays1 = List.filled(3, true);
      selectedweekdays2 = List.filled(4, true);
    } else {
      selectedweekdays1 = List.empty(growable: true);
      selectedweekdays2 = List.empty(growable: true);
    }
    debugPrint("selectedweekdays1 : ${selectedweekdays1.toString()}");
    debugPrint("selectedweekdays2 : ${selectedweekdays2.toString()}");
    updateWeekdays1ToModel();
  }

  // set other alarm
  void updateAlarmNum(bool add) {
    if (add) {
      setState(() {
        if (timerNum < 4) {
          timerNum++;
        } else {
          showSnackMsg(
              context, Language.of(context)!.t("reminder_new2_settimer_max"));
        }
      });
    } else {
      setState(() {
        if (timerNum > 1) {
          timerNum--;
        } else {
          showSnackMsg(
              context, Language.of(context)!.t("reminder_new2_settimer_min"));
        }
      });
    }
    if (reminder.reminderType != timerNum) {
      debugPrint("Updaing reminder reminderType");
      reminder = reminder.copyWith(reminderType: timerNum);
    }
  }

  void updateTime2ToModel(TimeOfDay newTime) {
    debugPrint("updateTime2ToModel setTime: ${newTime.toString()}");
    reminder = reminder.copyWith(time2: _convertSetAlarmDateTime(newTime));
  }

  void updateTime3ToModel(TimeOfDay newTime) {
    debugPrint("updateTime3ToModel setTime: ${newTime.toString()}");
    reminder = reminder.copyWith(time3: _convertSetAlarmDateTime(newTime));
  }

  void updateTime4ToModel(TimeOfDay newTime) {
    debugPrint("updateTime4ToModel setTime: ${newTime.toString()}");
    reminder = reminder.copyWith(time4: _convertSetAlarmDateTime(newTime));
  }

  // UI
  // void openTimePicker(TimeOfDay intialTime, {alarmNo = 1}) async {
  //   TimeOfDay? newtime = await showStyledTimePicker(context, intialTime,
  //       errorInvalidText:
  //           Language.of(context)!.t("reminder_new2_timepicker_error"),
  //       helpText: Language.of(context)!.t("reminder_new2_settimer1"),
  //       confirmText: Language.of(context)!.t("common_confirm"),
  //       cancelText: Language.of(context)!.t("common_cancel"));

  //   updatingAlarmTime(newtime, alarmNo: alarmNo);
  // }

  void openDayNightTimePicker(TimeOfDay intialTime, int alarmNo) {
    showDayNightTimePicker(context, intialTime,
        iosStylePicker: Displayer.currenTimepickerStyle(context) == 2,
        confirmText: Language.of(context)!.t("common_confirm"),
        cancelText: Language.of(context)!.t("common_cancel"),
        hourLabel: Language.of(context)!.t("timepicker_hr"),
        minuteLabel: Language.of(context)!.t("timepicker_min"),
        onChangeDateTime: (datetime) {
      debugPrint("onChangeDateTime: ${datetime.hour}:${datetime.minute}");
      updatingAlarmTime(TimeOfDay.fromDateTime(datetime), alarmNo);
    });
  }

  void updatingAlarmTime(TimeOfDay? newtime, int alarmNo) {
    if (newtime == null) return;

    setState(() {
      switch (alarmNo) {
        case 1:
          timeOfDay1 = newtime;
          updateTime1ToModel(timeOfDay1);
          break;
        case 2:
          timeOfDay2 = newtime;
          updateTime2ToModel(timeOfDay2);
          break;
        case 3:
          timeOfDay3 = newtime;
          updateTime3ToModel(timeOfDay3);
          break;
        case 4:
          timeOfDay4 = newtime;
          updateTime4ToModel(timeOfDay4);
          break;
        default:
      }
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

  // TutorialCoachMark =======
  late TutorialCoachMark tutorialCoachMark;
  GlobalKey key1 = GlobalKey();
  GlobalKey key2 = GlobalKey();
  GlobalKey key3 = GlobalKey();
  GlobalKey key4 = GlobalKey();

  void showTutorial() {
    tutorialCoachMark.show(context: context);
  }

  void setUpTutorial() {
    if (Displayer.currenTutorialSetting(context) ==
            Displayer.codeTutorialModeInitial ||
        Displayer.currenTutorialSetting(context) ==
            Displayer.codeTutorialModeOn) {
      tutorialCoachMark = createTutorial(
          pageRouteReminderNew2, context, [key1, key2, key3, key4]);
      Future.delayed(
          const Duration(milliseconds: tutorialShowTime), showTutorial);
    }
  }
  // TutorialCoachMark =======

  // safety Overlay
  OverlayEntry? overlayEntry;
  void createOverlay() {
    removeOverly();
    assert(overlayEntry == null);
    overlayEntry = creatingOverlay();
    Overlay.of(context, debugRequiredFor: widget).insert(overlayEntry!);
  }

  void removeOverly() {
    overlayEntry?.remove();
    overlayEntry = null;
  }
  // ===================

  @override
  void initState() {
    updateWeekdays1ToModel();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      createOverlay();
      setUpTutorial();
    });
    super.initState();
    Future.delayed(const Duration(milliseconds: progressBarDelayShowTime))
        .then((value) => setState(() {
              progressIdx = progressIdxStep1;
            }));
    Future.delayed(const Duration(milliseconds: safetyOverlayRmTime))
        .then((value) => removeOverly());
  }

  @override
  void dispose() {
    _reminderTimeSelectionController.dispose();
    removeOverly();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: safeAreaPaddingAll),
          child: Center(
            child: Column(
              children: <Widget>[
                DelayedDisplay(
                    slidingBeginOffset: const Offset(0.0, -0.35),
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: safeAreaPaddingAll),
                        child: ReminderHeader(
                          progressText:
                              "${Language.of(context)!.t("common_step")} ( 2 / 3 )",
                          progressValue: progressIdx,
                          headerText:
                              Language.of(context)!.t("reminder_new2_msg"),
                        ))),
                Expanded(
                  child: DelayedDisplay(
                      delay: Duration(milliseconds: pageContentDelayShowTime),
                      child: CusScrollbar(
                          scrollController: _reminderTimeSelectionController,
                          child: ListView(
                              controller: _reminderTimeSelectionController,
                              physics: AlwaysScrollableScrollPhysics(
                                  parent: BouncingScrollPhysics()),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: safeAreaPaddingAll),
                              children: [
                                Container(
                                    margin: EdgeInsets.only(
                                        bottom: elementSSPadding),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: CusSText(
                                            Language.of(context)!
                                                .t("reminder_new2_settimer1"),
                                          ),
                                        ),
                                        SimpleCounter(
                                          key: key2,
                                          value: timerNum,
                                          onPressedMinus: () =>
                                              updateAlarmNum(false),
                                          onPressedAdd: () =>
                                              updateAlarmNum(true),
                                        )
                                      ],
                                    )),
                                Container(
                                    margin: EdgeInsets.only(bottom: 12),
                                    child: CusNButton(
                                      fromTimeToString(reminder.time1,
                                          weekdays: reminder.weekdays1,
                                          dateTxts: [
                                            Language.of(context)!
                                                .t("day_today"),
                                            Language.of(context)!.t("day_tmr")
                                          ]),
                                      () =>
                                          openDayNightTimePicker(timeOfDay1, 1),
                                      icon: Icon(Icons.alarm_add),
                                      key: key1,
                                    )),
                                AnimatedSize(
                                  duration: const Duration(milliseconds: 200),
                                  child: timerNum >= 2
                                      ? Container(
                                          margin: EdgeInsets.only(bottom: 12),
                                          child: CusNButton(
                                            fromTimeToString(reminder.time2!,
                                                weekdays: reminder.weekdays1,
                                                dateTxts: [
                                                  Language.of(context)!
                                                      .t("day_today"),
                                                  Language.of(context)!
                                                      .t("day_tmr")
                                                ]),
                                            () => openDayNightTimePicker(
                                                timeOfDay2, 2),
                                            icon: Icon(Icons.alarm_add),
                                          ))
                                      : SizedBox.shrink(),
                                ),
                                AnimatedSize(
                                  duration: const Duration(milliseconds: 200),
                                  child: timerNum >= 3
                                      ? Container(
                                          margin: EdgeInsets.only(bottom: 12),
                                          child: CusNButton(
                                            fromTimeToString(reminder.time3!,
                                                weekdays: reminder.weekdays1,
                                                dateTxts: [
                                                  Language.of(context)!
                                                      .t("day_today"),
                                                  Language.of(context)!
                                                      .t("day_tmr")
                                                ]),
                                            () => openDayNightTimePicker(
                                                timeOfDay3, 3),
                                            icon: Icon(Icons.alarm_add),
                                          ))
                                      : SizedBox.shrink(),
                                ),
                                AnimatedSize(
                                  duration: const Duration(milliseconds: 200),
                                  child: timerNum >= 4
                                      ? Container(
                                          margin: EdgeInsets.only(bottom: 12),
                                          child: CusNButton(
                                            fromTimeToString(reminder.time4!,
                                                weekdays: reminder.weekdays1,
                                                dateTxts: [
                                                  Language.of(context)!
                                                      .t("day_today"),
                                                  Language.of(context)!
                                                      .t("day_tmr")
                                                ]),
                                            () => openDayNightTimePicker(
                                                timeOfDay4, 4),
                                            icon: Icon(Icons.alarm_add),
                                          ))
                                      : SizedBox.shrink(),
                                ),
                                LabeledSwitch(
                                  label: Language.of(context)!
                                      .t("reminder_new2_setrepeat1"),
                                  labelRight: Language.of(context)!
                                      .t("reminder_new2_allrepeat"),
                                  value: reminder.weekdays1.length == 7,
                                  onChanged: (bool newValue) {
                                    debugPrint(
                                        'LabeledSwitch : val = $newValue');
                                    setState(() {
                                      updateWeekDaysByOnce(newValue);
                                    });
                                  },
                                ),
                                Container(
                                  key: key3,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: buttonBorderColor,
                                          width: buttonBorderWidth),
                                      borderRadius: BorderRadius.circular(
                                          selectWeekDaysBorderRadius)),
                                  child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
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
                                                debugPrint(values.toString());
                                                selectedweekdays1 =
                                                    List.from(values);
                                                debugPrint(
                                                    "selectedweekdays1 ${selectedweekdays1.toString()}");
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
                                                debugPrint(values.toString());
                                                selectedweekdays2 =
                                                    List.from(values);
                                                debugPrint(
                                                    "selectedweekdays2 ${selectedweekdays2.toString()}");
                                                updateWeekdays1ToModel();
                                              });
                                            }),
                                      ]),
                                ),
                              ]))),
                ),
                DelayedDisplay(
                    delay: Duration(milliseconds: pageBottomDelayShowTime),
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: safeAreaPaddingAll),
                        child: Column(
                          children: [
                            Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  border: Border(top: BorderSide()),
                                )),
                            // CusCardContainer(
                            //     child: SizedBox(
                            //         height: MediaQuery.of(context).size.height *
                            //             reminderCardHeightRatio,
                            //         child: ListView(
                            //           padding: EdgeInsets.all(12),
                            //           children: [
                            //             Visibility(
                            //               maintainSize: true,
                            //               maintainAnimation: true,
                            //               maintainState: true,
                            //               visible: setMorning,
                            //               child: Row(children: [
                            //                 Icon(
                            //                   Icons.alarm_on_outlined,
                            //                   size: 14,
                            //                 ),
                            //                 SizedBox(width: 2),
                            //                 CusExSText(Language.of(context)!
                            //                     .t("reminder_new2_settimer2")),
                            //               ]),
                            //             ),
                            //             TimeSectionDisplay(
                            //               padding:
                            //                   const EdgeInsets.only(top: 2, bottom: 8),
                            //               times: [fromTimeOfDayToString(timeOfDay1)],
                            //             ),
                            //             Visibility(
                            //               maintainSize: true,
                            //               maintainAnimation: true,
                            //               maintainState: true,
                            //               visible: true,
                            //               child: Row(children: [
                            //                 Icon(
                            //                   Icons.event_repeat_outlined,
                            //                   size: 14,
                            //                 ),
                            //                 SizedBox(width: 2),
                            //                 CusExSText(Language.of(context)!
                            //                     .t("reminder_new2_setrepeat2")),
                            //               ]),
                            //             ),
                            //             Visibility(
                            //                 maintainSize: true,
                            //                 maintainAnimation: true,
                            //                 maintainState: true,
                            //                 visible: true,
                            //                 child: WeekdaysDisplay(
                            //                   reminder: reminder,
                            //                   padding: const EdgeInsets.only(
                            //                       top: 2, bottom: 8),
                            //                 )),
                            //           ],
                            //         ))),
                            Row(
                              children: [
                                Expanded(
                                  child: CusNBackButton(
                                      Language.of(context)!.t("common_back"),
                                      () => {
                                            removeCurrentSnavkBar(context),
                                            Navigator.pop(context)
                                          }),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  key: key4,
                                  child: CusNButton(
                                      Language.of(context)!.t("common_next"),
                                      () {
                                    removeCurrentSnavkBar(context);
                                    if (checkOneOfTimeIsExpired(
                                        getReminderAllTimeExpired(reminder))) {
                                      showSnackMsg(
                                          context,
                                          Language.of(context)!.t(
                                              "reminder_new2_settimer_expired"));
                                      return;
                                    }
                                    Navigator.pushNamed(
                                        context, pageRouteReminderDetail,
                                        arguments: ReminderScreenArg(reminder));
                                  }),
                                ),
                              ],
                            ),
                          ],
                        )))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
