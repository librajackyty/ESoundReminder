import 'package:flutter/material.dart';

import '../models/language.dart';
import '../models/reminder.dart';
import '../models/reminder_screen_arg.dart';
import '../utils/constants.dart';
import '../widgets/custom_button_normal.dart';
import '../widgets/custom_button_normal_back.dart';
import '../widgets/custom_button_small.dart';
import '../widgets/custom_scroll_bar.dart';
import '../widgets/custom_text_normal.dart';
import '../widgets/custom_text_small.dart';
import '../widgets/custom_text_small_ex.dart';

class ReminderNewPage extends StatefulWidget {
  const ReminderNewPage({super.key, required this.title, this.arg});

  final String title;
  final ReminderScreenArg? arg;

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
  List staticmedicineCNlist = [
    "脷底丸",
    "降胆固醇",
    "抗糖尿病",
    "降血压药",
    "胃药",
    "抗生素",
    "维他命",
    "维他命A",
    "维他命B",
    "维他命C",
    "维他命D",
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
  List getMedicineByLang(BuildContext context) {
    switch (Language.currentLocale(context)) {
      case Language.codeEnglish:
        return staticmedicineENlist;
      case Language.codeSChinese:
        return staticmedicineCNlist;
      case Language.codeTCantonese:
        return staticmedicinelist;
      default:
        return staticmedicinelist;
    }
  }

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
                CusExSText("${Language.of(context)!.t("common_step")} (1/3)"),
                CusSText(
                  Language.of(context)!.t("reminder_new1_msg"),
                ),
                Expanded(
                  child: Language.currentLocale(context) == Language.codeEnglish
                      ? SingleChildScrollView(
                          child: Column(
                              children:
                                  medicineSelection(staticmedicineENlist)),
                        )
                      : GridView.count(
                          primary: false,
                          padding: const EdgeInsets.all(8),
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 8,
                          crossAxisCount: 3,
                          children:
                              medicineSelection(getMedicineByLang(context))),
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
                            // CusSText("Selected medicine:"),
                            Row(children: [
                              Icon(Icons.medication_outlined),
                              SizedBox(width: 6),
                              CusSText(Language.of(context)!
                                  .t("reminder_new1_selectedmedicine"))
                            ]),
                            const SizedBox(
                              height: 8.0,
                            ),
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
                              Language.of(context)!.t("common_back"),
                              () => {Navigator.pop(context)}),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: CusNButton(
                              Language.of(context)!.t("common_next"),
                              () => {
                                    // Navigator.pop(context),
                                    if (selectedMedicine.isEmpty)
                                      {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: CusSText(
                                              Language.of(context)!.t(
                                                  "reminder_new1_snackmsg1")),
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
