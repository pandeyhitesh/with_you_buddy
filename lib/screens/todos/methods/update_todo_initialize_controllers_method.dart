import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_new_project/states/controller/new_todo_controller.dart';
import 'package:my_new_project/states/controller/reminder_toggle_controller.dart';
import 'package:my_new_project/states/controller/week_days_selection_controller.dart';
import 'package:my_new_project/states/models/todos/reminder_freq_model.dart';
import 'package:my_new_project/states/models/todos/todo_model.dart';

updateTodoInitializeControllersMethod({
  required NewTodoController newTodoController,
  required TodoModel todoToUpdate,
}) async {
  ReminderToggleController reminderToggleController = Get.find();
  WeekDaysSelectionController weekdaysController = Get.find();

  newTodoController.updateNewTodo(todoToUpdate);
  if (todoToUpdate.reminder != null) {
    reminderToggleController.setToggleValue(true);
    if (todoToUpdate.reminder!.frequency.frequency ==
        ReminderFrequencyEnum.custom) {
      final weekListFromTodo = todoToUpdate.reminder!.frequency.activeDays;
      weekdaysController.setControllerValue(weekListFromTodo);
    }
  }
}
