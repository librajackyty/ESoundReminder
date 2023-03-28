import 'dart:async';

import 'package:hive_flutter/hive_flutter.dart';

import '../models/reminder.dart';

class RemindersHiveLocalStorage {
  static const _kRemindersHiveBoxName = 'reminders';

  const RemindersHiveLocalStorage();

  Future<void> init() async {
    Hive.registerAdapter(ReminderAdapter());

    await Hive.initFlutter();
    await Hive.openBox(_kRemindersHiveBoxName);
  }

  Future<List<Reminder>> loadReminders() async {
    final box = Hive.box(_kRemindersHiveBoxName);

    final List<Reminder> reminders = box.values.toList().cast();

    return Future.value(reminders);
  }

  Future<Reminder> addReminder(Reminder reminder) async {
    final box = Hive.box(_kRemindersHiveBoxName);

    await box.put(reminder.id, reminder);

    return reminder;
  }

  Future<Reminder> updateReminder(Reminder reminder) async {
    final box = Hive.box(_kRemindersHiveBoxName);

    await box.put(reminder.id, reminder);

    return reminder;
  }

  Future<void> removeReminder(Reminder reminder) {
    final box = Hive.box(_kRemindersHiveBoxName);

    return box.delete(reminder.id);
  }

  Future<void> dispose() async {
    await Hive.close();
  }
}
