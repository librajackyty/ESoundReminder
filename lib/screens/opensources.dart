import 'package:delayed_display/delayed_display.dart';
import 'package:e_sound_reminder_app/oss_licenses.dart';
import 'package:e_sound_reminder_app/widgets/custom_text_small.dart';
import 'package:flutter/material.dart';

import '../models/language.dart';
import '../utils/constants.dart';
import '../widgets/custom_scroll_bar.dart';
import '../widgets/custom_text_small_ex.dart';
import '../widgets/page_bottom_area.dart';

class OpenSourcesPage extends StatefulWidget {
  const OpenSourcesPage({super.key, required this.title});

  final String title;

  @override
  State<OpenSourcesPage> createState() => _OpenSourcesPageState();
}

class _OpenSourcesPageState extends State<OpenSourcesPage> {
  ScrollController _scrollController = ScrollController();
  List generateOssList() {
    List<Widget> displayList = [];
    for (var item in ossLicenses) {
      if (item.license?.isNotEmpty ?? false) {
        displayList.add(Column(
          children: [
            CusSText(
              item.name,
              color: elementActiveColor,
            ),
            CusSText(item.version),
            CusExSText(item.license.toString()),
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
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
                              physics: AlwaysScrollableScrollPhysics(
                                  parent: BouncingScrollPhysics()),
                              padding: const EdgeInsets.only(
                                  top: safeAreaPaddingAll),
                              children: [
                                CusSText(Language.of(context)!.t("oss_msg")),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                ...generateOssList()
                              ]))),
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
