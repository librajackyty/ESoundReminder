import 'package:e_sound_reminder_app/widgets/custom_text_small_ex.dart';
import 'package:flutter/material.dart';

import 'custom_text_small.dart';

class LabeledSwitch extends StatelessWidget {
  const LabeledSwitch({
    super.key,
    required this.label,
    this.labelRight,
    this.padding,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final String? labelRight;
  final EdgeInsets? padding;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Padding(
        padding: padding ?? EdgeInsets.all(0),
        child: Row(
          children: [
            Expanded(child: CusSText(label)),
            labelRight != null
                ? CusExSText(labelRight!)
                : const SizedBox.shrink(),
            Switch(
              value: value,
              onChanged: (bool newValue) {
                onChanged(newValue);
              },
            ),
          ],
        ),
      ),
    );
  }
}