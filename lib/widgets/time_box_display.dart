import 'package:flutter/material.dart';

import 'custom_text_normal.dart';

class TimeBoxDisplay extends StatelessWidget {
  final String time;
  final Widget? icon;

  const TimeBoxDisplay({Key? key, required this.time, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.green[800]!),
          borderRadius: BorderRadius.all(Radius.circular(4.0))),
      child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [icon ?? const SizedBox(), CusNText(time)]),
    );
  }
}
