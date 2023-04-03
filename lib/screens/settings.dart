import 'package:e_sound_reminder_app/widgets/custom_text_small.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../models/language.dart';
import '../utils/assetslink.dart';
import '../utils/constants.dart';
import '../widgets/custom_button_normal_back.dart';
import '../widgets/custom_list_item.dart';
import '../widgets/custom_text_normal.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key, required this.title});

  final String title;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
                  child: Scrollbar(
                      thumbVisibility: true,
                      thickness: 10.0,
                      child: ListView(
                          padding:
                              const EdgeInsets.only(top: safeAreaPaddingAll),
                          children: [
                            Lottie.asset(
                              assetslinkLottie('94350-gears-lottie-animation'),
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.width * 0.4,
                            ),
                            CusListItm(
                                Language.of(context)!
                                    .t("settings_list_language"),
                                iconData: Icons.language, onTap: () {
                              Navigator.pushNamed(context, pageRouteLangConfig);
                            }),
                            CusListItm(
                                Language.of(context)!.t("settings_list_about"),
                                iconData: Icons.help, onTap: () {
                              Navigator.pushNamed(context, pageRouteAbout);
                            }),
                            CusListItm(
                                Language.of(context)!.t("settings_list_oss"),
                                iconData: Icons.terminal, onTap: () {
                              Navigator.pushNamed(
                                  context, pageRouteOpenSources);
                            }),
                          ])),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: CusNBackButton(Language.of(context)!.t("common_back"),
                      () => {Navigator.pop(context)}),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
