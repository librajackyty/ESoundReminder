import 'package:e_sound_reminder_app/widgets/custom_button_normal.dart';
import 'package:flutter/material.dart';

import '../models/language.dart';
import '../models/reminder.dart';
import '../models/reminder_screen_arg.dart';
import '../utils/constants.dart';
import '../utils/formatter.dart';
import '../widgets/custom_button_normal_back.dart';
import '../widgets/custom_button_small.dart';
import '../widgets/custom_text_normal.dart';
import '../widgets/custom_text_small.dart';
import '../widgets/custom_text_small_ex.dart';
import '../widgets/custom_text_title.dart';

class ReminderDetailPage extends StatefulWidget {
  const ReminderDetailPage({super.key, required this.title, this.arg});

  final String title;
  final ReminderScreenArg? arg;

  @override
  State<ReminderDetailPage> createState() => _ReminderDetailPageState();
}

class _ReminderDetailPageState extends State<ReminderDetailPage> {
  // Data
  late Reminder reminder = widget.arg?.reminder ??
      Reminder(
          reminderTitle: "",
          time1: DateTime.now(),
          weekdays1: [],
          selectedMedicine: []);

  List dSelectedMedicine = [
    // "脷底丸",
    // "降膽固醇",
    // "抗糖尿病",
    // "降血壓藥",
  ];

  // UI
  List<Widget> medicineSelectedArea(List selectedlist) {
    List<Widget> mwList = [];
    for (var medicine in selectedlist) {
      mwList.add(CusNButton(
        "$medicine",
        () {},
      ));
      mwList.add(const SizedBox(
        height: 8.0,
      ));
    }
    return mwList;
  }

  Widget settedTime(String timeText) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      // Icon(Icons.alarm),
      // SizedBox(width: 8),
      CusTitleText(timeText)
    ]);
  }

  String showingRepeatWeekdays(BuildContext context) {
    if (reminder.weekdays1.isEmpty) {
      return Language.of(context)!.t("reminder_new2_setrepeat3");
    }
    if (reminder.weekdays1.length >= 7) {
      return Language.of(context)!.t("reminder_new2_setrepeat4");
    }
    List<String> weekdaysStr = [];
    for (var dNum in reminder.weekdays1) {
      weekdaysStr.add(fromWeekdayToString(context, dNum));
    }
    return weekdaysStr.join(", ");
  }

  void showConfirmDialog() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: CusSText('${Language.of(context)!.t("common_save")}?'),
        content: CusNText(
            Language.of(context)!.t("reminder_detail_confirmquestion")),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'NO'),
            child: CusSText(Language.of(context)!.t("common_no")),
          ),
          TextButton(
            onPressed: () => Navigator.pushNamedAndRemoveUntil(
                context, pageRouteHome, ((route) => false)),
            child: CusSText(Language.of(context)!.t("common_yes")),
          ),
        ],
      ),
    );
  }

  void showCancelDialog() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: CusSText('${Language.of(context)!.t("common_cancel")}?'),
        content:
            CusNText(Language.of(context)!.t("reminder_detail_cancelquestion")),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'NO'),
            child: CusSText(Language.of(context)!.t("common_no")),
          ),
          TextButton(
            onPressed: () => Navigator.pushNamedAndRemoveUntil(
                context, pageRouteHome, ((route) => false)),
            child: CusSText(Language.of(context)!.t("common_yes")),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                CusExSText("${Language.of(context)!.t("common_step")} (3/3)"),
                // CusSText(
                //   'Reminder Detail:',
                // ),
                const SizedBox(
                  height: 12,
                ),
                Expanded(
                  child: Card(
                      margin: const EdgeInsets.only(
                          bottom: reminderCardBottomMargin),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Colors.greenAccent,
                        ),
                        borderRadius: BorderRadius.circular(cardsBorderRadius),
                      ),
                      elevation: cardsElevation,
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // CusSText("Set timer to:"),
                            // settedTime("07:00"),
                            // settedTime("12:00"),
                            // settedTime("18:30"),
                            // CusSText("Set repeat on:"),
                            // CusNText("Monday, Friday"),
                            // const SizedBox(
                            //   height: 12,
                            // ),
                            // CusSText("Take medince of:"),
                            // Expanded(
                            //   child: GridView.count(
                            //       primary: true,
                            //       padding: const EdgeInsets.all(10),
                            //       crossAxisSpacing: 8,
                            //       mainAxisSpacing: 8,
                            //       crossAxisCount: 3,
                            //       children:
                            //           medicineSelectedArea(selectedMedicine)),
                            // ),
                            Expanded(
                              child: ListView(
                                padding: const EdgeInsets.all(12),
                                children: [
                                  Row(children: [
                                    Icon(Icons.alarm_on_outlined),
                                    SizedBox(width: 6),
                                    CusSText(Language.of(context)!
                                        .t("reminder_detail_settimer")),
                                  ]),
                                  settedTime(fromTimeToString(reminder.time1)),
                                  // settedTime("12:00"),
                                  // settedTime("18:30"),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Row(children: [
                                    Icon(Icons.event_repeat_outlined),
                                    SizedBox(width: 6),
                                    CusSText(Language.of(context)!
                                        .t("reminder_detail_setrepeat")),
                                  ]),
                                  CusNText(showingRepeatWeekdays(context)
                                      // "一, 二, 三, 六, 日",
                                      ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Row(children: [
                                    Icon(Icons.medication_outlined),
                                    SizedBox(width: 6),
                                    CusSText(Language.of(context)!
                                        .t("reminder_detail_selectmedicine"))
                                  ]),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  ...medicineSelectedArea(
                                      reminder.selectedMedicine)
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Container(
                                margin: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  border: Border(top: BorderSide()),
                                )),
                            const SizedBox(
                              height: 4,
                            ),
                            Container(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    CusNButton(
                                        Language.of(context)!.t("common_save"),
                                        showConfirmDialog),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    CusNBackButton(
                                        Language.of(context)!
                                            .t("common_cancel"),
                                        showCancelDialog),
                                  ],
                                ))
                          ],
                        ),
                      )),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: CusNBackButton(Language.of(context)!.t("common_back"),
                      () => {Navigator.pop(context)}),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
