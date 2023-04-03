import 'package:day_picker/day_picker.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../utils/feedback.dart';

class WeekdaysSelector extends StatefulWidget {
  final List<DayInWeek> days;
  final Function onSelect;
  BoxDecoration? boxDecoration;

  WeekdaysSelector(
      {required this.days, required this.onSelect, this.boxDecoration});

  @override
  _WeekdaysSelectorState createState() => _WeekdaysSelectorState();
}

class _WeekdaysSelectorState extends State<WeekdaysSelector> {
  _WeekdaysSelectorState();

  @override
  Widget build(BuildContext context) {
    return SelectWeekDays(
      padding: selectWeekDaysPadding,
      fontSize: selectWeekDaysFontSize,
      fontWeight: FontWeight.bold,
      days: widget.days,
      selectedDayTextColor: elementActiveTxtColor,
      unSelectedDayTextColor: elementNotActiveTxtColor,
      daysFillColor: elementActiveColor,
      daysBorderColor: elementActiveColor,
      boxDecoration: widget.boxDecoration,
      onSelect: (values) {
        widget.onSelect(values);
        runHapticSound();
      },
    );
  }
}
