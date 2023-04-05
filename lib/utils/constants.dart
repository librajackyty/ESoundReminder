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
const String pageRouteDisplayConfig = "/displayConfig";

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
// const double selectWeekDaysFontSize = 20.0;
const double selectWeekDaysBorderRadius = 30.0;
const double selectWeekDaysPadding = 10.0;
const int progressBarDelayShowTime = 500;
const int askExpiredDelShowTime = 1200;

const int pageHeaderDelayShowTime = 100;
const int pageContentDelayShowTime = 400;
const int pageBottomDelayShowTime = 500;

double _textTitleSize = 36;
double _textNormalSize = 30;
double _textSmallSize = 22;
double _textExSmallSize = 20;
double _textBtnSize = 28;
double _textBtnSmallSize = 20;

set appTextTitleSize(double size) => _textTitleSize = size;
set appTextNormalSize(double size) => _textNormalSize = size;
set appTextSmallSize(double size) => _textSmallSize = size;
set appTextExSmallSize(double size) => _textExSmallSize = size;
set appTextBtnSize(double size) => _textBtnSize = size;
set appTextBtnSmallSize(double size) => _textBtnSmallSize = size;

double get textTitleSize => _textTitleSize;
double get textNormalSize => _textNormalSize;
double get textSmallSize => _textSmallSize;
double get textExSmallSize => _textExSmallSize;
double get textBtnSize => _textBtnSize;
double get textBtnSmallSize => _textBtnSmallSize;

const double textLTitleSize = 36;
const double textLNormalSize = 30;
const double textLSmallSize = 22;
const double textLExSmallSize = 20;
const double textLBtnSize = 28;
const double textLBtnSmallSize = 20;

const double textMTitleSize = 34;
const double textMNormalSize = 28;
const double textMSmallSize = 20;
const double textMExSmallSize = 18;
const double textMBtnSize = 26;
const double textMBtnSmallSize = 18;

const double textSTitleSize = 30;
const double textSNormalSize = 24;
const double textSSmallSize = 16;
const double textSExSmallSize = 14;
const double textSBtnSize = 22;
const double textSBtnSmallSize = 14;

final Color elementActiveColor = Colors.green[900]!;
const Color elementNotActiveColor = Colors.white;
const Color elementActiveTxtColor = Colors.white;
const Color elementNotActiveTxtColor = Colors.black;
final Color scrollBarColor = Colors.green.shade500;
final Color errorColor = Colors.red[900]!;

// button ui
const double buttonBorderWidth = 2;
const double buttonBorderWidthReadOnly = 1;
const double buttonHeight = 60;
const double buttonWidthSmall = 100;
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
