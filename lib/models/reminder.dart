class Reminder {
  int reminderType = 0;
  late DateTime reminderTime;
  String reminderTitle = "";
  String reminderDescription = "";
  String reminderNotes = "";

  Reminder({required this.reminderTime, required this.reminderTitle});
}
