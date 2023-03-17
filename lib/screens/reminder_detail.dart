import 'package:e_sound_reminder_app/widgets/custom_button_normal.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../widgets/custom_button_normal_back.dart';
import '../widgets/custom_button_small.dart';
import '../widgets/custom_text_normal.dart';
import '../widgets/custom_text_small.dart';
import '../widgets/custom_text_title.dart';

class ReminderDetailPage extends StatefulWidget {
  const ReminderDetailPage({super.key, required this.title});

  final String title;

  @override
  State<ReminderDetailPage> createState() => _ReminderDetailPageState();
}

class _ReminderDetailPageState extends State<ReminderDetailPage> {
  List selectedMedicine = [
    "脷底丸",
    "降膽固醇",
    "抗糖尿病",
    "降血壓藥",
  ];

  List<Widget> medicineSelectedArea(List selectedlist) {
    List<Widget> mwList = [];
    for (var medicine in selectedlist) {
      mwList.add(CusSButton(
        "$medicine",
        () {
          // setState(() {
          //   selectedMedicine.remove("$medicine");
          // });
        },
      ));
    }
    return mwList;
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
                CusNText(
                  'ReminderDetail:',
                ),
                Expanded(
                  child: Card(
                      margin: const EdgeInsets.only(bottom: 16.0),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Colors.greenAccent,
                        ),
                        borderRadius: BorderRadius.circular(cardsBorderRadius),
                      ),
                      elevation: 6.0,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CusSText("Set timer to:"),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.alarm),
                                  SizedBox(width: 8),
                                  CusTitleText("06:30")
                                ]),
                            const SizedBox(
                              height: 12,
                            ),
                            CusSText("Take medince of:"),
                            Expanded(
                              child: GridView.count(
                                  primary: true,
                                  padding: const EdgeInsets.all(10),
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8,
                                  crossAxisCount: 3,
                                  children:
                                      medicineSelectedArea(selectedMedicine)),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            CusNButton("Save", (() {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, pageRouteHome, ((route) => false));
                            })),
                            const SizedBox(
                              height: 8,
                            ),
                            CusNBackButton('Delete', () {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, pageRouteHome, ((route) => false));
                            }),
                          ],
                        ),
                      )),
                ),
                Container(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child:
                        CusNBackButton('Back', () => {Navigator.pop(context)}),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
