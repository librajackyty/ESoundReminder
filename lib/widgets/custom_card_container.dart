import 'package:flutter/material.dart';

import '../utils/constants.dart';

class CusCardContainer extends StatelessWidget {
  final Widget child;

  const CusCardContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.only(bottom: reminderCardBottomMargin),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.greenAccent,
          ),
          borderRadius: BorderRadius.circular(cardsBorderRadius),
        ),
        elevation: cardsElevation,
        child: child);
  }
}
