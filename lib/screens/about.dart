import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../widgets/custom_button_normal_back.dart';
import '../widgets/custom_text_normal.dart';
import '../widgets/custom_text_small.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key, required this.title});

  final String title;

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
                  // flex: 2,
                  child: ListView(
                      padding: const EdgeInsets.only(top: safeAreaPaddingAll),
                      children: <Widget>[
                        CusSText(
                          'App Name:',
                        ),
                        CusNText(
                          'ESound Reminder',
                        ),
                        CusSText(
                          'Version: ',
                        ),
                        CusNText(
                          "${1.0}",
                        ),
                        const SizedBox(height: 20),
                        CusSText(
                          "Project of:",
                        ),
                        CusNText(
                          "School of Continuing and Professional Education ( CityU SCOPE )",
                        ),
                        CusSText(
                          "Project Developer:",
                        ),
                        CusNText(
                          "Yuen tin Yau Jack",
                        ),
                        const SizedBox(height: 20),
                        CusSText(
                          "Contact (mobile):",
                        ),
                        CusNText(
                          "+852 90622642",
                        ),
                        CusSText(
                          "Contact (email):",
                        ),
                        CusNText(
                          "jackyuen4-c@my.cityu.edu.hk",
                        ),
                        const SizedBox(height: 20),
                        CusSText(
                          "Repository (GitHub):",
                        ),
                      ]),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: CusNBackButton('Back', () => {Navigator.pop(context)}),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
