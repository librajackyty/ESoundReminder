import 'package:e_sound_reminder_app/widgets/custom_button_normal.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../widgets/custom_button_normal_back.dart';
import '../widgets/custom_button_small.dart';
import '../widgets/custom_text_normal.dart';
import '../widgets/custom_text_small.dart';
import '../widgets/custom_text_small_ex.dart';
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
                CusExSText("Step (3/3)"),
                CusSText(
                  'Reminder Detail:',
                ),
                const SizedBox(
                  height: 12,
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
                          children: [
                            CusSText("Set timer to:"),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.alarm),
                                  SizedBox(width: 8),
                                  CusTitleText("06:30")
                                ]),
                            CusSText("Set repeat on:"),
                            CusNText("Monday, Friday"),
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
                            Container(
                                margin: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  border: Border(top: BorderSide()),
                                )),
                            const SizedBox(
                              height: 4,
                            ),
                            Container(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    CusNButton(
                                        "Save",
                                        (() => showDialog<String>(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  AlertDialog(
                                                title: CusSText('Save?'),
                                                content: CusNText(
                                                    'Are you sure to save this reminder?'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(
                                                            context, 'NO'),
                                                    child: CusSText('No'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () => Navigator
                                                        .pushNamedAndRemoveUntil(
                                                            context,
                                                            pageRouteHome,
                                                            ((route) => false)),
                                                    child: CusSText('Yes'),
                                                  ),
                                                ],
                                              ),
                                            )
                                        // {
                                        // Navigator.pushNamedAndRemoveUntil(
                                        //     context, pageRouteHome, ((route) => false));

                                        // }
                                        )),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    CusNBackButton(
                                        'Delete',
                                        () => showDialog<String>(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  AlertDialog(
                                                title: CusSText('Delete?'),
                                                content: CusNText(
                                                    'Are you sure to delete this reminder?'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(
                                                            context, 'NO'),
                                                    child: CusSText('No'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () => Navigator
                                                        .pushNamedAndRemoveUntil(
                                                            context,
                                                            pageRouteHome,
                                                            ((route) => false)),
                                                    child: CusSText('Yes'),
                                                  ),
                                                ],
                                              ),
                                            )
                                        // {
                                        //   Navigator.pushNamedAndRemoveUntil(
                                        //       context, pageRouteHome, ((route) => false));
                                        // }
                                        ),
                                  ],
                                ))
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
