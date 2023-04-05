import 'package:e_sound_reminder_app/utils/feedback.dart';
import 'package:e_sound_reminder_app/widgets/custom_button_small.dart';
import 'package:flutter/material.dart';

import '../models/language.dart';
import '../utils/constants.dart';
import 'custom_card_container.dart';
import 'custom_text_title.dart';
import 'time_section_display.dart';

class CusCard extends StatefulWidget {
  final Widget icon;
  final String title;
  final String subtitle;
  final String subtitle2;
  final Widget? subline1;
  final String? btntxt1;
  VoidCallback? onPressed;
  Color? expiredColor;
  bool expiredTime1;

  CusCard(this.icon, this.title, this.subtitle, this.subtitle2,
      {this.subline1,
      this.btntxt1,
      this.onPressed,
      this.expiredColor,
      this.expiredTime1 = false});

  @override
  _CusCardState createState() => _CusCardState(icon, title, subtitle, subtitle2,
      subline1, btntxt1, onPressed, expiredColor, expiredTime1);
}

class _CusCardState extends State<CusCard> {
  Widget icon;
  String title;
  String subtitle;
  String subtitle2;
  Widget? subline1;
  String? btntxt1;
  VoidCallback? onPressed;
  Color? expiredColor;
  bool expiredTime1;

  _CusCardState(
      this.icon,
      this.title,
      this.subtitle,
      this.subtitle2,
      this.subline1,
      this.btntxt1,
      this.onPressed,
      this.expiredColor,
      this.expiredTime1);

  @override
  Widget build(BuildContext context) {
    return CusCardContainer(
      child: InkWell(
        borderRadius: BorderRadius.circular(cardsBorderRadius),
        onTap: () {
          debugPrint("Card Clicked");
          widget.onPressed?.call();
          runHapticSound();
        },
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
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
                  ))
                ],
              ),
            ),
            TimeSectionDisplay(
              times: [widget.subtitle],
              color: widget.expiredColor,
              expiredTime1: widget.expiredTime1,
            ),
            widget.subline1 ?? const SizedBox.shrink(),
            const SizedBox(
              height: 8,
            ),
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
      ),
    );
  }
}
