import 'package:delayed_display/delayed_display.dart';
import 'package:e_sound_reminder_app/models/language.dart';
import 'package:e_sound_reminder_app/widgets/custom_text_small.dart';
import 'package:e_sound_reminder_app/widgets/custom_text_small_ex.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:vs_scrollbar/vs_scrollbar.dart';
import '../models/reminder_screen_arg.dart';
import '../providers/reminders/reminders_provider.dart';
import '../utils/assetslink.dart';
import '../utils/constants.dart' as constants;
import '../utils/constants.dart';
import '../utils/feedback.dart';
import '../widgets/custom_list_item.dart';
import '../widgets/custom_scroll_bar.dart';
import '../widgets/custom_text_normal.dart';
import '../widgets/reminder_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  late var stateReady = false;
  late final AnimationController aniController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  );
  late final Animation<double> animation = Tween(
    begin: 0.0,
    end: 1.0,
  ).animate(CurvedAnimation(
    parent: aniController,
    curve: Curves.easeInOut,
  ));

  late final AnimationController aniControllerBottom = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 800),
  );
  late final Animation<Offset> animationBottom = Tween<Offset>(
    begin: const Offset(0, 1),
    end: const Offset(0, 0),
  ).animate(CurvedAnimation(
    parent: aniControllerBottom,
    curve: Curves.decelerate,
  ));
  late final Animation<double> animationFAB = CurvedAnimation(
    parent: aniControllerBottom,
    curve: Curves.fastOutSlowIn,
  );
  ScrollController _reminderLVController = ScrollController();
  String listFilterBtnStrKey = "filter_all";
  ValueNotifier<int> selectedFilterIndex = ValueNotifier<int>(0);

  bool isFiltering() {
    return selectedFilterIndex.value > 0;
  }

  void showFilterSelection() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => DraggableScrollableSheet(
              initialChildSize: 0.5,
              minChildSize: 0.2,
              maxChildSize: 0.75,
              expand: false,
              builder: (_, controller) => Column(
                children: [
                  Icon(
                    Icons.remove,
                    color: Colors.grey[800],
                  ),
                  Expanded(
                      child: CusScrollbar(
                    scrollController: controller,
                    child: ListView.builder(
                      padding: EdgeInsets.all(elementMPadding),
                      controller: controller,
                      itemCount: filterKeys.length,
                      itemBuilder: (_, index) {
                        return CusListItm(
                          Language.of(context)!.t(filterKeys[index]),
                          iconData: filterIconData[index],
                          onTap: () {
                            Navigator.pop(context);
                            aniController.reverse();
                            Future.delayed(Duration(milliseconds: 400), () {
                              setState(() {
                                selectedFilterIndex.value = index;
                              });
                            });
                          },
                          selected: selectedFilterIndex.value == index,
                        );
                      },
                    ),
                  )),
                ],
              ),
            ));
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      aniController.forward();
      aniControllerBottom.forward();
      stateReady = true;
    });
    selectedFilterIndex.addListener(() {
      debugPrint("selectedFilterIndex val changes");
      Future.delayed(Duration.zero, () {
        setState(() {
          aniController.forward();
        });
        listFilterBtnStrKey = filterKeys[selectedFilterIndex.value];
        final model = context.read<ReminderModel>();
        model.filterReminder(selectedFilterIndex.value);
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    aniController.dispose();
    aniControllerBottom.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(safeAreaPaddingAllWthLv),
              child: FadeTransition(
                  opacity: animation, child: createReminderList())),
        ),
        floatingActionButton: ScaleTransition(
          scale: animationFAB,
          child: FloatingActionButton.large(
              onPressed: () => {
                    runHapticSound(type: HapticFeedbackType.medium),
                    Navigator.pushNamed(context, pageRouteReminderNew)
                  },
              elevation: 20.0,
              backgroundColor: Colors.green[500],
              tooltip: Language.of(context)!.t("home_add_tip"),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: buttonBorderWidth,
                  color: buttonBorderColor,
                ),
                borderRadius: BorderRadius.circular(cardsBorderRadius),
              ),
              child: Lottie.asset(
                assetslinkLottie('38580-addbutton'),
                width: 80,
                height: 80,
                fit: BoxFit.fill,
              )),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: SlideTransition(
          position: animationBottom,
          child: BottomAppBar(
            height: 160,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                    child: TextButton(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Lottie.asset(
                        assetslinkLottie('50432-notification-animation'),
                        width: 55,
                        height: 55,
                      ),
                      CusSText(
                        Language.of(context)!.t(listFilterBtnStrKey),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                  onPressed: () => {runHapticSound(), showFilterSelection()},
                )),
                Expanded(child: const SizedBox()),
                Expanded(
                    child: TextButton(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Lottie.asset(
                        assetslinkLottie('94350-gears-lottie-animation'),
                        width: 55,
                        height: 55,
                      ),
                      CusSText(
                        Language.of(context)!.t("settings_title"),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                  onPressed: () => {
                    runHapticSound(),
                    Navigator.pushNamed(context, constants.pageRouteSettings)
                  },
                ))
              ],
            ),
          ),
        ));
  }

  Widget createReminderList() {
    return Selector<ReminderModel, ReminderModel>(
        shouldRebuild: (previous, next) {
          debugPrint("createReminderList shouldRebuild");
          return true;
        },
        selector: (_, model) => model,
        builder: (context, model, child) {
          debugPrint("createReminderList builder Rebuild");
          debugPrint(
              "createReminderList model.remindersIntial len: ${model.remindersIntial?.length}");
          debugPrint(
              "createReminderList model.reminders len: ${model.reminders?.length}");
          if (model.remindersIntial != null &&
              model.remindersIntial!.isNotEmpty) {
            if (isFiltering() &&
                model.reminders != null &&
                model.reminders!.isEmpty) {
              return createNoFilterResult();
            }
            return Padding(
                padding: EdgeInsets
                    .zero, //const EdgeInsets.only(left: listviewPaddingAll, right: listviewPaddingAll),
                child: Column(children: [
                  DelayedDisplay(
                      slidingBeginOffset: const Offset(0.0, -0.35),
                      child: createAppBar()),
                  Expanded(
                    child: CusScrollbar(
                        scrollController: _reminderLVController,
                        child: ListView.builder(
                          controller: _reminderLVController,
                          shrinkWrap: true,
                          padding: EdgeInsets.fromLTRB(
                              listviewPaddingAll, 0, listviewPaddingAll, 40),
                          itemCount: model.reminders!.length,
                          itemBuilder: (_, index) {
                            if (index >= model.reminders!.length) {
                              return Container();
                            }
                            var reminder = model.reminders![index];
                            debugPrint("reminder id: ${reminder.id}");
                            debugPrint(
                                "reminder createtime: ${reminder.createTime}");
                            return CardReminderItem(
                              reminder: reminder,
                              animation: animation,
                              onPressed: () => Navigator.pushNamed(
                                  context, pageRouteReminderDetailMore,
                                  arguments: ReminderScreenArg(reminder,
                                      index: index)),
                            );
                          },
                        )),
                  ),
                ]));
          }
          return DelayedDisplay(
              slidingBeginOffset: const Offset(0.0, -0.35),
              delay: Duration(milliseconds: pageContentDelayShowTime),
              child: createNoReminderSection());
        });
  }

  Widget createFilterBoxDisplay() {
    return Container(
        margin: EdgeInsets.only(left: elementSPadding),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: elementActiveColor,
            border: Border.all(color: buttonBorderColor),
            borderRadius: BorderRadius.all(Radius.circular(cardsBorderRadius))),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(filterIconData[selectedFilterIndex.value],
                size: 24.0, color: buttonReadOnlyColor),
            const SizedBox(width: elementSSPadding),
            CusSText(
              Language.of(context)!.t(filterKeys[selectedFilterIndex.value]),
              color: buttonReadOnlyColor,
            ),
          ],
        ));
  }

  Widget createAppBar() {
    return Container(
      padding: EdgeInsets.all(elementMPadding),
      child: Column(
        children: [createAppBarTxt(), const Divider()],
      ),
    );
  }

  Widget createAppBarTxt() {
    final model = context.read<ReminderModel>();
    if (model.remindersIntial != null && model.remindersIntial!.isNotEmpty) {
      if (selectedFilterIndex.value > 0) {
        return Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            CusExSText(Language.of(context)!.t("home_filter_head")),
            createFilterBoxDisplay()
          ],
        );
      }
      return CusExSText(
        "${Language.of(context)!.t("home_greeting")} ${Language.of(context)!.t("home_list_msg")}",
        textAlign: TextAlign.center,
      );
    }
    return CusExSText(
      Language.of(context)!.t("home_greeting"),
      textAlign: TextAlign.center,
    );
  }

  Widget createNoReminderSection() {
    List<Widget> noRSList = [
      Lottie.asset(
        assetslinkLottie('89809-no-result-green-theme'),
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.width * 0.4,
      ),
      Container(
        padding: EdgeInsets.only(left: 40, right: 40),
        child: Align(
            alignment: Alignment.center,
            child: CusNText(
              Language.of(context)!.t("home_no_data_msg"),
              textAlign: TextAlign.center,
            )),
      ),
      Lottie.asset(
        assetslinkLottie('95113-arrow-down'),
        width: MediaQuery.of(context).size.width * 0.3,
        height: MediaQuery.of(context).size.width * 0.3,
      ),
    ];
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ListView(
          shrinkWrap: true,
          children: noRSList,
        )
      ],
    );
  }

  Widget createNoFilterResult() {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Lottie.asset(
          assetslinkLottie('84854-empty'),
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.width * 0.4,
        ),
        createFilterBoxDisplay(),
        const SizedBox(
          height: 8,
        ),
        Align(
            alignment: Alignment.center,
            child: CusSText(
              Language.of(context)!.t("home_filter_no_data_msg"),
              textAlign: TextAlign.center,
            )),
      ]),
    );
  }
}
