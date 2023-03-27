import 'package:e_sound_reminder_app/widgets/custom_text_normal.dart';
import 'package:flutter/material.dart';

import '../models/language.dart';
import '../utils/constants.dart';
import 'custom_text_small.dart';
import 'custom_text_title.dart';

class CusCard extends StatefulWidget {
  final Widget icon;
  final String title;
  final String subtitle;
  final String subtitle2;
  // final String text;
  final String? btntxt1;
  // final String btntxt2;
  VoidCallback? onPressed;

  CusCard(this.icon, this.title, this.subtitle, this.subtitle2,
      {this.btntxt1, this.onPressed});

  @override
  _CusCardState createState() =>
      _CusCardState(icon, title, subtitle, subtitle2, btntxt1, onPressed);
}

class _CusCardState extends State<CusCard> {
  Widget icon;
  String title;
  String subtitle;
  String subtitle2;
  // String text;
  String? btntxt1;
  // String btntxt2;
  VoidCallback? onPressed;

  _CusCardState(this.icon, this.title, this.subtitle, this.subtitle2,
      this.btntxt1, this.onPressed);

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
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: widget.icon,
                // Icon(
                //   Icons.nightlight_rounded, // Icons.sunny
                //   color: Colors.yellow[600]!, // Colors.yellow[900]!
                //   size: 36.0,
                //   semanticLabel:
                //       'moon icon means Time between 18:00 to 06:00', //'sunny icon means Time between 06:00 to 18:00',
                // ),
                title: CusNText(widget.title),
                subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CusTitleText(widget.subtitle),
                      CusNText(widget.subtitle2),
                    ]), //CusTitleText(widget.subtitle),
                isThreeLine: true,
              ),
              // CusSText(
              //   "Repeat: Mon, Tue, Wed, Thur, Fri, Sat", //More
              //   // color: Colors.black,
              // ),
              // Wrap(
              //     // mainAxisAlignment: MainAxisAlignment.start,
              //     children: <Widget>[
              //       CusSText(
              //         "Repeat: Mon, Tue, Wed, Thur, Fri, Sat", //More
              //         // color: Colors.black,
              //       ),
              //     ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  // TextButton(
                  //   child: Text(widget.btntxt1),
                  //   onPressed: () {/* ... */},
                  // ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.summarize_rounded,
                    size: 20.0,
                    semanticLabel: 'Tap to edit',
                    color: Colors.green[800],
                  ),
                  CusSText(
                    widget.btntxt1 != null
                        ? widget.btntxt1!
                        : Language.of(context)!.t("home_card_more"), //More
                    color: Colors.green[800],
                  ),
                  // TextButton(
                  //   style: TextButton.styleFrom(
                  //       fixedSize: const Size.fromHeight(50)),
                  //   onPressed: widget.onPressed,
                  //   child: Text(widget.btntxt1, style: TextStyle(fontSize: 25)),
                  // ),
                  const SizedBox(width: 8),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
