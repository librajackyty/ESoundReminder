import 'package:e_sound_reminder_app/models/language.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart';

import '../../models/reminder.dart';
import '../../storage/reminders_hive.dart';
import '../../utils/formatter.dart';
import 'reminders_state.dart';

class ReminderModel extends ChangeNotifier {
  final RemindersHiveLocalStorage _storage;

  ReminderState? state;
  List<Reminder>? reminders;
  bool loading = true;

  ReminderModel(RemindersHiveLocalStorage storage) : _storage = storage {
    _storage.init().then((_) => loadReminders());
  }

  @override
  void dispose() {
    _storage.dispose();
    super.dispose();
  }

  void loadReminders() async {
    final reminders = await _storage.loadReminders();

    this.reminders = List.from(reminders.reversed);
    state = ReminderLoaded(reminders);
    loading = false;
    notifyListeners();
  }

  Future<void> addReminder(Reminder reminder) async {
    loading = true;
    notifyListeners();

    final newReminder = await _storage.addReminder(reminder);
    reminders!.add(newReminder);
    // reminders!.sort(reminderSort);

    reminders = List.from(reminders!.reversed);

    loading = false;
    state = ReminderCreated(
      reminder,
      reminders!.indexOf(newReminder),
    );
    notifyListeners();

    await _scheduleReminder(reminder);
  }

  Future<void> updateReminder(Reminder reminder, int index) async {
    loading = true;
    notifyListeners();

    final newReminder = await _storage.updateReminder(reminder);

    reminders![index] = newReminder;
    // reminders!.sort(reminderSort);
    reminders = List.from(reminders!.reversed);

    loading = false;
    state = ReminderUpdated(
      newReminder,
      reminder,
      index,
      reminders!.indexOf(newReminder),
    );
    notifyListeners();

    await _removeScheduledReminder(reminder);
    await _scheduleReminder(newReminder);
  }

  Future<void> deleteReminder(Reminder reminder, int index) async {
    loading = true;
    notifyListeners();
    debugPrint(
        "deleteReminder: ${reminder.id}) ${reminder.reminderTitle} ${reminder.reminderDescription}");

    await _storage.removeReminder(reminder);

    reminders!.removeAt(index);

    loading = false;
    state = ReminderDeleted(
      reminder,
      index,
    );
    notifyListeners();

    await _removeScheduledReminder(reminder);
  }

  int reminderSort(reminder1, reminder2) =>
      reminder1.time1.compareTo(reminder2.time1);

  Future<void> _removeScheduledReminder(Reminder reminder) async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    final List<PendingNotificationRequest> pendingNotificationRequests =
        await flutterLocalNotificationsPlugin.pendingNotificationRequests();
    if (reminder.weekdays1.isNotEmpty) {
      for (var notification in pendingNotificationRequests) {
        // get grouped id
        if ((notification.id / 10).floor() == reminder.id) {
          await flutterLocalNotificationsPlugin.cancel(notification.id);
        }
      }
    } else {
      await flutterLocalNotificationsPlugin.cancel(reminder.id);
    }
  }

  Future<void> _scheduleReminder(Reminder reminder) async {
    debugPrint("_scheduleReminder async");
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    // const String filePath = 'drawable/localnotification_icon.png';
    // const BigPictureStyleInformation bigPictureStyleInformation =
    //     BigPictureStyleInformation(FilePathAndroidBitmap(filePath),
    //         largeIcon: FilePathAndroidBitmap(filePath),
    //         contentTitle: 'overridden <b>big</b> content title',
    //         htmlFormatContentTitle: true,
    //         summaryText: 'summary <i>text</i>',
    //         htmlFormatSummaryText: true);

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('edailyreminder1', 'Reminder1',
            channelDescription: 'Reminder for taking medicine',
            importance: Importance.max,
            priority: Priority.high,
            playSound: true,
            sound: RawResourceAndroidNotificationSound('reminder_urgent1'),
            largeIcon: DrawableResourceAndroidBitmap('localnotification_icon'));
    // styleInformation: bigPictureStyleInformation);
    const IOSNotificationDetails iOSPlatformChannelSpecifics =
        IOSNotificationDetails(
      sound: 'reminder_urgent1.wav',
      presentSound: true,
      presentAlert: true,
      presentBadge: true,
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
    debugPrint("set up reminder:");
    debugPrint(reminder.reminderTitle);
    debugPrint(reminder.reminderDescription);
    debugPrint(reminder.time1.toString());
    debugPrint(reminder.selectedMedicine.join(","));
    if (reminder.weekdays1.isEmpty) {
      debugPrint("set up LocalNotifications weekdays1.isEmpty");
      debugPrint("reminder id ? ${reminder.id}");
      await flutterLocalNotificationsPlugin.zonedSchedule(
        reminder.id,
        reminder.reminderTitle,
        reminder.reminderDescription,
        TZDateTime.local(
          reminder.time1.year,
          reminder.time1.month,
          reminder.time1.day,
          reminder.time1.hour,
          reminder.time1.minute,
        ),
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    } else {
      debugPrint("set up LocalNotifications weekdays1. not empty");
      debugPrint(reminder.weekdays1.join(","));
      for (var weekday in reminder.weekdays1) {
        await flutterLocalNotificationsPlugin.zonedSchedule(
          // acts as an id, for cancelling later
          reminder.id * 10 + weekday,
          reminder.reminderTitle,
          reminder.reminderDescription,
          TZDateTime.local(
            reminder.time1.year,
            reminder.time1.month,
            reminder.time1.day - reminder.time1.weekday + weekday,
            reminder.time1.hour,
            reminder.time1.minute,
          ),
          platformChannelSpecifics,
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
        );
      }
    }
  }
}
