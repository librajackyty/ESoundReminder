import 'package:e_sound_reminder_app/models/language.dart';
import 'package:e_sound_reminder_app/widgets/custom_text_normal.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../utils/assetslink.dart';
import '../utils/constants.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key, required this.title});

  final String title;

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(const Duration(seconds: 2), goHome);
    });
    super.initState();
  }

  void goHome() {
    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(
          context, pageRouteHome, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(safeAreaPaddingAll),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Lottie.asset(
                  assetslinkLottie(
                      '126961-medicine-icon-lottie-json-animation'),
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.width * 0.4,
                ),
                CusNText(Language.of(context)!.t("localnotification_title"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
