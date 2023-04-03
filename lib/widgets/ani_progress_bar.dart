import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';

class AniProgressBar extends StatelessWidget {
  final double currentValue;

  const AniProgressBar({Key? key, required this.currentValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FAProgressBar(
      currentValue: currentValue,
      changeColorValue: 80,
      displayText: '%',
      size: 16,
      progressColor: Colors.green.shade900,
      changeProgressColor: Colors.green.shade600,
    );
  }
}
