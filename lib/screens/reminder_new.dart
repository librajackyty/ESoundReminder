import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../widgets/custom_button_normal.dart';
import '../widgets/custom_button_normal_back.dart';
import '../widgets/custom_text_normal.dart';

class ReminderNewPage extends StatefulWidget {
  const ReminderNewPage({super.key, required this.title});

  final String title;

  @override
  State<ReminderNewPage> createState() => _ReminderNewPageState();
}

class _ReminderNewPageState extends State<ReminderNewPage> {
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
                Expanded(
                  child: CusNText(
                    'Creating Reminder New',
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: CusNBackButton(
                          'Back', () => {Navigator.pop(context)}),
                    ),
                    Expanded(child: const SizedBox()),
                    Expanded(
                      flex: 5,
                      child: CusNButton('Next', () => {Navigator.pop(context)}),
                    ),
                  ],
                )

                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
