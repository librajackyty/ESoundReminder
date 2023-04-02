import 'package:e_sound_reminder_app/models/language.dart';
import 'package:e_sound_reminder_app/widgets/custom_card.dart';
import 'package:e_sound_reminder_app/widgets/custom_text_normal.dart';
import 'package:e_sound_reminder_app/widgets/custom_text_small.dart';
import 'package:e_sound_reminder_app/widgets/custom_text_small_ex.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../models/reminder.dart';
import '../models/reminder_screen_arg.dart';
import '../providers/reminders/reminders_provider.dart';
import '../providers/reminders/reminders_state.dart';
import '../utils/assetslink.dart';
import '../utils/constants.dart' as constants;
import '../utils/constants.dart';
import '../utils/formatter.dart';
import '../widgets/custom_list_item.dart';
import '../widgets/custom_scroll_bar.dart';
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
    duration: const Duration(milliseconds: 1000),
  );
  late final Animation<double> animation = Tween(
    begin: 0.0,
    end: 1.0,
  ).animate(CurvedAnimation(
    parent: aniController,
    curve: Curves.easeIn,
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
                    child: ListView.builder(
                      padding: EdgeInsets.all(elementMPadding),
                      controller: controller,
                      itemCount: filterKeys.length,
                      itemBuilder: (_, index) {
                        return CusListItm(
                          Language.of(context)!.t(filterKeys[index]),
                          iconData: filterIconData[index],
                          onTap: () {
                            setState(() {
                              selectedFilterIndex.value = index;
                            });
                            Navigator.pop(context);
                          },
                          selected: selectedFilterIndex.value == index,
                        );
                      },
                    ),
                  ),
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
      listFilterBtnStrKey = filterKeys[selectedFilterIndex.value];
      final model = context.read<ReminderModel>();
      model.filterReminder(selectedFilterIndex.value);
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
        appBar: AppBar(
          toolbarHeight: 80,
          leadingWidth: 68,
          leading: Container(
            margin: EdgeInsets.only(left: safeAreaPaddingAll, right: 8),
            child: Image(
                width: 40,
                height: 40,
                image: AssetImage(assetslinkImages('app_icon_512_rounded'))),
          ),
          title: createAppBarTxt(),
          titleSpacing: 8,
          centerTitle: false,
        ),
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
              onPressed: () =>
                  Navigator.pushNamed(context, pageRouteReminderNew),
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
                      CusSText(Language.of(context)!.t(listFilterBtnStrKey))
                    ],
                  ),
                  onPressed: () => showFilterSelection(),
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
                      CusSText(Language.of(context)!.t("settings_title"))
                    ],
                  ),
                  onPressed: () =>
                      Navigator.pushNamed(context, constants.pageRouteSettings),
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
          if (next.state is ReminderCreated) {
            final state = next.state as ReminderCreated;
            listKey.currentState?.insertItem(state.index,
                duration: const Duration(milliseconds: 800));
          } else if (next.state is ReminderUpdated) {
            final state = next.state as ReminderUpdated;
            if (state.index != state.newIndex) {
              listKey.currentState?.insertItem(state.newIndex);
              listKey.currentState?.removeItem(
                state.index,
                (context, animation) => CardReminderItem(
                  reminder: state.reminder,
                  animation: animation,
                ),
              );
            }
          } else if (next.state is ReminderDeleted) {
            final state = next.state as ReminderDeleted;
            listKey.currentState?.removeItem(
                state.index,
                (context, animation) => CardReminderItem(
                      reminder: state.reminder,
                      animation: animation,
                    ),
                duration: const Duration(milliseconds: 800));
          }
          return true;
        },
        selector: (_, model) => model,
        builder: (context, model, child) {
          if (model.remindersIntial != null &&
              model.remindersIntial!.isNotEmpty) {
            if (isFiltering() &&
                model.reminders != null &&
                model.reminders!.isEmpty) {
              return createNoFilterResult();
            }
            return Padding(
                padding: const EdgeInsets.only(
                    left: listviewPaddingAll, right: listviewPaddingAll),
                child: Column(children: [
                  // Container(
                  //   padding: EdgeInsets.only(bottom: 20),
                  //   child: CusSText(Language.of(context)!.t("home_list_msg")),
                  // ),
                  Expanded(
                    child: AnimatedList(
                      key: listKey,
                      padding: EdgeInsets.only(bottom: 40),
                      shrinkWrap: true,
                      initialItemCount: model.reminders!.length,
                      itemBuilder: (context, index, animation) {
                        if (index >= model.reminders!.length) {
                          return Container();
                        }
                        final reminder = model.reminders![index];
                        debugPrint("reminder id: ${reminder.id}");
                        debugPrint(
                            "reminder createtime: ${reminder.createTime}");
                        return CardReminderItem(
                          reminder: reminder,
                          animation: animation,
                          // onDelete: () async {
                          //   _listKey.currentState?.removeItem(
                          //     index,
                          //     (context, animation) => CardReminderItem(
                          //       alarm: alarm,
                          //       animation: animation,
                          //     ),
                          //   );
                          //   await model.deleteAlarm(alarm, index);
                          // },
                          onPressed: () => Navigator.pushNamed(
                              context, pageRouteReminderDetailMore,
                              arguments:
                                  ReminderScreenArg(reminder, index: index)),
                        );
                      },
                    ),
                  ),
                ]));
          }
          return createNoReminderSection();
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
      return Text(
        "${Language.of(context)!.t("home_greeting")}\n${Language.of(context)!.t("home_list_msg")}",
        maxLines: 2,
      );
    }
    return Text(
      Language.of(context)!.t("home_greeting"),
      textAlign: TextAlign.start,
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
            child: CusSText(
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
      // mainAxisSize: MainAxisSize.min,
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
