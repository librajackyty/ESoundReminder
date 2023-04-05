import 'dart:ui';

import 'package:flutter/material.dart';

import '../models/language.dart';
import 'custom_button_normal_back.dart';

class PageBottomArea extends StatelessWidget {
  final VoidCallback? onPressed;

  const PageBottomArea({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        clipBehavior: Clip.antiAlias,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Align(
            alignment: Alignment.bottomCenter,
            child: CusNBackButton(Language.of(context)!.t("common_back"),
                onPressed ?? () => Navigator.pop(context))));
  }
}
