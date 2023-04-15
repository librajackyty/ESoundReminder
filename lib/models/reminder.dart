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
  final List weekdays1;
  @HiveField(3)
  final int reminderType; // alarm num
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
  @HiveField(9)
  late final DateTime? time2;
  @HiveField(10)
  late final DateTime? time3;
  @HiveField(11)
  late final DateTime? time4;

  Reminder({
    int? id,
    required this.time1,
    required this.weekdays1,
    required this.reminderTitle,
    required this.selectedMedicine,
    this.reminderDescription,
    DateTime? createTime,
    required this.reminderType,
    DateTime? time2,
    DateTime? time3,
    DateTime? time4,
  }) {
    this.id = id ?? Random.secure().nextInt(10000 - 1000) + 1000;
    this.createTime = createTime ?? DateTime.now();
    this.time2 = time2 ?? DateTime.now();
    this.time3 = time3 ?? DateTime.now();
    this.time4 = time4 ?? DateTime.now();
  }

  Reminder copyWith({
    int? id,
    String? reminderTitle,
    String? reminderDescription,
    DateTime? time1,
    List? weekdays1,
    List? selectedMedicine,
    int? reminderType,
    DateTime? time2,
    DateTime? time3,
    DateTime? time4,
  }) =>
      Reminder(
        id: id ?? this.id,
        reminderTitle: reminderTitle ?? this.reminderTitle,
        reminderDescription: reminderDescription ?? this.reminderDescription,
        time1: time1 ?? this.time1,
        weekdays1: weekdays1 != null ? List.from(weekdays1) : this.weekdays1,
        selectedMedicine: selectedMedicine != null
            ? List.from(selectedMedicine)
            : this.selectedMedicine,
        reminderType: reminderType ?? this.reminderType,
        time2: time2 ?? this.time2,
        time3: time3 ?? this.time3,
        time4: time4 ?? this.time4,
      );

  Reminder.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        time1 = DateTime.parse(json['time1'].toString()),
        weekdays1 = json['weekdays1'],
        reminderType = json['reminderType'],
        reminderTitle = json['reminderTitle'],
        reminderDescription = json['reminderDescription'],
        reminderNotes = json['reminderNotes'],
        selectedMedicine = json['selectedMedicine'],
        createTime = DateTime.parse(json['createTime'].toString()),
        time2 = DateTime.parse(json['time2'].toString()),
        time3 = DateTime.parse(json['time3'].toString()),
        time4 = DateTime.parse(json['time4'].toString());

  Map<String, dynamic> toJson() => {
        'id': id,
        'time1': time1.toString(),
        'weekdays1': weekdays1,
        'reminderType': reminderType,
        'reminderTitle': reminderTitle,
        'reminderDescription': reminderDescription,
        'reminderNotes': reminderNotes,
        'selectedMedicine': selectedMedicine,
        'createTime': createTime.toString(),
        'time2': time2.toString(),
        'time3': time3.toString(),
        'time4': time4.toString(),
      };
}
