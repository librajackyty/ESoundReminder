import 'dart:async';
import 'dart:io';

import 'package:e_sound_reminder_app/providers/reminders/reminders_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest_all.dart';
import 'package:timezone/timezone.dart';

import 'models/language.dart';
import 'models/reminder_screen_arg.dart';
import 'providers/app_language.dart';
import 'screens/about.dart';
import 'screens/home.dart';
import 'screens/intro.dart';
import 'screens/landing.dart';
import 'screens/lang_config.dart';
import 'screens/opensources.dart';
import 'screens/reminder_new.dart';
import 'screens/reminder_new_2.dart';
import 'screens/settings.dart';
import 'screens/reminder_detail.dart';
import 'storage/reminders_hive.dart';
import 'utils/constants.dart' as constants;

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

// @pragma('vm:entry-point')
// void notificationTapBackground(NotificationResponse notificationResponse) {
//   // ignore: avoid_print
//   print('notification(${notificationResponse.id}) action tapped: '
//       '${notificationResponse.actionId} with'
//       ' payload: ${notificationResponse.payload}');
//   if (notificationResponse.input?.isNotEmpty ?? false) {
//     // ignore: avoid_print
//     print(
//         'notification action tapped with input: ${notificationResponse.input}');
//   }
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppLanguage appLanguage = AppLanguage();
  await appLanguage.fetchLocale();
  runApp(MyApp(appLanguage: appLanguage));
}

class MyApp extends StatefulWidget {
  final AppLanguage appLanguage;
  MyApp({super.key, required this.appLanguage});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // final StreamController<ReceivedNotification>
  //     didReceiveLocalNotificationStream =
  //     StreamController<ReceivedNotification>.broadcast();

  // final StreamController<String?> selectNotificationStream =
  //     StreamController<String?>.broadcast();

  @override
  void initState() {
    setUpLocalNotification();
    requestNotificationPermissions();
    super.initState();
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
      }
    });
  }

  // void setUpLocalNotification() async {
  //   await _configureLocalTimeZone();
  //   const AndroidInitializationSettings initializationSettingsAndroid =
  //       AndroidInitializationSettings('app_icon');

  //   /// Note: permissions aren't requested here just to demonstrate that can be
  //   /// done later
  //   final List<DarwinNotificationCategory> darwinNotificationCategories =
  //       <DarwinNotificationCategory>[
  //     DarwinNotificationCategory(
  //       darwinNotificationCategoryText,
  //       actions: <DarwinNotificationAction>[
  //         DarwinNotificationAction.text(
  //           'text_1',
  //           'Action 1',
  //           buttonTitle: 'Send',
  //           placeholder: 'Placeholder',
  //         ),
  //       ],
  //     ),
  //     DarwinNotificationCategory(
  //       darwinNotificationCategoryPlain,
  //       actions: <DarwinNotificationAction>[
  //         DarwinNotificationAction.plain('id_1', 'Action 1'),
  //         DarwinNotificationAction.plain(
  //           'id_2',
  //           'Action 2 (destructive)',
  //           options: <DarwinNotificationActionOption>{
  //             DarwinNotificationActionOption.destructive,
  //           },
  //         ),
  //         DarwinNotificationAction.plain(
  //           navigationActionId,
  //           'Action 3 (foreground)',
  //           options: <DarwinNotificationActionOption>{
  //             DarwinNotificationActionOption.foreground,
  //           },
  //         ),
  //         DarwinNotificationAction.plain(
  //           'id_4',
  //           'Action 4 (auth required)',
  //           options: <DarwinNotificationActionOption>{
  //             DarwinNotificationActionOption.authenticationRequired,
  //           },
  //         ),
  //       ],
  //       options: <DarwinNotificationCategoryOption>{
  //         DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
  //       },
  //     )
  //   ];

  //   final DarwinInitializationSettings initializationSettingsDarwin =
  //       DarwinInitializationSettings(
  //     requestAlertPermission: false,
  //     requestBadgePermission: false,
  //     requestSoundPermission: false,
  //     onDidReceiveLocalNotification:
  //         (int id, String? title, String? body, String? payload) async {
  //       didReceiveLocalNotificationStream.add(
  //         ReceivedNotification(
  //           id: id,
  //           title: title,
  //           body: body,
  //           payload: payload,
  //         ),
  //       );
  //     },
  //     notificationCategories: darwinNotificationCategories,
  //   );

  //   final InitializationSettings initializationSettings =
  //       InitializationSettings(
  //     android: initializationSettingsAndroid,
  //     iOS: initializationSettingsDarwin,
  //   );
  //   await flutterLocalNotificationsPlugin.initialize(
  //     initializationSettings,
  //     onDidReceiveNotificationResponse:
  //         (NotificationResponse notificationResponse) {
  //       switch (notificationResponse.notificationResponseType) {
  //         case NotificationResponseType.selectedNotification:
  //           selectNotificationStream.add(notificationResponse.payload);
  //           break;
  //         case NotificationResponseType.selectedNotificationAction:
  //           if (notificationResponse.actionId == navigationActionId) {
  //             selectNotificationStream.add(notificationResponse.payload);
  //           }
  //           break;
  //       }
  //     },
  //     onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
  //   );
  // }

  Future<void> _configureLocalTimeZone() async {
    if (kIsWeb || Platform.isLinux) {
      return;
    }
    initializeTimeZones();
    final String? timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    setLocalLocation(getLocation(timeZoneName!));
  }

  @override
  void dispose() {
    // didReceiveLocalNotificationStream.close();
    // selectNotificationStream.close();
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    bool shouldUseMaterial3 = true;

    return MultiProvider(
        providers: [
          // ChangeNotifierProvider(create: (context) => ThemeModel()),
          // ChangeNotifierProvider(create: (context) => ClockTypeModel()),
          ChangeNotifierProvider(
            create: (context) => ReminderModel(
              const RemindersHiveLocalStorage(),
            ),
          ),
          ChangeNotifierProvider(
            create: (context) => widget.appLanguage,
          )
        ],
        child: Consumer<AppLanguage>(
          builder: (context, model, child) => MaterialApp(
            // title: 'E Daily Reminder',
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
            routes: {
              constants.pageRouteHome: (context) =>
                  const HomePage(title: 'Home'),
              constants.pageRouteLangConfig: (context) =>
                  const LangConfigPage(title: 'Language'),
              constants.pageRouteIntro: (context) =>
                  const IntroPage(title: 'Introduction'),
              constants.pageRouteLanding: (context) =>
                  const LandingPage(title: 'Landing'),
              constants.pageRouteSettings: (context) =>
                  const SettingsPage(title: 'Settings'),
              // constants.pageRouteReminderDetail: (context) =>
              //     const ReminderDetailPage(title: 'Reminder Detail'),
              // constants.pageRouteReminderNew: (context) =>
              //     const ReminderNewPage(title: 'New Reminder'),
              // constants.pageRouteReminderNew2: (context) =>
              //     const ReminderNewPage2(title: 'New Reminder 2'),
              constants.pageRouteAbout: (context) =>
                  const AboutPage(title: 'About'),
              constants.pageRouteOpenSources: (context) =>
                  const OpenSourcesPage(title: 'Open Sources Software (OSS)'),
            },
            onGenerateRoute: (settings) {
              switch (settings.name) {
                // case '/':
                //   return MaterialPageRoute(
                //     builder: (context) => const HomeScreen(),
                //   );
                case constants.pageRouteReminderNew:
                  return MaterialPageRoute(
                    builder: (context) => ReminderNewPage(
                      title: 'New Reminder',
                      arg: settings.arguments as ReminderScreenArg?,
                    ),
                  );
                case constants.pageRouteReminderNew2:
                  return MaterialPageRoute(
                    builder: (context) => ReminderNewPage2(
                      title: 'New Reminder 2',
                      arg: settings.arguments as ReminderScreenArg?,
                    ),
                  );
                case constants.pageRouteReminderDetail:
                  return MaterialPageRoute(
                    builder: (context) => ReminderDetailPage(
                      title: constants.pageNameReminderDetail,
                      arg: settings.arguments as ReminderScreenArg?,
                    ),
                  );
                case constants.pageRouteReminderDetailMore:
                  return MaterialPageRoute(
                    builder: (context) => ReminderDetailPage(
                      title: constants.pageNameReminderDetailMore,
                      arg: settings.arguments as ReminderScreenArg?,
                    ),
                  );
              }
              return null;
            },
          ),
        ));
  }
}
