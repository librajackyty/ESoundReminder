import 'dart:async';

import 'package:e_sound_reminder_app/models/displayer.dart';
import 'package:e_sound_reminder_app/utils/constants.dart';
import 'package:e_sound_reminder_app/utils/feedback.dart';
import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../models/language.dart';
import '../widgets/custom_text_normal.dart';
import '../widgets/custom_text_small.dart';
import 'assetslink.dart';

TutorialCoachMark createTutorial(
    String page, BuildContext context, List<GlobalKey> keys,
    {dynamic Function()? onFinish,
    FutureOr<void> Function(TargetFocus)? onClickTarget,
    FutureOr<void> Function(TargetFocus, TapDownDetails)?
        onClickTargetWithTapPosition,
    FutureOr<void> Function(TargetFocus)? onClickOverlay,
    dynamic Function()? onSkip}) {
  final int tutorialMode = Displayer.currenTutorialSetting(context);
  List<TargetFocus> targets = [];
  switch (page) {
    case pageRouteReminderNew:
      targets = _createTargetsPage1(context, keys);
      break;
    case pageRouteReminderNew2:
      targets = _createTargetsPage2(context, keys);
      break;
    case pageRouteReminderDetail:
      targets = _createTargetsPage3(context, keys);
      break;
    default:
      targets = [];
  }
  return TutorialCoachMark(
    targets: targets,
    colorShadow: elementActiveColor,
    textSkip: Language.of(context)!.t("coachtutorial_skip"),
    textStyleSkip: TextStyle(
        fontSize: textSmallSize,
        fontWeight: FontWeight.bold,
        color: elementActiveTxtColor),
    paddingFocus: 10,
    opacityShadow: 0.8,
    hideSkip: tutorialMode == Displayer.codeTutorialModeInitial,
    onFinish: () {
      debugPrint("$page tutorial::finish");
      onFinish?.call();
    },
    onClickTarget: (target) {
      debugPrint('$page tutorial::onClickTarget: $target');
      onClickTarget?.call(target);
      runHapticSound();
    },
    onClickTargetWithTapPosition: (target, tapDetails) {
      debugPrint("$page tutorial::target: $target");
      debugPrint(
          "$page tutorial::clicked at position local: ${tapDetails.localPosition} - global: ${tapDetails.globalPosition}");
      onClickTargetWithTapPosition?.call(target, tapDetails);
    },
    onClickOverlay: (target) {
      debugPrint('$page tutorial::onClickOverlay: $target');
      onClickOverlay?.call(target);
    },
    onSkip: () {
      debugPrint("$page tutorial::onSkip");
      onSkip?.call();
      runHapticSound();
    },
  );
}

Widget _getTSText(BuildContext context, String keyname) {
  return CusSText(
    Language.of(context)!.t(keyname),
    color: elementActiveTxtColor,
  );
}

Widget _getTNText(BuildContext context, String keyname) {
  return CusNText(
    Language.of(context)!.t(keyname),
    color: elementActiveTxtColor,
  );
}

// pageRouteReminderNew
List<TargetFocus> _createTargetsPage1(
    BuildContext context, List<GlobalKey> keys) {
  List<TargetFocus> targets = [];
  targets.add(
    TargetFocus(
      identify: "tutorialStep1",
      keyTarget: keys[0],
      alignSkip: Alignment.topRight,
      shape: Language.currentLocale(context) == Language.codeEnglish
          ? ShapeLightFocus.RRect
          : ShapeLightFocus.Circle,
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _getTSText(context, "coachtutorial_page1_step1"),
                _getTNText(context, "coachtutorial_page1_step1_msg"),
              ],
            );
          },
        ),
      ],
    ),
  );
  targets.add(
    TargetFocus(
      identify: "tutorialStep2",
      keyTarget: keys[1],
      alignSkip: Alignment.topRight,
      shape: ShapeLightFocus.RRect,
      contents: [
        TargetContent(
          align: ContentAlign.top,
          builder: (context, controller) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _getTSText(context, "coachtutorial_page1_step2"),
                _getTNText(context, "coachtutorial_page1_step2_msg"),
              ],
            );
          },
        ),
      ],
    ),
  );
  targets.add(
    TargetFocus(
      identify: "tutorialStep2a",
      keyTarget: keys[1],
      alignSkip: Alignment.topRight,
      shape: ShapeLightFocus.RRect,
      contents: [
        TargetContent(
          align: ContentAlign.top,
          builder: (context, controller) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _getTNText(context, "coachtutorial_page1_step2_msg2"),
              ],
            );
          },
        ),
      ],
    ),
  );
  targets.add(
    TargetFocus(
      identify: "tutorialStep3",
      keyTarget: keys[2],
      alignSkip: Alignment.topRight,
      shape: ShapeLightFocus.RRect,
      contents: [
        TargetContent(
          align: ContentAlign.top,
          builder: (context, controller) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _getTSText(context, "coachtutorial_page1_step3"),
                _getTNText(context, "coachtutorial_page1_step3_msg"),
              ],
            );
          },
        ),
      ],
    ),
  );
  return targets;
}

// pageRouteReminderNew2
List<TargetFocus> _createTargetsPage2(
    BuildContext context, List<GlobalKey> keys) {
  List<TargetFocus> targets = [];
  targets.add(
    TargetFocus(
      identify: "tutorialStep1",
      keyTarget: keys[0],
      alignSkip: Alignment.topRight,
      shape: ShapeLightFocus.RRect,
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) {
            return SingleChildScrollView(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _getTSText(context, "coachtutorial_page2_step1"),
                _getTNText(context, "coachtutorial_page2_step1_msg"),
              ],
            ));
          },
        ),
      ],
    ),
  );
  targets.add(
    TargetFocus(
      identify: "tutorialStep1",
      keyTarget: keys[0],
      alignSkip: Alignment.topRight,
      shape: ShapeLightFocus.RRect,
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) {
            int styleType = Displayer.currenTimepickerStyle(context);
            double ratio = styleType == 1 ? (1174 / 900) : (1171 / 1052);
            String imglink = styleType == 1
                ? "timeselector_exmaple"
                : "timeselector_exmaple2";
            String txtkey = styleType == 1
                ? "coachtutorial_page2_step1b_msg"
                : "coachtutorial_page2_step1b2_msg";
            return SingleChildScrollView(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _getTSText(context, "coachtutorial_page2_step1a_msg"),
                Container(
                  width: MediaQuery.of(context).size.height * 0.3,
                  height: MediaQuery.of(context).size.height * 0.3 * ratio,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage(assetslinkImages(imglink))),
                      borderRadius:
                          BorderRadius.all(Radius.circular(cardsBorderRadius)),
                      border: Border.all(
                          color: elementActiveColor,
                          width: buttonBorderWidthReadOnly)),
                ),
                _getTNText(context, txtkey),
              ],
            ));
          },
        ),
      ],
    ),
  );
  targets.add(
    TargetFocus(
      identify: "tutorialStep1a",
      keyTarget: keys[1],
      alignSkip: Alignment.topRight,
      shape: ShapeLightFocus.RRect,
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _getTNText(context, "coachtutorial_page2_step1_msg2"),
              ],
            );
          },
        ),
      ],
    ),
  );
  targets.add(
    TargetFocus(
      identify: "tutorialStep2",
      keyTarget: keys[2],
      alignSkip: Alignment.topRight,
      shape: ShapeLightFocus.RRect,
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _getTSText(context, "coachtutorial_page2_step2"),
                _getTNText(context, "coachtutorial_page2_step2_msg"),
              ],
            );
          },
        ),
      ],
    ),
  );
  targets.add(
    TargetFocus(
      identify: "tutorialStep3",
      keyTarget: keys[3],
      alignSkip: Alignment.topRight,
      shape: ShapeLightFocus.RRect,
      contents: [
        TargetContent(
          align: ContentAlign.top,
          builder: (context, controller) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _getTSText(context, "coachtutorial_page2_step3"),
                _getTNText(context, "coachtutorial_page2_step3_msg"),
              ],
            );
          },
        ),
      ],
    ),
  );
  return targets;
}

// pageRouteReminderDetail
List<TargetFocus> _createTargetsPage3(
    BuildContext context, List<GlobalKey> keys) {
  List<TargetFocus> targets = [];
  targets.add(
    TargetFocus(
      identify: "tutorialStep1",
      keyTarget: keys[0],
      alignSkip: Alignment.topRight,
      shape: ShapeLightFocus.RRect,
      paddingFocus: 4.0,
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) {
            return SingleChildScrollView(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _getTSText(context, "coachtutorial_page3_step1"),
                _getTNText(context, "coachtutorial_page3_step1_msg"),
              ],
            ));
          },
        ),
      ],
    ),
  );
  targets.add(
    TargetFocus(
      identify: "tutorialStep2",
      keyTarget: keys[1],
      alignSkip: Alignment.topRight,
      shape: ShapeLightFocus.RRect,
      contents: [
        TargetContent(
          align: ContentAlign.top,
          builder: (context, controller) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _getTSText(context, "coachtutorial_page3_step2"),
                _getTNText(context, "coachtutorial_page3_step2_msg"),
              ],
            );
          },
        ),
      ],
    ),
  );
  return targets;
}
