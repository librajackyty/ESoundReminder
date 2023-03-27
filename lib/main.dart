import 'package:e_sound_reminder_app/providers/reminders/reminders_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppLanguage appLanguage = AppLanguage();
  await appLanguage.fetchLocale();
  runApp(MyApp(appLanguage: appLanguage));
}

class MyApp extends StatelessWidget {
  final AppLanguage appLanguage;
  MyApp({super.key, required this.appLanguage});

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
            create: (context) => appLanguage,
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
