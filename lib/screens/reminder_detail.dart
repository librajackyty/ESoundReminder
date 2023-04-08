import 'package:delayed_display/delayed_display.dart';
import 'package:e_sound_reminder_app/models/displayer.dart';
import 'package:e_sound_reminder_app/widgets/custom_button_normal.dart';
import 'package:e_sound_reminder_app/widgets/page_bottom_area.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../models/language.dart';
import '../models/reminder.dart';
import '../models/reminder_screen_arg.dart';
import '../providers/reminders/reminders_provider.dart';
import '../utils/assetslink.dart';
import '../utils/constants.dart';
import '../utils/dialog.dart';
import '../utils/feedback.dart';
import '../utils/formatter.dart';
import '../utils/tutorial.dart';
import '../widgets/custom_button_normal_back.dart';
import '../widgets/custom_card_container.dart';
import '../widgets/custom_scroll_bar.dart';
import '../widgets/custom_text_normal.dart';
import '../widgets/custom_text_small.dart';
import '../widgets/reminder_header.dart';
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
  double progressIdxStep2 = 80;
  double progressIdxStep3 = 90;
  double progressIdxStep4 = 100;
  late Reminder reminder = widget.arg?.reminder ??
      Reminder(
          reminderTitle: "",
          time1: DateTime.now(),
          weekdays1: [],
          selectedMedicine: [],
          reminderType: 1);
  late int index = widget.arg?.index ?? 0;

  bool checkOpenAsNewDetailPage() {
    return widget.title == pageNameReminderDetail;
  }

  // UI
  ScrollController _reminderDSVController = ScrollController();
  List<Widget> medicineSelectedArea(List selectedlist) {
    List<Widget> mwList = [];
    for (var i = 0; i < selectedlist.length; i++) {
      mwList.add(CusNButton(
        "${selectedlist[i]}",
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
    debugPrint("settedTime ==============");
    debugPrint("reminder reminderType: ${reminder.reminderType}");
    debugPrint("reminder time1: ${reminder.time1}");
    List<String> times = [];
    for (var i = 0; i < reminder.reminderType; i++) {
      DateTime dt;
      switch (i) {
        case 0:
          dt = reminder.time1;
          break;
        case 1:
          dt = reminder.time2!;
          break;
        case 2:
          dt = reminder.time3!;
          break;
        case 3:
          dt = reminder.time4!;
          break;
        default:
          dt = reminder.time1;
      }
      if (checkReminderTimesAreSameDay(reminder) &&
          reminder.reminderType > 1 &&
          reminder.weekdays1.isEmpty) {
        times.add(fromSameDayTimeToString(dt,
            dateTxts: checkReminderAllTimeAreExpired(
                    getReminderAllTimeExpired(reminder))
                ? []
                : [
                    Language.of(context)!.t("day_today"),
                    Language.of(context)!.t("day_tmr"),
                    Language.of(context)!.t("day_expired"),
                  ]));
      } else {
        times.add(fromTimeToString(dt,
            weekdays: reminder.weekdays1,
            longFormat: reminder.reminderType == 1 ||
                (reminder.reminderType > 1 &&
                    reminder.weekdays1.isEmpty &&
                    !checkReminderTimesAreSameDay(reminder)),
            dateTxts: [
              Language.of(context)!.t("day_today"),
              Language.of(context)!.t("day_tmr"),
              Language.of(context)!.t("day_expired"),
            ]));
      }
    }
    return TimeSectionDisplay(
        padding: EdgeInsets.symmetric(
            vertical: elementLPadding, horizontal: elementSSPadding),
        largeTxt: true,
        alignment: Alignment.center,
        header: reminder.reminderType > 1 &&
                reminder.weekdays1.isEmpty &&
                checkReminderTimesAreSameDay(reminder)
            ? fromTimeToDateLongString(reminder, dateTxts: [
                Language.of(context)!.t("day_today"),
                Language.of(context)!.t("day_tmr"),
                Language.of(context)!.t("day_expired"),
              ])
            : null,
        times: times,
        expiredTimes: getReminderAllTimeExpired(reminder),
        allTimeAreExpired: checkReminderAllTimeAreExpired(
            getReminderAllTimeExpired(reminder)));
  }

  void showNoticeDialog() {
    setState(() {
      progressIdx = progressIdxStep2;
    });
    showDialogLottie(context,
        lottieFileName: '92326-warning-red',
        content: CusSText(
          Language.of(context)!.t("reminder_detail_notice"),
          textAlign: TextAlign.center,
        ),
        noBtnTxtKey: "common_back",
        yesBtnTxtKey: "common_understand", noBtnOnPressed: () {
      Navigator.pop(context, 'NO');
      setState(() {
        progressIdx = progressIdxStep1;
      });
    }, yesBtnOnPressed: () {
      Navigator.pop(context, 'NO');
      showConfirmDialog();
    });
  }

  void showConfirmDialog() {
    setState(() {
      progressIdx = progressIdxStep3;
    });
    showDialogLottie(context,
        lottieFileName: '112180-paper-notebook-writing-animation',
        title: CusSText('${Language.of(context)!.t("common_save")}?'),
        content: CusNText(
          Language.of(context)!.t("reminder_detail_confirmquestion"),
          textAlign: TextAlign.center,
        ), noBtnOnPressed: () {
      setState(() {
        progressIdx = progressIdxStep1;
      });
      Navigator.pop(context, 'NO');
    }, yesBtnOnPressed: () async {
      setState(() {
        progressIdx = progressIdxStep4;
      });
      showDialogLottieIcon(context, lottieFileName: "95029-success");
      Future.delayed(const Duration(milliseconds: 200), () {
        runSaveFeedback();
      });
      reminder = reminder.copyWith(
          reminderTitle:
              "${Language.of(context)?.t("localnotification_title")}",
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

  void deleteAction() async {
    showDialogLottieIcon(context, lottieFileName: "95029-success");
    Future.delayed(const Duration(milliseconds: 200), () {
      runDeleteFeedback();
    });
    final model = context.read<ReminderModel>();
    await model.deleteReminder(reminder, index);
    await Future.delayed(const Duration(seconds: 2));
    if (context.mounted) {
      backToHomePage();
    }
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
        yesBtnOnPressed: deleteAction);
  }

  void showExpiredDeleteDialog() {
    if (!checkOpenAsNewDetailPage() &&
        checkReminderAllTimeAreExpired(getReminderAllTimeExpired(reminder))) {
      showDialogLottie(context,
          dismissible: false,
          lottieFileName: '131686-deleted',
          title: CusSText('${Language.of(context)!.t("common_delete")}?'),
          content: CusNText(
            Language.of(context)!.t("reminder_detail_expiredDelquestion"),
            textAlign: TextAlign.center,
          ),
          noBtnTxtKey: "common_back",
          noBtnOnPressed: () => Navigator.pop(context, 'NO'),
          yesBtnTxtKey: "common_delete",
          yesBtnOnPressed: deleteAction);
    }
  }

  void backToHomePage() {
    Navigator.pushNamedAndRemoveUntil(
        context, pageRouteHome, ((route) => false));
  }

  // TutorialCoachMark =======
  late TutorialCoachMark tutorialCoachMark;
  GlobalKey key1 = GlobalKey();
  GlobalKey key2 = GlobalKey();
  // GlobalKey key3 = GlobalKey();
  // GlobalKey key4 = GlobalKey();

  void showTutorial() {
    tutorialCoachMark.show(context: context);
  }

  void setUpTutorial() {
    if (Displayer.currenTutorialSetting(context) ==
            Displayer.codeTutorialModeInitial ||
        Displayer.currenTutorialSetting(context) ==
            Displayer.codeTutorialModeOn) {
      tutorialCoachMark = createTutorial(
        pageRouteReminderDetail,
        context,
        [key1, key2],
        onFinish: () {
          if (Displayer.currenTutorialSetting(context) ==
              Displayer.codeTutorialModeInitial) {
            Displayer.updateTutorialSetting(
                context, Displayer.codeTutorialModeOff);
          }
        },
      );
      Future.delayed(
          const Duration(milliseconds: tutorialShowTime), showTutorial);
    }
  }
  // TutorialCoachMark =======

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (checkOpenAsNewDetailPage()) {
        setUpTutorial();
      }
    });
    super.initState();
    Future.delayed(const Duration(milliseconds: progressBarDelayShowTime))
        .then((value) => setState(() {
              progressIdx = progressIdxStep1;
            }));
    Future.delayed(const Duration(milliseconds: askExpiredDelShowTime))
        .then((value) => showExpiredDeleteDialog());
  }

  @override
  void dispose() {
    _reminderDSVController.dispose();
    super.dispose();
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
                checkOpenAsNewDetailPage()
                    ? Container(
                        margin: EdgeInsets.only(bottom: elementSPadding),
                        child: DelayedDisplay(
                            slidingBeginOffset: const Offset(0.0, -0.35),
                            child: ReminderHeader(
                              progressText:
                                  "${Language.of(context)!.t("common_step")} ( 3 / 3 )",
                              progressValue: progressIdx,
                              headerText: Language.of(context)!
                                  .t("reminder_detail_msg"),
                              hasBottomDivider: false,
                            )))
                    : const SizedBox.shrink(),
                Expanded(
                    child: DelayedDisplay(
                  delay: Duration(milliseconds: pageContentDelayShowTime),
                  child: CusCardContainer(
                      child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: CusScrollbar(
                              isAlwaysShown: true,
                              scrollController: _reminderDSVController,
                              child: ListView(
                                key: key1,
                                controller: _reminderDSVController,
                                physics: AlwaysScrollableScrollPhysics(
                                    parent: BouncingScrollPhysics()),
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
                              )),
                        ),
                        const Divider(
                          color: dividerColor,
                        ),
                        Container(
                            padding: EdgeInsets.all(8.0),
                            child: checkOpenAsNewDetailPage()
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
                                      key: key2,
                                      child: CusNButton(
                                          Language.of(context)!
                                              .t("common_save"),
                                          showNoticeDialog),
                                    ),
                                  ])
                                : CusNBackButton(
                                    Language.of(context)!.t("common_delete"),
                                    showDeleteDialog))
                      ],
                    ),
                  )),
                )),
                DelayedDisplay(
                    delay: Duration(milliseconds: pageBottomDelayShowTime),
                    child: PageBottomArea())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
