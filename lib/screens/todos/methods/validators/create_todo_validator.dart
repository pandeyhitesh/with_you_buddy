import 'package:get/get.dart';
import 'package:my_new_project/states/controller/new_todo_controller.dart';

import 'package:my_new_project/states/controller/reminder_toggle_controller.dart';
import 'package:my_new_project/states/controller/week_days_selection_controller.dart';
import 'package:my_new_project/states/models/todos/reminder_freq_model.dart';

import '../../../../states/controller/todo_controller.dart';

String? createTodoValidator(NewTodoController newTodoController) {
  ReminderToggleController reminderToggleController = Get.find();
  if (!reminderToggleController.haveReminder) return null;

  // NewTodoController newTodoController = Get.find();
  final selectedReminder = newTodoController.currentTodo.reminder;
  final selectedFrequency = selectedReminder?.frequency.frequency;
  if (selectedReminder != null &&
      selectedFrequency == ReminderFrequencyEnum.once &&
      selectedReminder.setOn == null) {
    return 'Please select Date and Time for the Reminder';
  }

  WeekDaysSelectionController weekDaysSelectionController = Get.find();
  final days = weekDaysSelectionController.days;
  final daysHasSelection = days.any((day) => day.isActive);
  if (selectedReminder != null &&
      selectedFrequency == ReminderFrequencyEnum.custom &&
      !daysHasSelection) {
    return 'Please select Days for the Custom Reminder';
  }
  return null;
}
