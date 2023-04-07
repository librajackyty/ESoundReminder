import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../models/language.dart';
import '../utils/assetslink.dart';
import '../utils/constants.dart';
import '../widgets/custom_scroll_bar.dart';
import '../widgets/custom_text_normal.dart';
import '../widgets/custom_text_small.dart';
import '../widgets/page_bottom_area.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key, required this.title});

  final String title;

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  /*
  Package info
  Requesting app name, app version
  */
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }
  // =======

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Language.of(context)!.t("about_title")),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
              left: safeAreaPaddingAll,
              right: safeAreaPaddingAll,
              bottom: safeAreaPaddingAll),
          child: DelayedDisplay(
            slidingBeginOffset: const Offset(0.55, 0.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: CusScrollbar(
                        scrollController: _scrollController,
                        child: ListView(
                            controller: _scrollController,
                            padding:
                                const EdgeInsets.only(top: safeAreaPaddingAll),
                            children: <Widget>[
                              Image(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  height:
                                      MediaQuery.of(context).size.width * 0.4,
                                  image: AssetImage(assetslinkImages(
                                      'app_icon_512_rounded'))),
                              const SizedBox(
                                height: 16,
                              ),
                              CusSText(
                                  Language.of(context)!.t("about_appname")),
                              CusNText(
                                _packageInfo.appName != 'Unknown'
                                    ? _packageInfo.appName
                                    : 'ESound Reminder (TBC)',
                              ),
                              CusSText(
                                  Language.of(context)!.t("about_version")),
                              CusNText(
                                _packageInfo.version != 'Unknown'
                                    ? _packageInfo.version
                                    : "${0.1} alpha",
                              ),
                              const SizedBox(height: 20),
                              CusSText(Language.of(context)!
                                  .t("about_pj_developer")),
                              CusNText(
                                "Yuen tin Yau Jack",
                              ),
                              const SizedBox(height: 20),
                              CusSText(Language.of(context)!
                                  .t("about_contact_mobile")),
                              CusNText(
                                "+852 90622642",
                              ),
                              CusSText(Language.of(context)!
                                  .t("about_contact_email")),
                              CusNText(
                                "jackyuen4-c@my.cityu.edu.hk",
                              ),
                              const SizedBox(height: 20),
                              CusSText(
                                "Repository (GitHub):",
                              ),
                              CusSText(
                                "https://github.com/librajackyty/ESoundReminder.git",
                              ),
                              const SizedBox(height: 20),
                              CusSText(
                                "Copyright © 2023 Jack TY Yuen All rights reserved.",
                              ),
                            ])),
                  ),
                  PageBottomArea()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
