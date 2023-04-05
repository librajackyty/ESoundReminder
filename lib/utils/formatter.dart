import 'package:flutter/material.dart';

import '../models/language.dart';
import '../models/reminder.dart';

String fromWeekdayToString(BuildContext context, int weekday) {
  switch (weekday) {
    case 1:
      return Language.of(context)!.t("week_mon");
    case 2:
      return Language.of(context)!.t("week_tue");
    case 3:
      return Language.of(context)!.t("week_wed");
    case 4:
      return Language.of(context)!.t("week_thu");
    case 5:
      return Language.of(context)!.t("week_fri");
    case 6:
      return Language.of(context)!.t("week_sat");
    case 7:
      return Language.of(context)!.t("week_sun");
    default:
      return '';
  }
}

String fromWeekdayToShortString(BuildContext context, int weekday) {
  switch (weekday) {
    case 1:
      return Language.of(context)!.t("week_mon_s");
    case 2:
      return Language.of(context)!.t("week_tue_s");
    case 3:
      return Language.of(context)!.t("week_wed_s");
    case 4:
      return Language.of(context)!.t("week_thu_s");
    case 5:
      return Language.of(context)!.t("week_fri_s");
    case 6:
      return Language.of(context)!.t("week_sat_s");
    case 7:
      return Language.of(context)!.t("week_sun_s");
    default:
      return '';
  }
}

String fromWeekdayToExShortString(BuildContext context, int weekday) {
  switch (weekday) {
    case 1:
      return Language.of(context)!.t("week_mon_ss");
    case 2:
      return Language.of(context)!.t("week_tue_ss");
    case 3:
      return Language.of(context)!.t("week_wed_ss");
    case 4:
      return Language.of(context)!.t("week_thu_ss");
    case 5:
      return Language.of(context)!.t("week_fri_ss");
    case 6:
      return Language.of(context)!.t("week_sat_ss");
    case 7:
      return Language.of(context)!.t("week_sun_ss");
    default:
      return '';
  }
}

int fromStringToWeekday(String weekdayStr) {
  switch (weekdayStr) {
    case 'Monday':
    case '一':
      return 1;
    case 'Tuesday':
    case '二':
      return 2;
    case 'Wednesday':
    case '三':
      return 3;
    case 'Thursday':
    case '四':
      return 4;
    case 'Friday':
    case '五':
      return 5;
    case 'Saturday':
    case '六':
      return 6;
    case 'Sunday':
    case '日':
      return 7;
    default:
      return 0;
  }
}

DateTime convertSelectTime(DateTime dateTime) {
  final currentT = DateTime.now();
  debugPrint("convertSelectTime: ${currentT.toString()}");
  if (dateTime.isBefore(currentT)) {
    return dateTime.add(const Duration(days: 1));
  }
  return dateTime;
}

String fromTimeToString(DateTime time,
    {List? weekdays, List<String>? dateTxts, bool longFormat = false}) {
  String timeStr = '${hTOhh_24hTrue(time.hour)}:${mTOmm(time.minute)}';
  if (weekdays != null) {
    if (weekdays.isEmpty) {
      if (dateTxts != null && dateTxts.isNotEmpty) {
        return _showTimeWthdateTxt(time, timeStr, dateTxts, longFormat);
      }
      return '${time.year}/${time.month}/${time.day}\n$timeStr';
    }
  }
  return timeStr;
}

String _showTimeWthdateTxt(
    DateTime time, String timeStr, List<String> dateTxts, bool longFormat) {
  final currentT = DateTime.now();

  if (longFormat) {
    if (currentT.isBefore(time)) {
      if (currentT.day <= time.day) {
        // tdy
        return '${time.year}/${time.month}/${time.day}\n${dateTxts[0]} $timeStr';
      }
      // tmr
      return '${time.year}/${time.month}/${time.day}\n${dateTxts[1]} $timeStr';
    } else {
      // expired
      if (dateTxts.length >= 3) {
        return '${time.year}/${time.month}/${time.day}\n${dateTxts[2]} $timeStr';
      }
      return '${time.year}/${time.month}/${time.day} $timeStr';
    }
  } else {
    if (currentT.isBefore(time)) {
      if (currentT.day <= time.day) {
        // tdy
        return '${dateTxts[0]} $timeStr';
      }
      // tmr
      return '${dateTxts[1]} $timeStr';
    } else {
      // expired
      if (dateTxts.length >= 3) {
        return '${dateTxts[2]} $timeStr';
      }
      return 'X $timeStr';
    }
  }
}

String fromTimeOfDayToString(TimeOfDay time, {List? weekdays}) {
  return '${hTOhh_24hTrue(time.hour)}:${mTOmm(time.minute)}';
}

String hTOhh_24hTrue(int hour) {
  late String sHour;
  if (hour < 10) {
    sHour = '0$hour';
  } else {
    sHour = '$hour';
  }
  return sHour;
}

List<String> hTOhh_24hFalse(int hour) {
  late String sHour;
  late String h12State;
  final times = <String>[];
  if (hour < 10) {
    sHour = '0$hour';
    h12State = 'AM';
  } else if (hour > 9 && hour < 13) {
    sHour = '$hour';
    h12State = 'AM';
  } else if (hour > 12 && hour < 22) {
    sHour = '0${hour % 12}';
    h12State = 'PM';
  } else if (hour > 21) {
    sHour = '${hour % 12}';
    h12State = 'PM';
  }
  times.add(sHour);
  times.add(h12State);
  return times;
}

String mTOmm(int minute) {
  late String sMinute;
  if (minute < 10) {
    sMinute = '0$minute';
  } else {
    sMinute = '$minute';
  }
  return sMinute;
}

String showingRepeatWeekdays(BuildContext context, Reminder reminder) {
  if (reminder.weekdays1.isEmpty) {
    return Language.of(context)!.t("reminder_new2_setrepeat3");
  }
  if (reminder.weekdays1.length >= 7) {
    return Language.of(context)!.t("reminder_new2_setrepeat4");
  }
  List<String> weekdaysStr = [];
  for (var dNum in reminder.weekdays1) {
    weekdaysStr.add(fromWeekdayToString(context, dNum));
  }
  return weekdaysStr.join(", ");
}
