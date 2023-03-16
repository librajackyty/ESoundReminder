import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../widgets/custom_button_normal_back.dart';
import '../widgets/custom_text_normal.dart';

class ReminderDetailPage extends StatefulWidget {
  const ReminderDetailPage({super.key, required this.title});

  final String title;

  @override
  State<ReminderDetailPage> createState() => _ReminderDetailPageState();
}

class _ReminderDetailPageState extends State<ReminderDetailPage> {
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
                CusNText(
                  'ReminderDetail:',
                ),
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
