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

int fromStringToWeekday(BuildContext context, String weekdayStr) {
  if (Language.of(context)!.t("week_mon") == weekdayStr) {
    return 1;
  }
  if (Language.of(context)!.t("week_tue") == weekdayStr) {
    return 2;
  }
  if (Language.of(context)!.t("week_wed") == weekdayStr) {
    return 3;
  }
  if (Language.of(context)!.t("week_thu") == weekdayStr) {
    return 4;
  }
  if (Language.of(context)!.t("week_fri") == weekdayStr) {
    return 5;
  }
  if (Language.of(context)!.t("week_sat") == weekdayStr) {
    return 6;
  }
  if (Language.of(context)!.t("week_sun") == weekdayStr) {
    return 7;
  }
  return 0;
}

String fromTimeToString(DateTime time) {
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
