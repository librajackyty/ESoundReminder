import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../models/language.dart';
import '../utils/assetslink.dart';
import '../utils/constants.dart';
import '../widgets/custom_list_item.dart';
import '../widgets/custom_scroll_bar.dart';
import '../widgets/page_bottom_area.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key, required this.title});

  final String title;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Language.of(context)!.t("settings_title")),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
              left: safeAreaPaddingAll,
              right: safeAreaPaddingAll,
              bottom: safeAreaPaddingAll),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: DelayedDisplay(
                      slidingBeginOffset: const Offset(0.55, 0.0),
                      child: CusScrollbar(
                          scrollController: _scrollController,
                          child: ListView(
                              controller: _scrollController,
                              physics: AlwaysScrollableScrollPhysics(
                                  parent: BouncingScrollPhysics()),
                              padding: const EdgeInsets.only(
                                  top: safeAreaPaddingAll),
                              children: [
                                Lottie.asset(
                                  assetslinkLottie(
                                      '94350-gears-lottie-animation'),
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  height:
                                      MediaQuery.of(context).size.width * 0.4,
                                ),
                                CusListItm(
                                    Language.of(context)!
                                        .t("settings_list_language"),
                                    noBorder: true,
                                    iconData: Icons.language, onTap: () {
                                  Navigator.pushNamed(
                                      context, pageRouteLangConfig);
                                }),
                                CusListItm(
                                    Language.of(context)!
                                        .t("settings_list_display"),
                                    noBorder: true,
                                    iconData: Icons.text_increase, onTap: () {
                                  Navigator.pushNamed(
                                      context, pageRouteDisplayConfig);
                                }),
                                CusListItm(
                                    Language.of(context)!
                                        .t("settings_list_about"),
                                    noBorder: true,
                                    iconData: Icons.help, onTap: () {
                                  Navigator.pushNamed(context, pageRouteAbout);
                                }),
                                CusListItm(
                                    Language.of(context)!
                                        .t("settings_list_oss"),
                                    noBorder: true,
                                    iconData: Icons.terminal, onTap: () {
                                  Navigator.pushNamed(
                                      context, pageRouteOpenSources);
                                }),
                              ]))),
                ),
                DelayedDisplay(
                    delay: Duration(milliseconds: pageBottomDelayShowTime),
                    child: PageBottomArea())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
