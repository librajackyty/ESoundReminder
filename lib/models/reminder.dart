import 'dart:math';

class Reminder {
  late final int id;
  final int reminderType = 0;
  final DateTime time1;
  final List<int> weekdays1;
  final String reminderTitle;
  String? reminderDescription;
  String? reminderNotes;

  Reminder(
      {int? id,
      required this.time1,
      required this.weekdays1,
      required this.reminderTitle}) {
    this.id = id ?? Random.secure().nextInt(10000 - 1000) + 1000;
  }

  Reminder copyWith({
    int? id,
    String? reminderTitle,
    DateTime? time1,
    List<int>? weekdays1,
  }) =>
      Reminder(
        id: id ?? this.id,
        reminderTitle: reminderTitle ?? this.reminderTitle,
        time1: time1 ?? this.time1,
        weekdays1: weekdays1 != null ? List.from(weekdays1) : this.weekdays1,
      );
}
