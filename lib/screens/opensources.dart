import 'package:e_sound_reminder_app/oss_licenses.dart';
import 'package:e_sound_reminder_app/widgets/custom_text_small.dart';
import 'package:flutter/material.dart';

import '../models/language.dart';
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
  List generateOssList() {
    List<Widget> displayList = [];
    for (var item in ossLicenses) {
      if (item.license?.isNotEmpty ?? false) {
        displayList.add(Column(
          children: [
            Text(
              item.name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(item.version),
            Text(item.license.toString()),
            const SizedBox(
              height: 16.0,
            )
          ],
        ));
      }
    }
    return displayList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Language.of(context)!.t("oss_title")),
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
                        children: [
                      Text(Language.of(context)!.t("oss_msg")),
                      const SizedBox(
                        height: 20.0,
                      ),
                      ...generateOssList()
                    ])),
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
