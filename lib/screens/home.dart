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

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  late AnimationController aniController;
  Animation<double>? animation;

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      aniController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 200),
      )..addListener(() {
          setState(() {});
        });

      animation = Tween(
        begin: 0.0, //getSmallSize(),
        end: 500.0, //getBigSize(),
      ).animate(CurvedAnimation(
        parent: aniController,
        curve: Curves.decelerate,
      ));
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Language.of(context)!.t("home_greeting")),
      ),
      extendBody: true,
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(safeAreaPaddingAllWthLv),
            child: createReminderList()
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
            //       // Lottie.asset(
            //       //   'assets/lotties/80567-sound-voice-waves.json',
            //       //   width: 200,
            //       //   height: 200,
            //       //   fit: BoxFit.fill,
            //       // ),
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
      floatingActionButton: FloatingActionButton.large(
        onPressed: () {
          Navigator.pushNamed(context, pageRouteReminderNew);
        },
        backgroundColor: Colors.green,
        tooltip: 'Tap to add new reminder',
        child: const Icon(
          Icons.add,
          size: 44.0,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        //bottom navigation bar on scaffold
        // color: Colors.green,
        // shape: CircularNotchedRectangle(), //shape of notch
        // notchMargin:
        //     10, //notche margin between floating button and bottom appbar
        // padding: EdgeInsets.all(8.0),
        height: 120, //MediaQuery.of(context).size.height * 0.1,
        child: Row(
          //children inside bottom appbar
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            // Padding(
            //   padding: EdgeInsets.only(left: 90),
            //   child: IconButton(
            //     icon: Icon(
            //       Icons.menu,
            //       color: Colors.white,
            //     ),
            //     onPressed: () {},
            //   ),
            // ),
            Expanded(
              child: IconButton(
                icon: Icon(
                  Icons.home,
                  color: Colors.green,
                  size: 36.0,
                ),
                onPressed: () {},
              ),
            ),
            Expanded(child: const SizedBox()),
            Expanded(
              child: IconButton(
                icon: Icon(
                  Icons.settings,
                  color: Colors.black,
                  size: 36.0,
                ),
                onPressed: () =>
                    Navigator.pushNamed(context, constants.pageRouteSettings),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget createReminderList() {
    return Selector<ReminderModel, ReminderModel>(
        shouldRebuild: (previous, next) {
          if (next.state is ReminderCreated) {
            final state = next.state as ReminderCreated;
            listKey.currentState?.insertItem(state.index);
          } else if (next.state is ReminderUpdated) {
            final state = next.state as ReminderUpdated;
            if (state.index != state.newIndex) {
              // listKey.currentState?.insertItem(state.newIndex);
              // listKey.currentState?.removeItem(
              //   state.index,
              //   (context, animation) => CardreminderReminderItem(
              //     alarm: state.alarm,
              //     animation: animation,
              //   ),
              // );
            }
          }
          return true;
        },
        selector: (_, model) => model,
        builder: (context, model, child) {
          if (model.reminders != null && model.reminders!.isNotEmpty) {
            return Padding(
                padding: const EdgeInsets.only(
                    left: listviewPaddingAll, right: listviewPaddingAll),
                child: Column(children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 20),
                    child: CusSText(Language.of(context)!.t("home_list_msg")),
                  ),
                  Expanded(
                    child: AnimatedList(
                      key: listKey,
                      // not recommended for a list with large number of items
                      shrinkWrap: true,
                      initialItemCount: model.reminders!.length,

                      itemBuilder: (context, index, animation) {
                        if (index >= model.reminders!.length)
                          return Container();
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
          return Text("No Data");
        });
  }
}
