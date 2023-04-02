// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReminderAdapter extends TypeAdapter<Reminder> {
  @override
  final int typeId = 0;

  @override
  Reminder read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Reminder(
      id: fields[0] as int?,
      time1: fields[1] as DateTime,
      weekdays1: (fields[2] as List).cast<int>(),
      reminderTitle: fields[4] as String,
      selectedMedicine: (fields[7] as List).cast<dynamic>(),
      reminderDescription: fields[5] as String?,
      createTime: fields[8] as DateTime?,
    )..reminderNotes = fields[6] as String?;
  }

  @override
  void write(BinaryWriter writer, Reminder obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.time1)
      ..writeByte(2)
      ..write(obj.weekdays1)
      ..writeByte(3)
      ..write(obj.reminderType)
      ..writeByte(4)
      ..write(obj.reminderTitle)
      ..writeByte(5)
      ..write(obj.reminderDescription)
      ..writeByte(6)
      ..write(obj.reminderNotes)
      ..writeByte(7)
      ..write(obj.selectedMedicine)
      ..writeByte(8)
      ..write(obj.createTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReminderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
