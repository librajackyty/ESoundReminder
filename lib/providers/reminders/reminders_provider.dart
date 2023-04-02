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
  List<Reminder>? remindersIntial;
  bool loading = true;
  int currentFilterIdx = 0;

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
    reminders.sort(reminderSort);
    this.reminders = List.from(reminders);
    remindersIntial = List.from(this.reminders!);
    state = ReminderLoaded(remindersIntial!);
    loading = false;
    notifyListeners();
  }

  void listFiltering(int index) {
    switch (index) {
      case 0:
        reminders = List.from(remindersIntial!);
        break;
      case 1: // only show repeat everyday
        reminders =
            remindersIntial?.where((i) => i.weekdays1.length == 7).toList();
        break;
      case 2: // only show no repeat
        reminders = remindersIntial?.where((i) => i.weekdays1.isEmpty).toList();
        break;
      case 3: // only show has Mon
        reminders = remindersIntial
            ?.where((i) => i.weekdays1.length < 7 && i.weekdays1.contains(1))
            .toList();
        break;
      case 4: // only show has Tue
        reminders = remindersIntial
            ?.where((i) => i.weekdays1.length < 7 && i.weekdays1.contains(2))
            .toList();
        break;
      case 5: // only show has Wed
        reminders = remindersIntial
            ?.where((i) => i.weekdays1.length < 7 && i.weekdays1.contains(3))
            .toList();
        break;
      case 6: // only show has Thu
        reminders = remindersIntial
            ?.where((i) => i.weekdays1.length < 7 && i.weekdays1.contains(4))
            .toList();
        break;
      case 7: // only show has Fri
        reminders = remindersIntial
            ?.where((i) => i.weekdays1.length < 7 && i.weekdays1.contains(5))
            .toList();
        break;
      case 8: // only show has Sat
        reminders = remindersIntial
            ?.where((i) => i.weekdays1.length < 7 && i.weekdays1.contains(6))
            .toList();
        break;
      case 9: // only show has Sun
        reminders = remindersIntial
            ?.where((i) => i.weekdays1.length < 7 && i.weekdays1.contains(7))
            .toList();
        break;
      default:
    }
  }

  void filterReminder(int index) {
    if (remindersIntial!.isEmpty) {
      return;
    }
    loading = true;
    currentFilterIdx = index;
    listFiltering(currentFilterIdx);
    reminders!.sort(reminderSort);
    debugPrint("filter reminders length: ${reminders?.length}");
    // debugPrint("$reminders?");
    state = ReminderLoaded(reminders!);
    loading = false;
    notifyListeners();
  }

  Future<void> addReminder(Reminder reminder) async {
    loading = true;
    notifyListeners();

    final newReminder = await _storage.addReminder(reminder);
    listFiltering(0);
    debugPrint("addReminder reminders length: ${reminders?.length}");
    reminders!.add(newReminder);
    reminders!.sort(reminderSort);

    reminders = List.from(reminders!);
    remindersIntial = List.from(reminders!);

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
    listFiltering(0);
    debugPrint("updateReminder reminders length: ${reminders?.length}");
    reminders![reminders!.indexOf(reminder)] = newReminder;
    reminders!.sort(reminderSort);
    reminders = List.from(reminders!);
    remindersIntial = List.from(reminders!);

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
    listFiltering(0);
    reminders!.removeAt(reminders!.indexOf(reminder));
    reminders = List.from(reminders!);
    remindersIntial = List.from(reminders!);

    loading = false;
    state = ReminderDeleted(
      reminder,
      index,
    );
    notifyListeners();

    await _removeScheduledReminder(reminder);
  }

  int reminderSort(Reminder reminder1, Reminder reminder2) =>
      reminder2.createTime.compareTo(reminder1.createTime);

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
    const int insistentFlag = 4;

    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('edailyreminder1', 'Reminder1',
            channelDescription: 'Reminder for taking medicine',
            importance: Importance.max,
            priority: Priority.high,
            additionalFlags: Int32List.fromList(<int>[insistentFlag]),
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
    NotificationDetails platformChannelSpecifics = NotificationDetails(
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
