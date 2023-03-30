import 'package:e_sound_reminder_app/widgets/custom_button_normal.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../models/language.dart';
import '../models/reminder.dart';
import '../models/reminder_screen_arg.dart';
import '../providers/reminders/reminders_provider.dart';
import '../utils/assetslink.dart';
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
  late int index = widget.arg?.index ?? 0;

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
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [CusTitleText(timeText)]);
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
            onPressed: () async {
              reminder = reminder.copyWith(
                  reminderTitle:
                      "${fromTimeToString(reminder.time1)} ${Language.of(context)?.t("localnotification_title")}",
                  reminderDescription:
                      "${Language.of(context)?.t("localnotification_subtitle")} - ${reminder.selectedMedicine.join(",")}");
              final model = context.read<ReminderModel>();
              await model.addReminder(reminder);
              if (context.mounted) {
                Navigator.pushNamedAndRemoveUntil(
                    context, pageRouteHome, ((route) => false));
              }
            },
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

  void showDeleteDialog() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: CusSText('${Language.of(context)!.t("common_delete")}?'),
        content:
            CusNText(Language.of(context)!.t("reminder_detail_deletequestion")),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'NO'),
            child: CusSText(Language.of(context)!.t("common_no")),
          ),
          TextButton(
            onPressed: () async {
              final model = context.read<ReminderModel>();
              await model.deleteReminder(reminder, index);
              if (context.mounted) {
                Navigator.pushNamedAndRemoveUntil(
                    context, pageRouteHome, ((route) => false));
              }
            },
            child: CusSText(Language.of(context)!.t("common_yes")),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
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
                widget.title == pageNameReminderDetail
                    ? CusExSText(
                        "${Language.of(context)!.t("common_step")} (3/3)")
                    : CusNText(
                        Language.of(context)!.t("reminder_detail_title"),
                        textAlign: TextAlign.center,
                      ),
                widget.title == pageNameReminderDetail
                    ? CusSText(
                        Language.of(context)!.t("reminder_detail_msg"),
                        textAlign: TextAlign.center,
                      )
                    : const SizedBox(),
                const SizedBox(
                  height: 8,
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
                                padding:
                                    const EdgeInsets.only(left: 12, right: 12),
                                children: [
                                  Lottie.asset(
                                    assetslinkLottie('61069-medicine-pills'),
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    height:
                                        MediaQuery.of(context).size.width * 0.3,
                                  ),
                                  ...medicineSelectedArea(
                                      reminder.selectedMedicine),
                                  const SizedBox(
                                    height: 8,
                                  ),
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
                                    height: 8,
                                  ),
                                  Row(children: [
                                    Icon(Icons.event_repeat_outlined),
                                    SizedBox(width: 6),
                                    CusSText(Language.of(context)!
                                        .t("reminder_detail_setrepeat")),
                                  ]),
                                  CusNText(
                                      showingRepeatWeekdays(context, reminder)
                                      // "一, 二, 三, 六, 日",
                                      ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  // Row(children: [
                                  //   Icon(Icons.medication_outlined),
                                  //   SizedBox(width: 6),
                                  //   CusSText(Language.of(context)!
                                  //       .t("reminder_detail_selectmedicine"))
                                  // ]),
                                  // const SizedBox(
                                  //   height: 8.0,
                                  // ),
                                  // ...medicineSelectedArea(
                                  //     reminder.selectedMedicine)
                                ],
                              ),
                            ),
                            const Divider(),
                            // const SizedBox(
                            //   height: 4,
                            // ),
                            // Container(
                            //     margin: EdgeInsets.all(8),
                            //     decoration: BoxDecoration(
                            //       border: Border(top: BorderSide()),
                            //     )),
                            // const SizedBox(
                            //   height: 4,
                            // ),
                            Container(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  children:
                                      widget.title == pageNameReminderDetail
                                          ? [
                                              // CusNButton(
                                              //     Language.of(context)!
                                              //         .t("common_save"),
                                              //     showConfirmDialog),
                                              // const SizedBox(
                                              //   height: 8,
                                              // ),
                                              CusNBackButton(
                                                  Language.of(context)!
                                                      .t("common_cancel"),
                                                  showCancelDialog),
                                            ]
                                          : [
                                              CusNBackButton(
                                                  Language.of(context)!
                                                      .t("common_delete"),
                                                  showDeleteDialog)
                                            ],
                                ))
                          ],
                        ),
                      )),
                ),
                createBottomActionBar(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget createBottomActionBar(BuildContext context) {
    if (widget.title == pageNameReminderDetail) {
      return Row(
        children: [
          Expanded(
            child: CusNBackButton(Language.of(context)!.t("common_back"),
                () => {Navigator.pop(context)}),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: CusNButton(
                Language.of(context)!.t("common_save"), showConfirmDialog),
          ),
        ],
      );
    }
    return Align(
      alignment: Alignment.bottomCenter,
      child: CusNBackButton(Language.of(context)!.t("common_back"),
          () => {Navigator.pop(context)}),
    );
  }
}
