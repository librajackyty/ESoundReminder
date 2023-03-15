import 'package:e_sound_reminder_app/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../utils/constants.dart' as constants;
import '../utils/constants.dart';

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
        title: Text(widget.title),
      ),
      extendBody: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(safeAreaPaddingAllWthLv),
          child: Scrollbar(
            thumbVisibility: true,
            thickness: 10.0,
            child: ListView(
                padding: const EdgeInsets.all(listviewPaddingAll),
                children: <Widget>[
                  CusCard('Remindder1', "Remind take medicine", "21:30", "edit",
                      (() => {})),
                  CusCard('Remindder1', "Remind take medicine", "21:30", "edit",
                      (() => {})),
                  CusCard('Remindder1', "Remind take medicine", "21:30", "edit",
                      (() => {})),
                  CusCard('Remindder1', "Remind take medicine", "21:30", "edit",
                      (() => {})),
                  CusCard('Remindder1', "Remind take medicine", "21:30", "edit",
                      (() => {})),
                  CusCard('Remindder1', "Remind take medicine", "21:30", "edit",
                      (() => {})),
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
