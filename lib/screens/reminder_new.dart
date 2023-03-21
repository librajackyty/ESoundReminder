import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../widgets/custom_button_normal.dart';
import '../widgets/custom_button_normal_back.dart';
import '../widgets/custom_button_small.dart';
import '../widgets/custom_scroll_bar.dart';
import '../widgets/custom_text_normal.dart';
import '../widgets/custom_text_small.dart';
import '../widgets/custom_text_small_ex.dart';

class ReminderNewPage extends StatefulWidget {
  const ReminderNewPage({super.key, required this.title});

  final String title;

  @override
  State<ReminderNewPage> createState() => _ReminderNewPageState();
}

class _ReminderNewPageState extends State<ReminderNewPage> {
  // Data
  List staticmedicinelist = [
    "脷底丸",
    "降膽固醇",
    "抗糖尿病",
    "降血壓藥",
    "胃藥",
    "抗生素",
    "維他命",
    "維他命A",
    "維他命B",
    "維他命C",
    "維他命D",
  ];
  List staticmedicineENlist = [
    "Nitroglyercin",
    "Cholesterol-lowering drugs",
    "Oral Antidiabetic Medications",
    "Antihypertensive drugs",
    "Antacid",
    "Antibiotic",
    "Vitamin",
    "Vitamin A",
    "Vitamin B",
    "Vitamin C",
    "Vitamin D"
  ];
  List selectedMedicine = [];

  // UI rendering
  List<Widget> medicineSelection(List medicinelist) {
    List<Widget> mwList = [];
    for (var medicine in medicinelist) {
      mwList.add(Container(
        padding: EdgeInsets.all(8),
        child: CusSButton("$medicine", () {
          setState(() {
            // if (!selectedMedicine.contains("$medicine")) {
            //   selectedMedicine.add("$medicine");
            // } else {
            //   selectedMedicine.remove("$medicine");
            // }
            selectedMedicine = ["$medicine"];
          });
        }),
      ));
    }
    return mwList;
  }

  List<Widget> medicineSelectedArea(List selectedlist) {
    List<Widget> mwList = [];
    for (var medicine in selectedlist) {
      mwList.add(CusNButton(
        "$medicine",
        () {
          setState(() {
            selectedMedicine.remove("$medicine");
          });
        },
        icon: Icon(Icons.cancel),
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
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CusExSText("Step (1/3)"),
                CusSText(
                  // 'Please select which medicine you will take (Can select more than one):',
                  'Please select which medicine you will take:',
                ),
                Expanded(
                  child:
                      // CusScrollbar(
                      GridView.count(
                          primary: false,
                          padding: const EdgeInsets.all(8),
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 8,
                          crossAxisCount: 3,
                          children: medicineSelection(staticmedicinelist)),
                  // SingleChildScrollView(
                  //   child:
                  //  Column(
                  //     children: medicineSelection(staticmedicinelist)),
                  // ),
                  // ),
                ),
                Column(
                  children: [
                    Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border(top: BorderSide()),
                        )),
                    Card(
                      margin: const EdgeInsets.only(
                          bottom: reminderCardBottomMargin),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Colors.greenAccent,
                        ),
                        borderRadius: BorderRadius.circular(cardsBorderRadius),
                      ),
                      elevation: cardsElevation,
                      child: SizedBox(
                        width: double.maxFinite,
                        height: MediaQuery.of(context).size.height *
                            reminderCardHeightRatio,

                        child: ListView(
                          padding: const EdgeInsets.all(12),
                          children: [
                            CusSText("Selected medicine:"),
                            ...medicineSelectedArea(selectedMedicine)
                          ],
                        ),

                        // GridView.count(
                        //     primary: false,
                        //     padding: const EdgeInsets.all(10),
                        //     crossAxisSpacing: 8,
                        //     mainAxisSpacing: 8,
                        //     crossAxisCount: 3,
                        //     children: medicineSelectedArea(selectedMedicine)),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CusNBackButton(
                              'Back', () => {Navigator.pop(context)}),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: CusNButton(
                              'Next',
                              () => {
                                    // Navigator.pop(context),
                                    if (selectedMedicine.isEmpty)
                                      {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: CusSText(
                                              "Please select at least one medicine first"),
                                        ))
                                      }
                                    else
                                      {
                                        Navigator.pushNamed(
                                            context, pageRouteReminderNew2)
                                      }
                                  }),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
