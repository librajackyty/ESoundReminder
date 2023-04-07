import 'package:delayed_display/delayed_display.dart';
import 'package:e_sound_reminder_app/utils/feedback.dart';
import 'package:flutter/material.dart';

import '../models/language.dart';
import '../models/reminder.dart';
import '../models/reminder_screen_arg.dart';
import '../utils/constants.dart';
import '../utils/snack_msg.dart';
import '../widgets/custom_button_normal.dart';
import '../widgets/custom_button_normal_back.dart';
import '../widgets/custom_button_small.dart';
import '../widgets/custom_scroll_bar.dart';
import '../widgets/custom_text_small.dart';
import '../widgets/reminder_header.dart';

class ReminderNewPage extends StatefulWidget {
  const ReminderNewPage({super.key, required this.title, this.arg});

  final String title;
  final ReminderScreenArg? arg;

  @override
  State<ReminderNewPage> createState() => _ReminderNewPageState();
}

class _ReminderNewPageState extends State<ReminderNewPage> {
  // Data
  double progressIdx = 0;
  double progressIdxStep1 = 20;
  double progressIdxStep2 = 33;
  late Reminder reminder = widget.arg?.reminder ??
      Reminder(
          reminderTitle: "",
          time1: DateTime.now(),
          weekdays1: [1, 2, 3, 4, 5, 6, 7],
          selectedMedicine: [],
          reminderType: 1);

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
  ScrollController _medicineSVController = ScrollController();
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
          updateClickSelection(medicine);
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
            if (progressIdx >= progressIdxStep2) {
              progressIdx = progressIdxStep1;
            }
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
      if (medicine.isNotEmpty) {
        selectedMedicine = [medicine];
      } else {
        selectedMedicine = [];
      }
      updateSelectedMedicineToModel(selectedMedicine);
      if (progressIdx < progressIdxStep2) {
        progressIdx = progressIdxStep2;
      }
    });
  }

  void updateClickSelection(String medicine) async {
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      showActionArea = true;
      _txtFController.text = medicine;
      textLength = _txtFController.text.length;
    });
    updateSelectedMedicine(medicine);
  }

  var _txtFController = TextEditingController();
  bool _wasEmpty = true;
  var maxLength = 30;
  var textLength = 0;

  void inputTxtSubmit(String val) async {
    debugPrint("inputTxtSubmit: $val");
    runHapticSound();
    FocusManager.instance.primaryFocus?.unfocus();
    // if (val.trim().isNotEmpty) {
    updateSelectedMedicine(val.trim());
    // }
    // await Future.delayed(const Duration(milliseconds: 800));
    // _txtFController.clear();
    setState(() {
      showActionArea = true;
      textLength = _txtFController.text.length;
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: progressBarDelayShowTime))
        .then((value) => setState(() {
              progressIdx = progressIdxStep1;
            }));
    _wasEmpty = _txtFController.text.isEmpty;
    _txtFController.addListener(() {
      if (_wasEmpty != _txtFController.text.isEmpty) {
        setState(() => {_wasEmpty = _txtFController.text.isEmpty});
      }
    });
  }

  @override
  void dispose() {
    _medicineSVController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: safeAreaPaddingAll),
          child: Center(
            child: Column(
              children: <Widget>[
                DelayedDisplay(
                  slidingBeginOffset: const Offset(0.0, -0.35),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: safeAreaPaddingAll),
                      child: ReminderHeader(
                        progressText:
                            "${Language.of(context)!.t("common_step")} ( 1 / 3 )",
                        progressValue: progressIdx,
                        headerText:
                            Language.of(context)!.t("reminder_new1_msg"),
                      )),
                ),
                Expanded(
                  child: Language.currentLocale(context) == Language.codeEnglish
                      ? DelayedDisplay(
                          delay:
                              Duration(milliseconds: pageContentDelayShowTime),
                          child: CusScrollbar(
                              isAlwaysShown: true,
                              scrollController: _medicineSVController,
                              child: SingleChildScrollView(
                                controller: _medicineSVController,
                                physics: AlwaysScrollableScrollPhysics(
                                    parent: BouncingScrollPhysics()),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: safeAreaPaddingAll),
                                child: Column(
                                    children: medicineSelection(
                                        staticmedicineENlist)),
                              )))
                      : DelayedDisplay(
                          delay:
                              Duration(milliseconds: pageContentDelayShowTime),
                          child: CusScrollbar(
                              isAlwaysShown: true,
                              scrollController: _medicineSVController,
                              child: GridView.count(
                                  controller: _medicineSVController,
                                  physics: AlwaysScrollableScrollPhysics(
                                      parent: BouncingScrollPhysics()),
                                  primary: false,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: safeAreaPaddingAll),
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 8,
                                  crossAxisCount: 3,
                                  children: medicineSelection(
                                      getMedicineByLang(context))))),
                ),
                DelayedDisplay(
                    delay: Duration(milliseconds: pageBottomDelayShowTime),
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: safeAreaPaddingAll),
                        child: Column(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                              border: Border(top: BorderSide()),
                            )),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: elementSPadding),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      maxLines: 1,
                                      maxLength: maxLength,
                                      controller: _txtFController,
                                      style: TextStyle(
                                          fontSize: textSmallSize,
                                          fontWeight: FontWeight.bold),
                                      decoration: InputDecoration(
                                          counterText: "",
                                          contentPadding: const EdgeInsets.all(
                                              elementSPadding),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(16))),
                                          hintText: showActionArea
                                              ? Language.of(context)!
                                                  .t("reminder_new1_inputhint")
                                              : '',
                                          hintStyle:
                                              TextStyle(color: Colors.black),
                                          prefixIcon: showActionArea
                                              ? Icon(Icons.edit)
                                              : null,
                                          prefixText: showActionArea
                                              ? ''
                                              : '${textLength.toString()}/${maxLength.toString()} ',
                                          prefixStyle: TextStyle(
                                              fontSize: textExSmallSize),
                                          suffixIcon: _txtFController
                                                  .text.isNotEmpty
                                              ? IconButton(
                                                  onPressed: () {
                                                    _txtFController.clear();
                                                    updateSelectedMedicine('');
                                                    setState(() {
                                                      textLength =
                                                          _txtFController
                                                              .text.length;
                                                    });
                                                    runHapticSound();
                                                  },
                                                  icon: Icon(
                                                    Icons.cancel_outlined,
                                                    size: 32,
                                                  ))
                                              : null),
                                      onChanged: (value) {
                                        setState(() {
                                          textLength = value.length;
                                        });
                                      },
                                      onTap: () {
                                        runHapticSound();
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
                                  // Visibility(
                                  //   visible: !showActionArea,
                                  //   child:
                                  AnimatedSize(
                                    duration: const Duration(milliseconds: 200),
                                    child: showActionArea
                                        ? SizedBox.shrink()
                                        : IconButton(
                                            onPressed: showActionArea
                                                ? null
                                                : () => inputTxtSubmit(
                                                    _txtFController.text),
                                            iconSize: 48,
                                            icon: Icon(
                                              Icons.check_circle_outline,
                                              color: showActionArea
                                                  ? Colors.grey[400]
                                                  : Colors.green[800],
                                            ),
                                          ),
                                  )
                                ],
                              ),
                            ),
                            Visibility(
                                visible: showActionArea,
                                child: const SizedBox(
                                  height: 2,
                                )),
                            // AnimatedSize(
                            //   duration: const Duration(milliseconds: 200),
                            //   child: !(selectedMedicine.isNotEmpty && showActionArea)
                            //       ? SizedBox.shrink()
                            //       : CusCardContainer(
                            //           child: SizedBox(
                            //             width: double.maxFinite,
                            //             height: MediaQuery.of(context).size.height *
                            //                 reminderCardHeightRatio,
                            //             child: ListView(
                            //               padding: const EdgeInsets.all(12),
                            //               children: [
                            //                 Row(children: [
                            //                   Icon(Icons.medication_outlined),
                            //                   SizedBox(width: 6),
                            //                   CusSText(Language.of(context)!
                            //                       .t("reminder_new1_selectedmedicine"))
                            //                 ]),
                            //                 const SizedBox(
                            //                   height: 8.0,
                            //                 ),
                            //                 ...medicineSelectedArea(selectedMedicine)
                            //               ],
                            //             ),
                            //           ),
                            //         ),
                            // ),

                            // bottom action area
                            AnimatedSize(
                              duration: const Duration(milliseconds: 200),
                              child: !showActionArea
                                  ? SizedBox.shrink()
                                  :
                                  // ),
                                  // Visibility(
                                  //   visible: showActionArea,
                                  //   child:
                                  Row(
                                      children: [
                                        Expanded(
                                          child: CusNBackButton(
                                              Language.of(context)!
                                                  .t("common_back"),
                                              () => {Navigator.pop(context)}),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Expanded(
                                          child: CusNButton(
                                              Language.of(context)!
                                                  .t("common_next"),
                                              () => {
                                                    if (selectedMedicine
                                                        .isEmpty)
                                                      {
                                                        showSnackMsg(
                                                            context,
                                                            Language.of(
                                                                    context)!
                                                                .t("reminder_new1_snackmsg1"))
                                                      }
                                                    else
                                                      {
                                                        Navigator.pushNamed(
                                                            context,
                                                            pageRouteReminderNew2,
                                                            arguments:
                                                                ReminderScreenArg(
                                                                    reminder))
                                                      }
                                                  }),
                                        ),
                                      ],
                                    ),
                            ),
                          ],
                        )))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
