import 'package:delayed_display/delayed_display.dart';
import 'package:e_sound_reminder_app/models/language.dart';
import 'package:e_sound_reminder_app/widgets/page_bottom_area.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../models/displayer.dart';
import '../utils/assetslink.dart';
import '../utils/constants.dart';
import '../widgets/custom_list_item_switch.dart';
import '../widgets/custom_scroll_bar.dart';
import '../widgets/custom_text_normal.dart';

class OtherConfigPage extends StatefulWidget {
  const OtherConfigPage({super.key, required this.title});

  final String title;

  @override
  State<OtherConfigPage> createState() => _DisplayConfigPageState();
}

class _DisplayConfigPageState extends State<OtherConfigPage> {
  bool _timepickerSliderStyle = true;
  ScrollController _scrollController = ScrollController();
  List<Widget> settingArea(BuildContext context) {
    List<Widget> mwList = [];
    mwList.add(timePickerTypeSelection());
    return mwList;
  }

  Widget timePickerTypeSelection() {
    return Container(
      padding: EdgeInsets.all(elementSSPadding),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CusNText(Language.of(context)!.t("other_timepicker_title")),
            CusListItmSwitch(
              _timepickerSliderStyle,
              onTap: (val) {
                debugPrint("Switch val return: $val");
                setState(() {
                  _timepickerSliderStyle = val;
                });
                savingTimepickerStyle(context, _timepickerSliderStyle);
              },
              imageData: Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.width * 0.6 * (470 / 875),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(
                            assetslinkImages('timepicker_sliderstyle'))),
                    borderRadius:
                        BorderRadius.all(Radius.circular(cardsBorderRadius)),
                    border: Border.all(
                        color: elementActiveColor,
                        width: buttonBorderWidthReadOnly)),
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: elementLPadding),
                child: const Divider()),
            CusListItmSwitch(
              !_timepickerSliderStyle,
              onTap: (val) {
                setState(() {
                  _timepickerSliderStyle = !val;
                });
                savingTimepickerStyle(context, _timepickerSliderStyle);
              },
              imageData: Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.width * 0.6 * (470 / 875),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(
                            assetslinkImages('timepicker_scrollstyle'))),
                    borderRadius:
                        BorderRadius.all(Radius.circular(cardsBorderRadius)),
                    border: Border.all(
                        color: elementActiveColor,
                        width: buttonBorderWidthReadOnly)),
              ),
            ),
          ]),
    );
  }

  void savingTimepickerStyle(BuildContext context, bool val) {
    debugPrint("savingTimepickerStyle: $val");
    int newStyle = Displayer.codeTimepickerStyle1;
    if (val) {
      newStyle = Displayer.codeTimepickerStyle1;
    } else {
      newStyle = Displayer.codeTimepickerStyle2;
    }
    Displayer.updateTimepickerStyle(context, newStyle);
  }

  void goHome() {
    Navigator.pushReplacementNamed(context, pageRouteHome);
  }

  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   if (context.mounted) {
    //     int currStyle = Displayer.currenTimepickerStyle(context);
    //     _timepickerSliderStyle = currStyle == 1;
    //   }
    // });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _timepickerSliderStyle = Displayer.currenTimepickerStyle(context) == 1;
    return Scaffold(
      appBar: AppBar(
        title: Text(Language.of(context)!.t("other_title")),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(safeAreaPaddingAll),
          child: DelayedDisplay(
              slidingBeginOffset: const Offset(0.55, 0.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Lottie.asset(
                      assetslinkLottie('91645-adaptive-mobile-app-design'),
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.width * 0.4,
                    ),
                    Expanded(
                        child: CusScrollbar(
                            scrollController: _scrollController,
                            child: ListView(
                                controller: _scrollController,
                                physics: AlwaysScrollableScrollPhysics(
                                    parent: BouncingScrollPhysics()),
                                padding: const EdgeInsets.only(
                                    top: safeAreaPaddingAll),
                                children: settingArea(context)))),
                    Visibility(visible: true, child: PageBottomArea()),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
