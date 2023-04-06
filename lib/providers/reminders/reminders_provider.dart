import 'package:e_sound_reminder_app/utils/formatter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart';

import '../../models/reminder.dart';
import '../../storage/reminders_hive.dart';
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
    reminders = List.from(reminders!);
    debugPrint("filter reminders length: ${reminders?.length}");
    debugPrint("${reminders.toString()}?");
    state = ReminderReLoaded(reminders!);
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

  int getReminderAlarmID(Reminder reminder, DateTime time) {
    return reminder.id + (time.day * time.minute);
  }

  Future<void> _removeScheduledReminder(Reminder reminder) async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    final List<PendingNotificationRequest> pendingNotificationRequests =
        await flutterLocalNotificationsPlugin.pendingNotificationRequests();
    if (reminder.weekdays1.isNotEmpty) {
      for (var notification in pendingNotificationRequests) {
        // get grouped id
        int getReminderAlarmIDTime1 =
            getReminderAlarmID(reminder, reminder.time1);
        if ((notification.id / 10).floor() == getReminderAlarmIDTime1) {
          debugPrint("grouped id MATCHED !!!");
          debugPrint("notification id = ${notification.id}");
          debugPrint("reminder.id = ${reminder.id}");
          debugPrint(
              "notification.id /10 floor =  ${(notification.id / 10).floor()}");
          debugPrint("getReminderAlarmIDTime1 = $getReminderAlarmIDTime1");
          await flutterLocalNotificationsPlugin.cancel(notification.id);
        }
      }
      if (reminder.reminderType > 1) {
        for (var i = 2; i <= reminder.reminderType; i++) {
          debugPrint("reminderType loop i = $i");
          DateTime? otherT;
          if (i == 2) {
            otherT = reminder.time2!;
          }
          if (i == 3) {
            otherT = reminder.time3!;
          }
          if (i == 4) {
            otherT = reminder.time4!;
          }
          if (otherT == null) return;
          debugPrint("reminderType time = ${otherT.toString()}");

          for (var notification in pendingNotificationRequests) {
            // get grouped id
            int getReminderAlarmIDTime = getReminderAlarmID(reminder, otherT);
            if ((notification.id / 10).floor() == getReminderAlarmIDTime) {
              debugPrint("grouped id MATCHED !!!");
              debugPrint("notification id = ${notification.id}");
              debugPrint("reminder.id = ${reminder.id}");
              debugPrint(
                  "notification.id /10 floor =  ${(notification.id / 10).floor()}");
              debugPrint("getReminderAlarmIDTime = $getReminderAlarmIDTime");
              await flutterLocalNotificationsPlugin.cancel(notification.id);
            }
          }
        }
      }
    } else {
      // await flutterLocalNotificationsPlugin.cancel(reminder.id);
      for (var i = 1; i <= reminder.reminderType; i++) {
        debugPrint("reminderType loop i = $i");
        DateTime otherT = reminder.time1;
        if (i == 2) {
          otherT = reminder.time2!;
        }
        if (i == 3) {
          otherT = reminder.time3!;
        }
        if (i == 4) {
          otherT = reminder.time4!;
        }
        debugPrint("reminderType time = ${otherT.toString()}");
        int getReminderAlarmIDTime = getReminderAlarmID(reminder, otherT);
        debugPrint("getReminderAlarmIDTime = $getReminderAlarmIDTime");
        await flutterLocalNotificationsPlugin.cancel(getReminderAlarmIDTime);
      }
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
    debugPrint(reminder.selectedMedicine.join(","));
    debugPrint(reminder.weekdays1.toString());
    debugPrint(reminder.time1.toString());
    debugPrint("reminder id ? ${reminder.id}");

    debugPrint("reminder set time1==============");
    zonedSchedule(flutterLocalNotificationsPlugin, platformChannelSpecifics,
        reminder, reminder.weekdays1, reminder.time1);

    if (reminder.reminderType >= 2) {
      debugPrint("reminder set time2==============");

      zonedSchedule(flutterLocalNotificationsPlugin, platformChannelSpecifics,
          reminder, reminder.weekdays1, reminder.time2!);
    }
    if (reminder.reminderType >= 3) {
      debugPrint("reminder set time3==============");
      zonedSchedule(flutterLocalNotificationsPlugin, platformChannelSpecifics,
          reminder, reminder.weekdays1, reminder.time3!);
    }
    if (reminder.reminderType == 4) {
      debugPrint("reminder set time4==============");
      zonedSchedule(flutterLocalNotificationsPlugin, platformChannelSpecifics,
          reminder, reminder.weekdays1, reminder.time4!);
    }
    // if (reminder.weekdays1.isEmpty) {
    //   debugPrint("set up LocalNotifications weekdays1.isEmpty");
    //   debugPrint("reminder id ? ${reminder.id}");
    //   await flutterLocalNotificationsPlugin.zonedSchedule(
    //     reminder.id,
    //     reminder.reminderTitle,
    //     reminder.reminderDescription,
    //     TZDateTime.local(
    //       reminder.time1.year,
    //       reminder.time1.month,
    //       reminder.time1.day,
    //       reminder.time1.hour,
    //       reminder.time1.minute,
    //     ),
    //     platformChannelSpecifics,
    //     androidAllowWhileIdle: true,
    //     uiLocalNotificationDateInterpretation:
    //         UILocalNotificationDateInterpretation.absoluteTime,
    //     matchDateTimeComponents: DateTimeComponents.time,
    //   );
    // } else {
    //   debugPrint("set up LocalNotifications weekdays1. not empty");
    //   debugPrint(reminder.weekdays1.join(","));
    //   for (var weekday in reminder.weekdays1) {
    //     await flutterLocalNotificationsPlugin.zonedSchedule(
    //       // acts as an id, for cancelling later
    //       reminder.id * 10 + weekday,
    //       reminder.reminderTitle,
    //       reminder.reminderDescription,
    //       TZDateTime.local(
    //         reminder.time1.year,
    //         reminder.time1.month,
    //         reminder.time1.day - reminder.time1.weekday + weekday,
    //         reminder.time1.hour,
    //         reminder.time1.minute,
    //       ),
    //       platformChannelSpecifics,
    //       androidAllowWhileIdle: true,
    //       uiLocalNotificationDateInterpretation:
    //           UILocalNotificationDateInterpretation.absoluteTime,
    //       matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
    //     );
    //   }
    // }
  }

  zonedSchedule(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      NotificationDetails platformChannelSpecifics,
      Reminder reminder,
      List<int> weekdays,
      DateTime time) async {
    debugPrint("reminder time ? ${time.toString()}");
    int id = getReminderAlarmID(reminder, time);
    String titleWthTime = '${fromTimeToString(time)} ${reminder.reminderTitle}';
    debugPrint("reminder gen time id ? $id");
    debugPrint("reminder gen time title with time ? $titleWthTime");
    if (weekdays.isEmpty) {
      debugPrint("set up LocalNotifications weekdays1.isEmpty");
      await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        titleWthTime,
        reminder.reminderDescription,
        TZDateTime.local(
          time.year,
          time.month,
          time.day,
          time.hour,
          time.minute,
        ),
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    } else {
      debugPrint("set up LocalNotifications weekdays1. not empty");
      debugPrint(weekdays.join(","));
      for (var weekday in weekdays) {
        await flutterLocalNotificationsPlugin.zonedSchedule(
          // acts as an id, for cancelling later
          id * 10 + weekday,
          titleWthTime,
          reminder.reminderDescription,
          TZDateTime.local(
            time.year,
            time.month,
            time.day - time.weekday + weekday,
            time.hour,
            time.minute,
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
