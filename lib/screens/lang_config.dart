import 'package:e_sound_reminder_app/models/language.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../providers/app_language.dart';
import '../utils/assetslink.dart';
import '../utils/constants.dart';
import '../widgets/custom_button_normal.dart';
import '../widgets/custom_button_normal_back.dart';
import '../widgets/custom_text_normal.dart';

class LangConfigPage extends StatefulWidget {
  const LangConfigPage({super.key, required this.title});

  final String title;

  @override
  State<LangConfigPage> createState() => _LangConfigPageState();
}

class _LangConfigPageState extends State<LangConfigPage> {
  bool initalConfig = true;

  List<Widget> langSelectArea(
      BuildContext context, AppLanguage appLanguage, List langlist) {
    List<Widget> mwList = [];
    for (var lang in langlist) {
      mwList.add(CusNButton(
        "${Language.localeDisplay[lang]}",
        () {
          // setState(() {
          appLanguage.changeLanguage(Locale(lang));
          // });
          if (initalConfig) {
            Navigator.pushReplacementNamed(context, pageRouteHome);
          } else {
            Navigator.of(context).pop();
          }
        },
        icon: !initalConfig && lang == Language.currentLocale(context)
            ? Icon(
                Icons.check,
                size: 36.0,
              )
            : null,
      ));
      mwList.add(const SizedBox(
        height: 8.0,
      ));
    }
    return mwList;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    initalConfig = Provider.of<AppLanguage>(context).isInitalConfig;
    debugPrint("initalConfig: $initalConfig");
    return Scaffold(
      appBar: initalConfig
          ? null
          : AppBar(
              title: Text(Language.of(context)!.t("lang_title")),
            ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(safeAreaPaddingAll),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Lottie.asset(
                  assetslinkLottie('132900-0101ftue-04'),
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.width * 0.4,
                ),
                Visibility(
                    visible: !initalConfig,
                    child: CusNText(
                      Language.of(context)!.t("lang_list_msg"),
                      textAlign: TextAlign.center,
                    )),
                Expanded(
                    child: Scrollbar(
                        thumbVisibility: false,
                        thickness: 10.0,
                        child: ListView(
                            padding:
                                const EdgeInsets.only(top: safeAreaPaddingAll),
                            children: langSelectArea(
                                context,
                                Provider.of<AppLanguage>(context),
                                Language.localeDisplay.keys.toList())))),
                Visibility(
                  visible: !initalConfig,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: CusNBackButton(
                        Language.of(context)!.t("common_back"),
                        () => {Navigator.pop(context)}),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
