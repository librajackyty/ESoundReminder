import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../utils/assetslink.dart';
import '../utils/constants.dart';
import '../widgets/custom_button_normal_back.dart';
import '../widgets/custom_text_normal.dart';

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
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, pageRouteHome);
        // Navigator.pushNamedAndRemoveUntil(
        //     context, pageRouteHome, (route) => false);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(safeAreaPaddingAll),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Lottie.asset(
                //   assetslinkLottie(
                //       '126961-medicine-icon-lottie-json-animation'),
                //   width: MediaQuery.of(context).size.width * 0.4,
                //   height: MediaQuery.of(context).size.width * 0.4,
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
