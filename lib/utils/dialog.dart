import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../models/language.dart';
import '../widgets/custom_text_small.dart';
import 'assetslink.dart';

void showDialogLottie(BuildContext context,
    {required String lottieFileName,
    double? lottieWidth,
    double? lottieHeight,
    Widget? title,
    Widget? content,
    noBtnTxtKey = "common_no",
    void Function()? noBtnOnPressed,
    yesBtnTxtKey = "common_yes",
    void Function()? yesBtnOnPressed}) {
  showCommonDialog(context,
      title: title,
      content: content,
      noBtnTxtKey: noBtnTxtKey,
      noBtnOnPressed: noBtnOnPressed,
      yesBtnTxtKey: yesBtnTxtKey,
      yesBtnOnPressed: yesBtnOnPressed,
      icon: Lottie.asset(
        assetslinkLottie(lottieFileName),
        width: lottieWidth ?? MediaQuery.of(context).size.width * 0.3,
        height: lottieHeight ?? MediaQuery.of(context).size.width * 0.3,
      ));
}

void showDialogLottieIcon(BuildContext context,
    {required String lottieFileName,
    double? lottieWidth,
    double? lottieHeight,
    Function? onLoaded,
    repeat = false,
    dismissible = true}) {
  showBaseDialog(
    context,
    dismissible: dismissible,
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Lottie.asset(
          assetslinkLottie(lottieFileName),
          repeat: repeat,
          width: lottieWidth ?? MediaQuery.of(context).size.width * 0.5,
          height: lottieHeight ?? MediaQuery.of(context).size.width * 0.5,
          onLoaded: (p0) {
            debugPrint("showDialogLottieIcon loaded");
            onLoaded != null ? onLoaded() : () {};
          },
        ),
      ],
    ),
  );
}

void showCommonDialog(BuildContext context,
    {Widget? icon,
    Widget? title,
    Widget? content,
    noBtnTxtKey = "common_no",
    void Function()? noBtnOnPressed,
    yesBtnTxtKey = "common_yes",
    void Function()? yesBtnOnPressed}) {
  showBaseDialog(context, icon: icon, title: title, content: content, actions: [
    TextButton(
      onPressed: noBtnOnPressed,
      child: CusSText(Language.of(context)!.t(noBtnTxtKey)),
    ),
    TextButton(
      onPressed: yesBtnOnPressed,
      child: CusSText(Language.of(context)!.t(yesBtnTxtKey)),
    ),
  ]);
}

void showBaseDialog(BuildContext context,
    {Widget? icon,
    Widget? title,
    Widget? content,
    List<Widget>? actions,
    dismissible = true}) {
  showDialog<String>(
    context: context,
    barrierDismissible: dismissible,
    builder: (BuildContext context) => AlertDialog(
      icon: icon,
      title: title,
      content: content,
      actions: actions,
    ),
  );
}
