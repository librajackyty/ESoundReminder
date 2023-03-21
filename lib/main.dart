import 'package:flutter/material.dart';

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
import 'utils/constants.dart' as constants;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    bool shouldUseMaterial3 = true;

    return MaterialApp(
      title: 'E Daily Reminder',
      darkTheme: ThemeData.dark(useMaterial3: shouldUseMaterial3),
      theme: ThemeData(
        useMaterial3: shouldUseMaterial3,
        primarySwatch: Colors.green,
      ),
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      routes: {
        constants.pageRouteHome: (context) => const HomePage(title: 'Home'),
        constants.pageRouteLangConfig: (context) =>
            const LangConfigPage(title: 'Language'),
        constants.pageRouteIntro: (context) =>
            const IntroPage(title: 'Introduction'),
        constants.pageRouteLanding: (context) =>
            const LandingPage(title: 'Landing'),
        constants.pageRouteSettings: (context) =>
            const SettingsPage(title: 'Settings'),
        constants.pageRouteReminderDetail: (context) =>
            const ReminderDetailPage(title: 'Reminder Detail'),
        constants.pageRouteReminderNew: (context) =>
            const ReminderNewPage(title: 'New Reminder'),
        constants.pageRouteReminderNew2: (context) =>
            const ReminderNewPage2(title: 'New Reminder 2'),
        constants.pageRouteAbout: (context) => const AboutPage(title: 'About'),
        constants.pageRouteOpenSources: (context) =>
            const OpenSourcesPage(title: 'Open Sources Software (OSS)'),
      },
    );
  }
}
