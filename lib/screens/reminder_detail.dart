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
import '../utils/dialog.dart';
import '../utils/formatter.dart';
import '../widgets/ani_progress_bar.dart';
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
  double progressIdx = 0;
  double progressIdxStep1 = 70;
  double progressIdxStep2 = 90;
  double progressIdxStep3 = 100;
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
  }

  void showConfirmDialog() {
    setState(() {
      progressIdx = progressIdxStep2;
    });
    showDialogLottie(context,
        lottieFileName: '112180-paper-notebook-writing-animation',
        title: CusSText('${Language.of(context)!.t("common_save")}?'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CusNText(
              Language.of(context)!.t("reminder_detail_confirmquestion"),
              textAlign: TextAlign.center,
            ),
            const Divider(),
            Column(
              children: [
                Lottie.asset(
                  assetslinkLottie('92326-warning-red'),
                  width: 30,
                  height: 30,
                ),
                CusSText(
                  Language.of(context)!.t("reminder_detail_notice"),
                  textAlign: TextAlign.center,
                )
              ],
            )
          ],
        ), noBtnOnPressed: () {
      setState(() {
        progressIdx = progressIdxStep1;
      });
      Navigator.pop(context, 'NO');
    }, yesBtnOnPressed: () async {
      setState(() {
        progressIdx = progressIdxStep3;
      });
      showDialogLottieIcon(context, lottieFileName: "95029-success");
      reminder = reminder.copyWith(
          reminderTitle:
              "${fromTimeToString(reminder.time1)} ${Language.of(context)?.t("localnotification_title")}",
          reminderDescription:
              "${Language.of(context)?.t("localnotification_subtitle")} - ${reminder.selectedMedicine.join(",")}");
      final model = context.read<ReminderModel>();
      await model.addReminder(reminder);
      await Future.delayed(const Duration(seconds: 2));
      if (context.mounted) {
        backToHomePage();
      }
    });
  }

  void showCancelDialog() {
    showDialogLottie(context,
        lottieFileName: '117330-warning',
        title: CusSText('${Language.of(context)!.t("common_cancel")}?'),
        content: CusNText(
          Language.of(context)!.t("reminder_detail_cancelquestion"),
          textAlign: TextAlign.center,
        ),
        noBtnOnPressed: () => Navigator.pop(context, 'NO'),
        yesBtnOnPressed: () async {
          setState(() {
            progressIdx = 0;
          });
          backToHomePage();
        });
  }

  void showDeleteDialog() {
    showDialogLottie(context,
        lottieFileName: '131686-deleted',
        title: CusSText('${Language.of(context)!.t("common_delete")}?'),
        content: CusNText(
          Language.of(context)!.t("reminder_detail_deletequestion"),
          textAlign: TextAlign.center,
        ),
        noBtnOnPressed: () => Navigator.pop(context, 'NO'),
        yesBtnOnPressed: () async {
          showDialogLottieIcon(context, lottieFileName: "95029-success");
          final model = context.read<ReminderModel>();
          await model.deleteReminder(reminder, index);
          await Future.delayed(const Duration(seconds: 2));
          if (context.mounted) {
            backToHomePage();
          }
        });
  }

  void backToHomePage() {
    Navigator.pushNamedAndRemoveUntil(
        context, pageRouteHome, ((route) => false));
  }

  @override
  void initState() {
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                widget.title == pageNameReminderDetail
                    ? Row(
                        children: [
                          CusExSText(
                              "${Language.of(context)!.t("common_step")} ( 3 / 3 )"),
                          Expanded(
                              child: Container(
                                  padding:
                                      EdgeInsets.only(left: elementSPadding),
                                  child: AniProgressBar(
                                      currentValue: progressIdx))),
                        ],
                      )
                    : const SizedBox(),
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
                                    reverse: true,
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
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.alarm_on_outlined),
                                        SizedBox(width: 6),
                                        CusSText(Language.of(context)!
                                            .t("reminder_detail_settimer")),
                                      ]),
                                  settedTime(reminder),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
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
                                    displayAll: true,
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                ],
                              ),
                            ),
                            const Divider(),
                            Container(
                                padding: EdgeInsets.all(8.0),
                                child: widget.title == pageNameReminderDetail
                                    ? Row(children: [
                                        Expanded(
                                          child: CusNBackButton(
                                              Language.of(context)!
                                                  .t("common_cancel"),
                                              showCancelDialog),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Expanded(
                                          child: CusNButton(
                                              Language.of(context)!
                                                  .t("common_save"),
                                              showConfirmDialog),
                                        ),
                                      ])
                                    : CusNBackButton(
                                        Language.of(context)!
                                            .t("common_delete"),
                                        showDeleteDialog))
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
    return Align(
      alignment: Alignment.bottomCenter,
      child: CusNBackButton(Language.of(context)!.t("common_back"),
          () => {Navigator.pop(context)}),
    );
  }
}
