import 'package:delayed_display/delayed_display.dart';
import 'package:e_sound_reminder_app/models/language.dart';
import 'package:e_sound_reminder_app/utils/text_config.dart';
import 'package:e_sound_reminder_app/widgets/page_bottom_area.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../models/displayer.dart';
import '../utils/assetslink.dart';
import '../utils/constants.dart';
import '../widgets/custom_button_normal.dart';
import '../widgets/custom_button_normal_back.dart';
import '../widgets/custom_text_normal.dart';

class DisplayConfigPage extends StatefulWidget {
  const DisplayConfigPage({super.key, required this.title});

  final String title;

  @override
  State<DisplayConfigPage> createState() => _DisplayConfigPageState();
}

class _DisplayConfigPageState extends State<DisplayConfigPage> {
  List<Widget> sizeSelectArea(BuildContext context, List sizeDisplayKey) {
    List<Widget> mwList = [];
    for (var size in sizeDisplayKey) {
      mwList.add(CusNButton(
        "${Language.of(context)?.t("display_list_itm_$size")}",
        () {
          Displayer.updateAppTextSize(context, fromSizeValToType(size));
          Future.delayed(Duration(milliseconds: 100), goHome);
        },
        icon: size == Displayer.currentAppTextSize(context)
            ? Icon(
                Icons.radio_button_checked,
                size: 36.0,
              )
            : Icon(
                Icons.radio_button_unchecked,
                size: 36.0,
              ),
      ));
      mwList.add(const SizedBox(
        height: 8.0,
      ));
    }
    return mwList;
  }

  void goHome() {
    Navigator.pushReplacementNamed(context, pageRouteHome);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Language.of(context)!.t("display_title")),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(safeAreaPaddingAll),
          child: DelayedDisplay(
              child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Lottie.asset(
                  assetslinkLottie('119674-font-animation'),
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.width * 0.4,
                ),
                Visibility(
                    visible: true,
                    child: CusNText(
                      Language.of(context)!.t("display_list_msg"),
                      textAlign: TextAlign.center,
                    )),
                Expanded(
                    child: Scrollbar(
                        thumbVisibility: false,
                        thickness: 10.0,
                        child: ListView(
                            padding:
                                const EdgeInsets.only(top: safeAreaPaddingAll),
                            children: sizeSelectArea(context,
                                Displayer.sizeDisplayKey.keys.toList())))),
                Visibility(visible: true, child: PageBottomArea()),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
