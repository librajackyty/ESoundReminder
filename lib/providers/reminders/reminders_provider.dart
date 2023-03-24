import 'package:flutter/foundation.dart';

import '../../models/reminder.dart';
import '../../storage/reminders_hive.dart';
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

    this.reminders = List.from(reminders);
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

    reminders = List.from(reminders!);

    loading = false;
    state = ReminderCreated(
      reminder,
      reminders!.indexOf(newReminder),
    );
    notifyListeners();

    // await _scheduleReminder(reminder);
  }

  Future<void> updateReminder(Reminder reminder, int index) async {
    loading = true;
    notifyListeners();

    final newReminder = await _storage.updateReminder(reminder);

    reminders![index] = newReminder;
    // reminders!.sort(reminderSort);
    reminders = List.from(reminders!);

    loading = false;
    state = ReminderUpdated(
      newReminder,
      reminder,
      index,
      reminders!.indexOf(newReminder),
    );
    notifyListeners();

    // await _removeScheduledReminder(reminder);
    // await _scheduleReminder(newReminder);
  }

  Future<void> deleteReminder(Reminder reminder, int index) async {
    loading = true;
    notifyListeners();

    await _storage.removeReminder(reminder);

    reminders!.removeAt(index);

    loading = false;
    state = ReminderDeleted(
      reminder,
      index,
    );
    notifyListeners();

    // await _removeScheduledReminder(reminder);
  }

  int reminderSort(reminder1, reminder2) =>
      reminder1.time1.compareTo(reminder2.time1);

  // Future<void> _removeScheduledReminder(Reminder reminder) async {
  //   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //       FlutterLocalNotificationsPlugin();

  //   final List<PendingNotificationRequest> pendingNotificationRequests =
  //       await flutterLocalNotificationsPlugin.pendingNotificationRequests();
  //   if (reminder.weekdays.isNotEmpty) {
  //     for (var notification in pendingNotificationRequests) {
  //       // get grouped id
  //       if ((notification.id / 10).floor() == reminder.id) {
  //         await flutterLocalNotificationsPlugin.cancel(notification.id);
  //       }
  //     }
  //   } else {
  //     await flutterLocalNotificationsPlugin.cancel(reminder.id);
  //   }
  // }

  // Future<void> _scheduleReminder(Reminder reminder) async {
  //   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //       FlutterLocalNotificationsPlugin();

  //   const AndroidNotificationDetails androidPlatformChannelSpecifics =
  //       AndroidNotificationDetails(
  //     'reminder',
  //     'Reminder',
  //     channelDescription: 'Show the reminder',
  //     importance: Importance.max,
  //     priority: Priority.high,
  //     sound: RawResourceAndroidNotificationSound('reminder'),
  //   );
  //   const IOSNotificationDetails iOSPlatformChannelSpecifics =
  //       IOSNotificationDetails(
  //     sound: 'reminder.aiff',
  //     presentSound: true,
  //     presentAlert: true,
  //     presentBadge: true,
  //   );
  //   const NotificationDetails platformChannelSpecifics = NotificationDetails(
  //     android: androidPlatformChannelSpecifics,
  //     iOS: iOSPlatformChannelSpecifics,
  //   );

  //   if (reminder.weekdays.isEmpty) {
  //     await flutterLocalNotificationsPlugin.zonedSchedule(
  //       reminder.id,
  //       'Reminder at ${fromTimeToString(reminder.time)}',
  //       'Ring Ring!!!',
  //       TZDateTime.local(
  //         reminder.time.year,
  //         reminder.time.month,
  //         reminder.time.day,
  //         reminder.time.hour,
  //         reminder.time.minute,
  //       ),
  //       platformChannelSpecifics,
  //       androidAllowWhileIdle: true,
  //       uiLocalNotificationDateInterpretation:
  //           UILocalNotificationDateInterpretation.absoluteTime,
  //       matchDateTimeComponents: DateTimeComponents.time,
  //     );
  //   } else {
  //     for (var weekday in reminder.weekdays) {
  //       await flutterLocalNotificationsPlugin.zonedSchedule(
  //         // acts as an id, for cancelling later
  //         reminder.id * 10 + weekday,
  //         'Reminder at ${fromTimeToString(reminder.time)}',
  //         'Ring Ring!!!',
  //         TZDateTime.local(
  //           reminder.time.year,
  //           reminder.time.month,
  //           reminder.time.day - reminder.time.weekday + weekday,
  //           reminder.time.hour,
  //           reminder.time.minute,
  //         ),
  //         platformChannelSpecifics,
  //         androidAllowWhileIdle: true,
  //         uiLocalNotificationDateInterpretation:
  //             UILocalNotificationDateInterpretation.absoluteTime,
  //         matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
  //       );
  //     }
  //   }
  // }

}
