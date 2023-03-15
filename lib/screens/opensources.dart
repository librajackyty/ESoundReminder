import 'package:e_sound_reminder_app/widgets/custom_text_small.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../widgets/custom_button_normal_back.dart';
import '../widgets/custom_list_item.dart';
import '../widgets/custom_text_normal.dart';

class OpenSourcesPage extends StatefulWidget {
  const OpenSourcesPage({super.key, required this.title});

  final String title;

  @override
  State<OpenSourcesPage> createState() => _OpenSourcesPageState();
}

class _OpenSourcesPageState extends State<OpenSourcesPage> {
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
                    child: ListView(
                        padding: const EdgeInsets.only(top: safeAreaPaddingAll),
                        children: <Widget>[
                      const Icon(
                        Icons.terminal,
                        color: Colors.green,
                        size: 88.0,
                      ),
                    ])),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child:
                        CusNBackButton('Back', () => {Navigator.pop(context)}),
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
