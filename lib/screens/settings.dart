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
                // const Icon(
                //   Icons.settings,
                //   color: Colors.green,
                //   size: 88.0,
                // ),
                // CusSText('Version: 1.0.0'),
                Expanded(
                  child: Scrollbar(
                      thumbVisibility: true,
                      thickness: 10.0,
                      child: ListView(
                          padding:
                              const EdgeInsets.only(top: safeAreaPaddingAll),
                          children: [
                            Lottie.asset(
                              assetslinkLottie('65142-setting-gears'),
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.width * 0.4,
                            ),
                            CusListItm(
                                Icons.language,
                                Language.of(context)!
                                    .t("settings_list_language"), onTap: () {
                              Navigator.pushNamed(context, pageRouteLangConfig);
                            }),
                            CusListItm(Icons.help,
                                Language.of(context)!.t("settings_list_about"),
                                onTap: () {
                              Navigator.pushNamed(context, pageRouteAbout);
                            }),
                            CusListItm(Icons.terminal,
                                Language.of(context)!.t("settings_list_oss"),
                                onTap: () {
                              Navigator.pushNamed(
                                  context, pageRouteOpenSources);
                            }),
                          ])),
                ),
                // Expanded(
                //   child:
                Align(
                  alignment: Alignment.bottomCenter,
                  child: CusNBackButton(Language.of(context)!.t("common_back"),
                      () => {Navigator.pop(context)}),
                ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
