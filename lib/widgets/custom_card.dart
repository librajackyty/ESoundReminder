import 'package:day_picker/model/day_in_week.dart';
import 'package:e_sound_reminder_app/models/reminder.dart';
import 'package:e_sound_reminder_app/widgets/custom_button_small.dart';
import 'package:e_sound_reminder_app/widgets/custom_text_normal.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../models/language.dart';
import '../utils/assetslink.dart';
import '../utils/constants.dart';
import 'custom_text_small.dart';
import 'custom_text_title.dart';
import 'reminder_weekdays.dart';
import 'time_box_display.dart';
import 'time_section_display.dart';

class CusCard extends StatefulWidget {
  final Widget icon;
  final String title;
  final String subtitle;
  final String subtitle2;
  final Widget? subline1;
  final String? btntxt1;
  // final String btntxt2;
  VoidCallback? onPressed;

  CusCard(this.icon, this.title, this.subtitle, this.subtitle2,
      {this.subline1, this.btntxt1, this.onPressed});

  @override
  _CusCardState createState() => _CusCardState(
      icon, title, subtitle, subtitle2, subline1, btntxt1, onPressed);
}

class _CusCardState extends State<CusCard> {
  Widget icon;
  String title;
  String subtitle;
  String subtitle2;
  Widget? subline1;
  String? btntxt1;
  // String btntxt2;
  VoidCallback? onPressed;

  _CusCardState(this.icon, this.title, this.subtitle, this.subtitle2,
      this.subline1, this.btntxt1, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Card(
      // color: Colors.white,
      // surfaceTintColor: Colors.white,
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          width: 1.0,
          color: Colors.greenAccent,
        ),
        borderRadius: BorderRadius.circular(cardsBorderRadius),
      ),
      elevation: cardsElevation,
      child: InkWell(
        borderRadius: BorderRadius.circular(cardsBorderRadius),
        onTap: () {
          print("Card Clicked");
          widget.onPressed?.call();
        },
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white, //Colors.green[600],
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(cardsBorderRadius),
                    topRight: Radius.circular(cardsBorderRadius)),
              ),
              child: Row(
                children: [
                  widget.icon,
                  const SizedBox(
                    width: 8,
                  ),
                  Flexible(
                      child: CusTitleText(
                    widget.title,
                    // color: Colors.green[900],
                  )
                      // CusNText(
                      //     "widget.title sklnk nksdnljn jbdkj bdjkb kjb kbdfjbdsjkhb jkhdbf jbjsdb")
                      )
                ],
              ),
            ),
            TimeSectionDisplay(
              times: [widget.subtitle],
            ),
            widget.subline1 ?? Container(),
            const SizedBox(
              height: 8,
            ),
            // Row(
            //   children: [
            // Spacer(),
            const Divider(),
            Container(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: CusSButton(
                    widget.btntxt1 != null
                        ? widget.btntxt1!
                        : Language.of(context)!.t("home_card_more"), () {
                  widget.onPressed?.call();
                }))
          ],
        ),
        // ),
      ),
    );
  }
}
