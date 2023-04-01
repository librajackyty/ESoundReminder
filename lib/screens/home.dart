import 'package:e_sound_reminder_app/models/language.dart';
import 'package:e_sound_reminder_app/widgets/custom_card.dart';
import 'package:e_sound_reminder_app/widgets/custom_text_small.dart';
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

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      aniController.forward();
      aniControllerBottom.forward();
      stateReady = true;
    });
    super.initState();
  }

  double getBigSize() => MediaQuery.of(context).size.height * .8;

  double getSmallSize() {
    return MediaQuery.of(context).size.height * .8 -
        MediaQuery.of(context).size.width;
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
          title: createAppBarTxt(),
        ),
        extendBody: true,
        body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(safeAreaPaddingAllWthLv),
              child: FadeTransition(
                  opacity:
                      animation, //aniController.drive(CurveTween(curve: Curves.easeOut)),
                  child: createReminderList())
              //   CusScrollbar(
              //   ListView(
              //       padding: const EdgeInsets.all(listviewPaddingAll),
              //       children: <Widget>[
              // Container(
              //   padding: EdgeInsets.only(bottom: 20),
              //   child: CusSText(Language.of(context)!.t("home_list_msg")),
              // ),
              // CusCard(
              //     Icon(
              //       Icons.medication, // Icons.sunny
              //       color: Colors.blue[600]!, // Colors.yellow[900]!
              //       size: 40.0,
              //       semanticLabel:
              //           'moon icon means Time between 18:00 to 06:00', //'sunny icon means Time between 06:00 to 18:00',
              //     ),
              //     "提醒食藥 - 脷底丸",
              //     "21:30",
              //     "每周重複: \n一, 二, 三, 六, 日",
              //     onPressed: (() => {
              //           Navigator.pushNamed(
              //               context, pageRouteReminderDetail)
              //         })),
              //       ]),
              // ),
              // Center(
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: <Widget>[
              //       Card(
              //         child: Column(
              //           mainAxisSize: MainAxisSize.min,
              //           children: <Widget>[
              //             const ListTile(
              //               leading: Icon(Icons.album),
              //               title: Text('The Enchanted Nightingale'),
              //               subtitle: Text(
              //                   'Music by Julie Gable. Lyrics by Sidney Stein.'),
              //             ),
              //             Row(
              //               mainAxisAlignment: MainAxisAlignment.end,
              //               children: <Widget>[
              //                 TextButton(
              //                   child: const Text('BUY TICKETS'),
              //                   onPressed: () {/* ... */},
              //                 ),
              //                 const SizedBox(width: 8),
              //                 TextButton(
              //                   child: const Text('LISTEN'),
              //                   onPressed: () {/* ... */},
              //                 ),
              //                 const SizedBox(width: 8),
              //               ],
              //             ),
              //           ],
              //         ),
              //       ),
              // Lottie.asset(
              //   'assets/lotties/80567-sound-voice-waves.json',
              //   width: 200,
              //   height: 200,
              //   fit: BoxFit.fill,
              // ),
              //       // const Text(
              //       //   'Sound testing...',
              //       // ),
              //       // ElevatedButton(
              //       //   onPressed: () {
              //       //     Navigator.pushNamed(context, constants.pageRouteLangConfig);
              //       //   },
              //       //   child: const Text('Go Lang Config'),
              //       // ),
              //     ],
              //   ),
              // ),
              ),
        ),
        floatingActionButton: ScaleTransition(
          scale: animationFAB,
          child: FloatingActionButton.large(
              onPressed: () =>
                  Navigator.pushNamed(context, pageRouteReminderNew),
              elevation: 20.0,
              backgroundColor: Colors.green[600],
              tooltip: Language.of(context)!.t("home_add_tip"),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1.0,
                  color: Colors.green[900]!,
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
            height: 120, //MediaQuery.of(context).size.height * 0.1,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: IconButton(
                    icon: Lottie.asset(
                      assetslinkLottie('73220-alarm'),
                      fit: BoxFit.fill,
                    ),
                    onPressed: () {},
                  ),
                ),
                Expanded(child: const SizedBox()),
                Expanded(
                  child: IconButton(
                    icon: Lottie.asset(
                      assetslinkLottie('94350-gears-lottie-animation'),
                      fit: BoxFit.fill,
                    ),
                    onPressed: () => Navigator.pushNamed(
                        context, constants.pageRouteSettings),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget createReminderList() {
    return Selector<ReminderModel, ReminderModel>(
        shouldRebuild: (previous, next) {
          if (next.state is ReminderCreated) {
            final state = next.state as ReminderCreated;
            listKey.currentState?.insertItem(state.index,
                duration: const Duration(milliseconds: 800));
          } else if (next.state is ReminderUpdated) {
            final state = next.state as ReminderUpdated;
            if (state.index != state.newIndex) {
              // listKey.currentState?.insertItem(state.newIndex);
              // listKey.currentState?.removeItem(
              //   state.index,
              // (context, animation) => CardReminderItem(
              //   reminder: state.reminder,
              //   animation: animation,
              // ),
              // );
            }
          }
          // else if (next.state is ReminderDeleted) {
          //   Future.delayed(const Duration(seconds: 2)).then((value) {
          //     var state = next.state as ReminderDeleted;
          //     listKey.currentState?.removeItem(
          //         state.index,
          //         (context, animation) => CardReminderItem(
          //               reminder: state.reminder,
          //               animation: animation,
          //             ),
          //         duration: const Duration(milliseconds: 1500));
          //   });
          // }
          // else if (next.state is ReminderLoaded) {
          //   final state = next.state as ReminderLoaded;
          //   for (var i = 0; i < state.reminders.length; i++) {
          //     listKey.currentState
          //         ?.insertItem(i, duration: const Duration(milliseconds: 1500));
          //   }
          // }
          return true;
        },
        selector: (_, model) => model,
        builder: (context, model, child) {
          if (model.reminders != null && model.reminders!.isNotEmpty) {
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

  Widget createAppBarTxt() {
    final model = context.read<ReminderModel>();
    if (model.reminders != null && model.reminders!.isNotEmpty) {
      return Text(
          "${Language.of(context)!.t("home_greeting")} ${Language.of(context)!.t("home_list_msg")}");
    }
    return Text(Language.of(context)!.t("home_greeting"));
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
      SizedBox(
        height: 40,
      )
    ];
    return Column(
      children: [
        Spacer(),
        ListView(
          shrinkWrap: true,
          children: noRSList,
        )
      ],
    );
  }
}
