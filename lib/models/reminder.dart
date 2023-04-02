import 'dart:math';

import 'package:hive/hive.dart';

part 'reminder.g.dart';

@HiveType(typeId: 0)
class Reminder {
  @HiveField(0)
  late final int id;
  @HiveField(1)
  final DateTime time1;
  @HiveField(2)
  final List<int> weekdays1;
  @HiveField(3)
  final int reminderType = 0;
  @HiveField(4)
  final String reminderTitle;
  @HiveField(5)
  String? reminderDescription;
  @HiveField(6)
  String? reminderNotes;
  @HiveField(7)
  final List selectedMedicine;
  @HiveField(8)
  late final DateTime createTime;

  Reminder(
      {int? id,
      required this.time1,
      required this.weekdays1,
      required this.reminderTitle,
      required this.selectedMedicine,
      this.reminderDescription,
      DateTime? createTime}) {
    this.id = id ?? Random.secure().nextInt(10000 - 1000) + 1000;
    this.createTime = createTime ?? DateTime.now();
  }

  Reminder copyWith({
    int? id,
    String? reminderTitle,
    String? reminderDescription,
    DateTime? time1,
    List<int>? weekdays1,
    List? selectedMedicine,
  }) =>
      Reminder(
          id: id ?? this.id,
          reminderTitle: reminderTitle ?? this.reminderTitle,
          reminderDescription: reminderDescription ?? this.reminderDescription,
          time1: time1 ?? this.time1,
          weekdays1: weekdays1 != null ? List.from(weekdays1) : this.weekdays1,
          selectedMedicine: selectedMedicine != null
              ? List.from(selectedMedicine)
              : this.selectedMedicine);
}
