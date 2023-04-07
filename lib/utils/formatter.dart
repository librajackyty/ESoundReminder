import 'package:flutter/foundation.dart';
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

bool checkReminderTimesAreSameDay(Reminder reminder) {
  if (reminder.reminderType == 1) return true;
  switch (reminder.reminderType) {
    case 2:
      return reminder.time1.day == reminder.time2!.day;
    case 3:
      return reminder.time1.day == reminder.time2!.day &&
          reminder.time1.day == reminder.time3!.day;
    case 4:
      return reminder.time1.day == reminder.time2!.day &&
          reminder.time1.day == reminder.time3!.day &&
          reminder.time1.day == reminder.time4!.day;
  }
  return false;
}

bool checkOneOfTimeIsExpired(List<bool> expireds) {
  List<bool> timesAreNotExpired = List.filled(expireds.length, false);
  return !listEquals(timesAreNotExpired, expireds);
}

bool checkReminderAllTimeAreExpired(List<bool> expireds) {
  List<bool> timesAreExpired = List.filled(expireds.length, true);
  return listEquals(timesAreExpired, expireds);
}

List<bool> getReminderAllTimeExpired(Reminder reminder) {
  List<bool> timesExpireds = List.filled(reminder.reminderType, false);
  for (var i = 0; i < reminder.reminderType; i++) {
    switch (i) {
      case 0:
        timesExpireds[0] =
            reminder.weekdays1.isEmpty && !isTimeAfterNow(reminder.time1);
        break;
      case 1:
        timesExpireds[1] =
            reminder.weekdays1.isEmpty && !isTimeAfterNow(reminder.time2!);
        break;
      case 2:
        timesExpireds[2] =
            reminder.weekdays1.isEmpty && !isTimeAfterNow(reminder.time3!);
        break;
      case 3:
        timesExpireds[3] =
            reminder.weekdays1.isEmpty && !isTimeAfterNow(reminder.time4!);
        break;
    }
  }
  //debugPrint("getReminderAllTimeExpired: $timesExpireds");
  return timesExpireds;
}

bool checkReminderTime1IsExpired(Reminder reminder) {
  return reminder.weekdays1.isEmpty && !isTimeAfterNow(reminder.time1);
}

bool isTimeAfterNow(DateTime time) {
  final currentT = DateTime.now();
  //debugPrint("currentT: ${currentT.toString()}");
  return time.isAfter(currentT);
}

DateTime convertSelectTime(DateTime dateTime) {
  if (!isTimeAfterNow(dateTime)) {
    return dateTime.add(const Duration(days: 1));
  }
  return dateTime;
}

String fromTimeToDateLongString(Reminder reminder, {List<String>? dateTxts}) {
  DateTime time = reminder.time1;
  if (checkReminderTimesAreSameDay(reminder)) {
    if (dateTxts != null) {
      if (checkReminderAllTimeAreExpired(getReminderAllTimeExpired(reminder)) &&
          dateTxts.length >= 3) {
        return '${fromTimeToDateString(time)} ${dateTxts[2]}';
      } else {
        final currentT = DateTime.now();
        if (currentT.day == time.day) {
          // tdy
          return '${fromTimeToDateString(time)} ${dateTxts[0]}';
        } else if (time.day > currentT.day) {
          // tmr
          return '${fromTimeToDateString(time)} ${dateTxts[1]}';
        }
      }
    }
  } else {
    if (checkReminderAllTimeAreExpired(getReminderAllTimeExpired(reminder))) {
      if (dateTxts != null && dateTxts.length >= 3) {
        return '${fromTimeToDateString(time)}\n${dateTxts[2]}';
      }
    }
  }
  return fromTimeToDateString(time);
}

String fromTimeToDateString(DateTime time) {
  return '${time.year}/${time.month}/${time.day}';
}

String fromSameDayTimeToString(
  DateTime time, {
  List<String>? dateTxts,
}) {
  String timeStr = '${hTOhh_24hTrue(time.hour)}:${mTOmm(time.minute)}';
  if (dateTxts != null && dateTxts.isNotEmpty) {
    if (!isTimeAfterNow(time) && dateTxts.length >= 3) {
      return '$timeStr ${dateTxts[2]}';
    }
  }
  return timeStr;
}

String fromTimeToString(DateTime time,
    {List? weekdays, List<String>? dateTxts, bool longFormat = false}) {
  String timeStr = '${hTOhh_24hTrue(time.hour)}:${mTOmm(time.minute)}';
  if (weekdays != null) {
    if (weekdays.isEmpty) {
      if (dateTxts != null && dateTxts.isNotEmpty) {
        return _showTimeWthdateTxt(time, timeStr, dateTxts, longFormat);
      }
      return '${fromTimeToDateString(time)}\n$timeStr';
    }
  }
  return timeStr;
}

String _showTimeWthdateTxt(
    DateTime time, String timeStr, List<String> dateTxts, bool longFormat) {
  final currentT = DateTime.now();

  if (longFormat) {
    if (isTimeAfterNow(time)) {
      if (currentT.day == time.day) {
        // tdy
        return '${fromTimeToDateString(time)}\n${dateTxts[0]} $timeStr';
      }
      // tmr
      return '${fromTimeToDateString(time)}\n${dateTxts[1]} $timeStr';
    } else {
      // expired
      if (dateTxts.length >= 3) {
        return '${fromTimeToDateString(time)}\n$timeStr ${dateTxts[2]}';
      }
      return '${fromTimeToDateString(time)} $timeStr';
    }
  } else {
    if (isTimeAfterNow(time)) {
      if (currentT.day == time.day) {
        // tdy
        return '${dateTxts[0]} $timeStr';
      }
      // tmr
      return '${dateTxts[1]} $timeStr';
    } else {
      // expired
      if (dateTxts.length >= 3) {
        return '$timeStr ${dateTxts[2]}';
      }
      return timeStr;
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
