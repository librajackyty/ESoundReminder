import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:e_sound_reminder_app/models/reminder.dart';
import 'package:e_sound_reminder_app/providers/reminders/reminders_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest_all.dart';
import 'package:timezone/timezone.dart';

import 'models/language.dart';
import 'models/reminder_screen_arg.dart';
import 'providers/app_language.dart';
import 'providers/displayer_provider.dart';
import 'screens/about.dart';
import 'screens/display_config.dart';
import 'screens/home.dart';
import 'screens/intro.dart';
import 'screens/landing.dart';
import 'screens/lang_config.dart';
import 'screens/opensources.dart';
import 'screens/other_config.dart';
import 'screens/reminder_new.dart';
import 'screens/reminder_new_2.dart';
import 'screens/settings.dart';
import 'screens/reminder_detail.dart';
import 'storage/reminders_hive.dart';
import 'utils/constants.dart' as constants;
import 'utils/constants.dart';

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}

String? selectedNotificationPayload;

/// A notification action which triggers a url launch event
const String urlLaunchActionId = 'id_1';

/// A notification action which triggers a App navigation event
const String navigationActionId = 'id_3';

/// Defines a iOS/MacOS notification category for text input actions.
const String darwinNotificationCategoryText = 'textCategory';

/// Defines a iOS/MacOS notification category for plain actions.
const String darwinNotificationCategoryPlain = 'plainCategory';

var successGetDefaultLang = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppLanguage appLanguage = AppLanguage();
  successGetDefaultLang = await appLanguage.fetchLocale();
  debugPrint("Main main - successGetDefaultLang: $successGetDefaultLang");
  DisplayerProvider dp = DisplayerProvider();
  await dp.fetchAppTextSize();
  await dp.fetchTimepickerStyle();
  await dp.fetchTutorialSetting();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) => runApp(MyApp(
      appLanguage: appLanguage,
      displayerProvider: dp,
    )),
  );
}

class MyApp extends StatefulWidget {
  final AppLanguage appLanguage;
  final DisplayerProvider displayerProvider;
  MyApp(
      {super.key, required this.appLanguage, required this.displayerProvider});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final NavigationService _navigationService = NavigationService();

  @override
  void initState() {
    setUpLocalNotification();
    requestNotificationPermissions();
    super.initState();
    handleNotificationPayload();
  }

  void requestNotificationPermissions() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  void setUpLocalNotification() async {
    await _configureLocalTimeZone();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('mipmap/localnotification_icon');

    /// Note: permissions aren't requested here just to demonstrate that can be
    /// done later
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestSoundPermission: true,
            onDidReceiveLocalNotification: (
              int id,
              String? title,
              String? body,
              String? payload,
            ) async {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(title ?? ''),
                  content: Text(body ?? ''),
                ),
              );
            });

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        debugPrint('notification payload: $payload');
        var json = jsonDecode(payload);
        Reminder alarmedReminder = Reminder.fromJson(json);
        _navigationService.pushNamedAndRemoveUntil(pageRouteHome,
            args: ReminderScreenArg(alarmedReminder, index: 0));
      }
    });
  }

  Future<void> _configureLocalTimeZone() async {
    if (kIsWeb || Platform.isLinux) {
      return;
    }
    initializeTimeZones();
    final String? timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    setLocalLocation(getLocation(timeZoneName!));
  }

  Future<void> handleNotificationPayload() async {
    var details =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      var payload = details.payload;
      debugPrint(
          'getNotificationAppLaunchDetails didNotificationLaunchApp payload: $payload');
      if (payload != null) {
        debugPrint('notification payload: $payload');
        var json = jsonDecode(payload);
        Reminder alarmedReminder = Reminder.fromJson(json);

        Future.delayed(const Duration(milliseconds: 800), () {
          debugPrint("_navigationService opening new Home");
          _navigationService.pushNamedAndRemoveUntil(pageRouteHome,
              args: ReminderScreenArg(alarmedReminder, index: 0));
        });
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    bool shouldUseMaterial3 = true;

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => ReminderModel(
              const RemindersHiveLocalStorage(),
            ),
          ),
          ChangeNotifierProvider(
            create: (context) => widget.appLanguage,
          ),
          ChangeNotifierProvider(
            create: (context) => widget.displayerProvider,
          ),
        ],
        child: Consumer<AppLanguage>(
          builder: (context, model, child) => MaterialApp(
            // title: 'E Daily Reminder',
            navigatorKey: NavigationService.navigationKey,
            locale: model.appLocal,
            supportedLocales: [
              const Locale(Language.codeEnglish, 'US'),
              const Locale(Language.codeTCantonese),
              const Locale(Language.codeSChinese),
            ],
            localizationsDelegates: [
              Language.delegate,
              Language.fallbackMDelegate,
              Language.fallbackCDelegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            darkTheme: ThemeData.dark(useMaterial3: shouldUseMaterial3),
            theme: ThemeData(
              useMaterial3: shouldUseMaterial3,
              // primarySwatch: Colors.green,
              colorSchemeSeed: Colors.green,
            ),
            themeMode: ThemeMode.light,
            debugShowCheckedModeBanner: false,
            builder: (context, child) {
              final MediaQueryData data = MediaQuery.of(context);
              return MediaQuery(
                data: data.copyWith(textScaleFactor: 1.0),
                child: child!,
              );
            },
            initialRoute: !successGetDefaultLang
                ? constants.pageRouteLangConfigFirst
                : constants.pageRouteLanding,
            routes: {
              constants.pageRouteIntro: (context) =>
                  const IntroPage(title: 'Introduction'),
            },
            onGenerateRoute: (settings) {
              switch (settings.name) {
                case constants.pageRouteLanding:
                  return PageTransition(
                      child: const LandingPage(title: 'Landing'),
                      type: PageTransitionType.fade);
                case constants.pageRouteHome:
                  return PageTransition(
                      child: HomePage(
                        title: 'Home',
                        arg: settings.arguments as ReminderScreenArg?,
                      ),
                      type: PageTransitionType.fade);
                case constants.pageRouteSettings:
                  return PageTransition(
                      child: const SettingsPage(title: 'Settings'),
                      type: PageTransitionType.rightToLeft);
                case constants.pageRouteLangConfigFirst:
                  return PageTransition(
                      child: const LangConfigPage(
                        title: 'Language',
                        isFromSettings: false,
                      ),
                      type: PageTransitionType.fade);
                case constants.pageRouteLangConfig:
                  return PageTransition(
                      child: const LangConfigPage(
                          title: 'Language', isFromSettings: true),
                      type: PageTransitionType.rightToLeft);
                case constants.pageRouteAbout:
                  return PageTransition(
                      child: const AboutPage(title: 'About'),
                      type: PageTransitionType.rightToLeft);
                case constants.pageRouteOpenSources:
                  return PageTransition(
                      child: const OpenSourcesPage(
                          title: 'Open Sources Software (OSS)'),
                      type: PageTransitionType.rightToLeft);
                case constants.pageRouteDisplayConfig:
                  return PageTransition(
                      child: const DisplayConfigPage(title: 'Display Config'),
                      type: PageTransitionType.rightToLeft);
                case constants.pageRouteOtherConfig:
                  return PageTransition(
                      child: const OtherConfigPage(title: 'Other Config'),
                      type: PageTransitionType.rightToLeft);

                case constants.pageRouteReminderNew:
                  return PageTransition(
                      child: ReminderNewPage(
                        title: 'New Reminder',
                        arg: settings.arguments as ReminderScreenArg?,
                      ),
                      duration: const Duration(milliseconds: 300),
                      type: PageTransitionType.bottomToTop);
                case constants.pageRouteReminderNew2:
                  return PageTransition(
                      child: ReminderNewPage2(
                        title: 'New Reminder 2',
                        arg: settings.arguments as ReminderScreenArg?,
                      ),
                      type: PageTransitionType.rightToLeft,
                      isIos: false);
                case constants.pageRouteReminderDetail:
                  return PageTransition(
                      child: ReminderDetailPage(
                        title: constants.pageNameReminderDetail,
                        arg: settings.arguments as ReminderScreenArg?,
                      ),
                      type: PageTransitionType.rightToLeft,
                      isIos: false);
                case constants.pageRouteReminderDetailMore:
                  return PageTransition(
                      child: ReminderDetailPage(
                        title: constants.pageNameReminderDetailMore,
                        arg: settings.arguments as ReminderScreenArg?,
                      ),
                      type: PageTransitionType.bottomToTop);
              }
              return null;
            },
          ),
        ));
  }
}
