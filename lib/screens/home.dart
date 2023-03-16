import 'package:e_sound_reminder_app/widgets/custom_card.dart';
import 'package:e_sound_reminder_app/widgets/custom_text_small.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../utils/constants.dart' as constants;
import '../utils/constants.dart';
import '../widgets/custom_scroll_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello, Sir"),
      ),
      extendBody: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(safeAreaPaddingAllWthLv),
          child: CusScrollbar(
            ListView(
                padding: const EdgeInsets.all(listviewPaddingAll),
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(bottom: 20),
                    child: CusSText('Below are the reminders you created:'),
                  ),
                  CusCard(
                      Icon(
                        Icons.nightlight_rounded, // Icons.sunny
                        color: Colors.yellow[600]!, // Colors.yellow[900]!
                        size: 36.0,
                        semanticLabel:
                            'moon icon means Time between 18:00 to 06:00', //'sunny icon means Time between 06:00 to 18:00',
                      ),
                      "Remind take medicine",
                      "21:30",
                      onPressed: (() => {})),
                ]),
          ),
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
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        //bottom navigation bar on scaffold
        // color: Colors.green,
        // shape: CircularNotchedRectangle(), //shape of notch
        // notchMargin:
        //     10, //notche margin between floating button and bottom appbar
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
                onPressed: () {
                  Navigator.pushNamed(context, constants.pageRouteSettings);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
