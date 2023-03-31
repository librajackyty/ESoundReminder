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
import '../widgets/reminder_weekdays_display.dart';
import '../widgets/time_section_display.dart';

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
        readOnly: true,
      ));
      mwList.add(const SizedBox(
        height: 8.0,
      ));
    }
    return mwList;
  }

  Widget settedTime(Reminder reminder) {
    return TimeSectionDisplay(
      largeTxt: true,
      alignment: Alignment.center,
      times: [fromTimeToString(reminder.time1)],
    );
    // return Row(
    //     mainAxisAlignment: MainAxisAlignment.start,
    //     children: [CusTitleText(timeText)]);
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
              showLottieDialog("112180-paper-notebook-writing-animation");
              reminder = reminder.copyWith(
                  reminderTitle:
                      "${fromTimeToString(reminder.time1)} ${Language.of(context)?.t("localnotification_title")}",
                  reminderDescription:
                      "${Language.of(context)?.t("localnotification_subtitle")} - ${reminder.selectedMedicine.join(",")}");
              final model = context.read<ReminderModel>();
              await model.addReminder(reminder);
              await Future.delayed(const Duration(seconds: 5));
              if (context.mounted) {
                backToHomePage();
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
            onPressed: () async {
              showLottieDialog("131686-deleted");
              await Future.delayed(const Duration(seconds: 4));
              backToHomePage();
            },
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
              showLottieDialog("131686-deleted");
              final model = context.read<ReminderModel>();
              await model.deleteReminder(reminder, index);
              await Future.delayed(const Duration(seconds: 4));
              if (context.mounted) {
                backToHomePage();
              }
            },
            child: CusSText(Language.of(context)!.t("common_yes")),
          ),
        ],
      ),
    );
  }

  void showLottieDialog(String lottiefileName,
      {Function? onLoaded, repeat = true}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Lottie.asset(
                assetslinkLottie(lottiefileName),
                repeat: repeat,
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.width * 0.5,
                onLoaded: (p0) {
                  debugPrint("ani loaded");
                  onLoaded != null ? onLoaded() : () {};
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void backToHomePage() {
    Navigator.pushNamedAndRemoveUntil(
        context, pageRouteHome, ((route) => false));
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
                    : const SizedBox(),
                // CusNText(
                //     Language.of(context)!.t("reminder_detail_title"),
                //     textAlign: TextAlign.center,
                //   ),
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
                                  settedTime(reminder),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(children: [
                                    Icon(Icons.event_repeat_outlined),
                                    SizedBox(width: 6),
                                    CusSText(Language.of(context)!
                                        .t("reminder_detail_setrepeat")),
                                  ]),
                                  WeekdaysDisplay(
                                    reminder: reminder,
                                    padding: EdgeInsets.all(16),
                                    alignment: Alignment.center,
                                    largeTxt: true,
                                  ),
                                  // CusNText(
                                  //     showingRepeatWeekdays(context, reminder)
                                  //     // "一, 二, 三, 六, 日",
                                  //     ),
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
