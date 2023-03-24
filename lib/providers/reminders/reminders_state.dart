import '../../models/reminder.dart';

abstract class ReminderState {
  const ReminderState();
}

class ReminderLoaded extends ReminderState {
  final List<Reminder> reminders;

  const ReminderLoaded(this.reminders);
}

// state for create, update, delete,
class ReminderCreated extends ReminderState {
  final Reminder reminder;
  final int index;

  const ReminderCreated(this.reminder, this.index);
}

class ReminderDeleted extends ReminderState {
  final Reminder reminder;
  final int index;

  const ReminderDeleted(this.reminder, this.index);
}

class ReminderUpdated extends ReminderState {
  final Reminder reminder;
  final Reminder oldReminder;
  final int index;
  final int newIndex;

  const ReminderUpdated(
      this.reminder, this.oldReminder, this.index, this.newIndex);
}
