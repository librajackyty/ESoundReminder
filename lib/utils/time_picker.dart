import 'package:flutter/material.dart';

import 'constants.dart';

final theme = ThemeData.light().copyWith(
    timePickerTheme: TimePickerThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
            cardsBorderRadius), // this is the border radius of the picker
      ),
      backgroundColor: Colors.lightGreen.shade100,
      hourMinuteColor: MaterialStateColor.resolveWith(
          (states) => states.contains(MaterialState.selected)
              ? elementActiveColor // Colors.blue.withOpacity(0.2)
              : elementNotActiveColor),
      hourMinuteTextColor: MaterialStateColor.resolveWith((states) =>
          states.contains(MaterialState.selected)
              ? elementActiveTxtColor
              : elementNotActiveTxtColor),
      hourMinuteShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
          side:
              BorderSide(color: elementActiveColor, width: buttonBorderWidth)),
      dayPeriodColor: MaterialStateColor.resolveWith(
          (states) => states.contains(MaterialState.selected)
              ? elementActiveColor // Colors.blue.withOpacity(0.2)
              : elementNotActiveColor),
      dayPeriodTextColor: MaterialStateColor.resolveWith((states) =>
          states.contains(MaterialState.selected)
              ? elementActiveTxtColor
              : elementNotActiveTxtColor),
      dayPeriodBorderSide:
          BorderSide(color: elementActiveColor, width: buttonBorderWidth),
      dayPeriodShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      dialHandColor: elementActiveColor,
      dialBackgroundColor: elementNotActiveColor,
      dialTextColor: MaterialStateColor.resolveWith((states) =>
          states.contains(MaterialState.selected)
              ? elementActiveTxtColor
              : elementNotActiveTxtColor),
      entryModeIconColor: elementNotActiveTxtColor,
      helpTextStyle: const TextStyle(
          fontSize: textSmallSize,
          fontWeight: FontWeight.bold,
          color: Colors.black),
      // inputDecorationTheme: ThemeData.light().inputDecorationTheme.copyWith(
      //       activeIndicatorBorder: BorderSide(color: elementActiveColor),
      //       border: OutlineInputBorder(
      //           borderSide: BorderSide(
      //               color: buttonReadOnlyForegroundColor,
      //               width: buttonBorderWidth)),
      //       focusedBorder: OutlineInputBorder(
      //           borderSide: BorderSide(
      //               color: elementActiveColor, width: buttonBorderWidth)),
      //       errorBorder: OutlineInputBorder(
      //           borderSide: BorderSide(
      //               color: buttonForegroundColor2, width: buttonBorderWidth)),
      //       focusedErrorBorder: OutlineInputBorder(
      //           borderSide: BorderSide(
      //               color: buttonForegroundColor2, width: buttonBorderWidth)))
    ),
    textTheme: TextTheme(
      labelSmall: TextStyle(
        color: elementNotActiveTxtColor,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
      // fixedSize: MaterialStateProperty.all(Size.fromHeight(buttonHeight)),
      // side: MaterialStateBorderSide.resolveWith((states) => BorderSide(
      //       width: buttonBorderWidth,
      //       color: buttonBorderColor,
      //     )),
      textStyle: MaterialStateTextStyle.resolveWith((states) =>
          TextStyle(fontSize: textBtnSize, fontWeight: FontWeight.bold)),
      // backgroundColor:
      //     MaterialStateColor.resolveWith((states) => Colors.white),
      foregroundColor:
          MaterialStateColor.resolveWith((states) => elementActiveColor),
      overlayColor:
          MaterialStateColor.resolveWith((states) => buttonReadOnlyColor),
    )));

Future<TimeOfDay?> showStyledTimePicker(
    BuildContext context, TimeOfDay initialTime,
    {TimePickerEntryMode initialEntryMode = TimePickerEntryMode.dialOnly,
    String? confirmText,
    String? cancelText,
    String? helpText,
    String? errorInvalidText}) {
  return showDefaultTimePicker(context, initialTime,
      initialEntryMode: initialEntryMode, builder: (context, child) {
    return MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
        child: Theme(data: theme, child: child!));
    // return Theme(data: theme, child: child!);
  },
      errorInvalidText: errorInvalidText,
      helpText: helpText,
      confirmText: confirmText,
      cancelText: cancelText);
}

Future<TimeOfDay?> showDefaultTimePicker(
    BuildContext context, TimeOfDay initialTime,
    {TimePickerEntryMode initialEntryMode = TimePickerEntryMode.dial,
    Widget Function(BuildContext, Widget?)? builder,
    String? confirmText,
    String? cancelText,
    String? helpText,
    String? errorInvalidText}) {
  return showTimePicker(
      context: context,
      initialTime: initialTime,
      initialEntryMode: initialEntryMode,
      builder: builder,
      errorInvalidText: errorInvalidText,
      helpText: helpText,
      confirmText: confirmText,
      cancelText: cancelText);
}
