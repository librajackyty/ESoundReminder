import 'package:flutter/material.dart';

const String pageRouteHome = "/home";
const String pageRouteLangConfigFirst = "/langConfigfirst";
const String pageRouteLangConfig = "/langConfig";
const String pageRouteIntro = "/intro";
const String pageRouteLanding = "/landing";
const String pageRouteSettings = "/settings";
const String pageRouteReminderDetail = "/reminderdetail";
const String pageRouteReminderDetailMore = "/reminderdetailmore";
const String pageRouteReminderNew = "/remindernew";
const String pageRouteReminderNew2 = "/remindernew2";
const String pageRouteOpenSources = "/opensources";
const String pageRouteAbout = "/about";

const String pageNameReminderDetailMore = "More Reminder Detail";
const String pageNameReminderDetail = "New Reminder Detail";

const String langLangCodeKey = "language_code";
const String langCountryCodeKey = "countryCode";

const double safeAreaPaddingAll = 20.0;
const double safeAreaPaddingAllWthLv = 2.0;

const double elementSSSPadding = 2.0;
const double elementSSPadding = 4.0;
const double elementSPadding = 8.0;
const double elementMPadding = 12.0;
const double elementLPadding = 16.0;
const double elementXLPadding = 20.0;

const double reminderCardHeightRatio = 0.25;
const double reminderCardBottomMargin = 16.0;
const double cardsBorderRadius = 20.0;
const double cardsElevation = 6.0;
const double listviewPaddingAll = 18.0;
const double selectWeekDaysFontSize = 20.0;
const double selectWeekDaysBorderRadius = 30.0;
const double selectWeekDaysPadding = 10.0;

const double textTitleSize = 36;
const double textNormalSize = 30;
const double textSmallSize = 22;
const double textBtnSize = 28;
const double textBtnSmallSize = 20;

final Color elementActiveColor = Colors.green[900]!;
const Color elementNotActiveColor = Colors.white;
const Color elementActiveTxtColor = Colors.white;
const Color elementNotActiveTxtColor = Colors.black;

// button ui
const double buttonBorderWidth = 2;
const double buttonBorderWidthReadOnly = 1;
const double buttonHeight = 60;
const double buttonHeightSmall = 40;
final Color buttonBorderColor = Colors.green[900]!;
final Color buttonBorderColor2 = Colors.red[900]!;
const Color buttonForegroundColor = Colors.green;
const Color buttonForegroundColor2 = Colors.red;
const Color buttonReadOnlyColor = Colors.white;
const Color buttonReadOnlyForegroundColor = Colors.black;

// card ui
final Color cardBorderColor = Colors.green[900]!;

final List filterIconData = [
  Icons.calendar_month,
  Icons.date_range,
  Icons.event_busy,
  Icons.today,
  Icons.today,
  Icons.today,
  Icons.today,
  Icons.today,
  Icons.today,
  Icons.today
];

final List filterKeys = [
  "filter_all",
  "filter_repeat_all",
  "filter_repeat_no",
  "filter_repeat_mon",
  "filter_repeat_tue",
  "filter_repeat_wed",
  "filter_repeat_thu",
  "filter_repeat_fri",
  "filter_repeat_sat",
  "filter_repeat_sun"
];
