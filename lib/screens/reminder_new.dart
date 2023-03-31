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
  late Reminder reminder = widget.arg?.reminder ??
      Reminder(
          reminderTitle: "",
          time1: DateTime.now(),
          weekdays1: [1, 2, 3, 4, 5, 6, 7],
          selectedMedicine: []);

  List staticmedicinelist = [
    "鈣質片",
    "止痛藥",
    "脷底丸",
    "降膽固醇",
    "抗糖尿病",
    "降血壓藥",
    "抗心臟衰竭",
    "胃藥",
    "抗生素",
    "哮喘藥",
    "類固醇藥",
    "抗凝血藥",
    "維他命",
    "維他命A",
    "維他命B",
    "維他命C",
    "維他命D",
    "維他命E",
  ];
  List staticmedicineCNlist = [
    "鈣質片",
    "止痛药",
    "脷底丸",
    "降胆固醇",
    "抗糖尿病",
    "降血压药",
    "抗心脏衰竭",
    "胃药",
    "抗生素",
    "哮喘药",
    "類固醇藥",
    "抗凝血药",
    "维他命",
    "维他命A",
    "维他命B",
    "维他命C",
    "维他命D",
    "维他命E",
  ];
  List staticmedicineENlist = [
    "Calcium Carbonate",
    "Analgesic",
    "Nitroglyercin",
    "Cholesterol-lowering drugs",
    "Oral Antidiabetic Medications",
    "Antihypertensive drugs",
    "Anti-heart failure",
    "Antacid",
    "Antibiotic",
    "Asthma medicine",
    "Steroid pills",
    "Anticoagulants",
    "Vitamin",
    "Vitamin A",
    "Vitamin B",
    "Vitamin C",
    "Vitamin D",
    "Vitamin E"
  ];
  List selectedMedicine = [];

  void updateSelectedMedicineToModel(List newList) {
    reminder = reminder.copyWith(selectedMedicine: newList);
  }

  // UI rendering
  bool showActionArea = true;
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
          updateSelectedMedicine(medicine);
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
            updateSelectedMedicineToModel(selectedMedicine);
          });
        },
        icon: Icon(Icons.cancel),
      ));
    }
    return mwList;
  }

  void updateSelectedMedicine(String medicine) {
    setState(() {
      // if (!selectedMedicine.contains("$medicine")) {
      //   selectedMedicine.add("$medicine");
      // } else {
      //   selectedMedicine.remove("$medicine");
      // }
      selectedMedicine = ["$medicine"];
      updateSelectedMedicineToModel(selectedMedicine);
    });
  }

  var _TEController = TextEditingController();

  void inputTxtSubmit(String val) async {
    debugPrint("inputTxtSubmit: $val");
    FocusManager.instance.primaryFocus?.unfocus();
    if (val.isNotEmpty) {
      updateSelectedMedicine(val);
    }
    await Future.delayed(const Duration(milliseconds: 800));
    _TEController.clear();
    setState(() {
      showActionArea = true;
    });
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
                  textAlign: TextAlign.center,
                ),
                const Divider(),
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
                        // margin: EdgeInsets.only(top: 8),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border(top: BorderSide()),
                        )),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _TEController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16))),
                                hintText: Language.of(context)!
                                    .t("reminder_new1_inputhint"),
                                hintStyle: TextStyle(color: Colors.black),
                                prefixIcon: Icon(
                                  Icons.edit,
                                  // size: 30,
                                ),
                                suffixIcon: _TEController.text.isNotEmpty
                                    ? IconButton(
                                        onPressed: () {
                                          _TEController.clear();
                                          setState(() {});
                                        },
                                        icon: Icon(
                                          Icons.cancel_outlined,
                                          size: 36,
                                        ))
                                    : null),
                            onTap: () {
                              setState(() {
                                showActionArea = false;
                              });
                            },
                            onSubmitted: (value) {
                              debugPrint("onSubmitted: $value");
                              inputTxtSubmit(value);
                            },
                          ),
                        ),
                        IconButton(
                          onPressed: showActionArea
                              ? null
                              : () => inputTxtSubmit(_TEController.text),
                          iconSize: 48,
                          icon: Icon(
                            Icons.check_circle_outline,
                            color: showActionArea
                                ? Colors.grey[400]
                                : Colors.green[800],
                          ),
                        ),
                      ],
                    ),
                    Visibility(
                        visible: showActionArea,
                        child: const SizedBox(
                          height: reminderCardBottomMargin,
                        )),
                    Visibility(
                      visible: showActionArea,
                      child: Card(
                        margin: const EdgeInsets.only(
                            bottom: reminderCardBottomMargin),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.greenAccent,
                          ),
                          borderRadius:
                              BorderRadius.circular(cardsBorderRadius),
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
                    ),
                    Visibility(
                      visible: showActionArea,
                      child: Row(
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
                                              context, pageRouteReminderNew2,
                                              arguments:
                                                  ReminderScreenArg(reminder))
                                        }
                                    }),
                          ),
                        ],
                      ),
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
