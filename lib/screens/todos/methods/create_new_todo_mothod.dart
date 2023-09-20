import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:my_new_project/common/enums.dart';
import 'package:my_new_project/common/methods.dart';
import 'package:my_new_project/screens/todos/methods/validators/create_todo_validator.dart';
import 'package:my_new_project/services/notification_service/notification_service.dart';

import '../../../services/storage_service/hive_service.dart';
import '../../../states/controller/new_todo_controller.dart';
import '../../../states/controller/reminder_toggle_controller.dart';
import '../../../states/controller/todo_controller.dart';

import 'dart:developer' as developer;

import '../../../states/controller/week_days_selection_controller.dart';
import '../../../states/models/todos/reminder_freq_model.dart';
import '../../../states/models/todos/todo_model.dart';

createNewTodoMethod({
  required GlobalKey<FormState> formKey,
}) async {
  //validate the form
  final isValid = formKey.currentState?.validate();
  if (isValid != true) return;

  NewTodoController controller = Get.find();
  TodoController todoController = Get.find();
  WeekDaysSelectionController weekDaysSelectionController = Get.find();
  ReminderToggleController reminderToggleController = Get.find();
  final isReminderAdded = reminderToggleController.haveReminder;

  developer.log(
      'Todo model from createTodoMethod = ${controller.currentTodo.toJson()}');

  final isTodoValid = createTodoValidator(controller);
  developer.log('isTodoValid = $isTodoValid');
  if (isTodoValid != null) {
    developer.log('error message = $isTodoValid');
    CommonMethods.showSnackBar(SnackBarType.error, isTodoValid);
    return;
  }

  final todo = controller.newTodo.value;
  // final reminder = todo.reminder;
  final reminderFrequencyEnum = todo.reminder?.frequency.frequency;
  final reminderFrequencyObject = todo.reminder?.frequency;
  final weekList = weekDaysSelectionController.days;
  developer.log(controller.newTodo.value.toJson().toString());

  final TodoModel newTodo = todo.copyWith(
    id: todo.id ?? 10000 + todoController.items.length + 1,
    createdDate: DateTime.now(),
    reminder: !isReminderAdded
        ? null
        : todo.reminder?.copyWith(
            title: todo.title,
            content: todo.content,
            frequency: reminderFrequencyObject?.copyWith(
              activeDays: reminderFrequencyEnum == ReminderFrequencyEnum.custom
                  ? weekList
                  : reminderFrequencyObject.activeDays,
            ),
          ),
  );
  // check if it is an update job
  // check for id in TodoModel object
  if (todo.id != null) {
    //   update existing TodoObject
    final index =
        todoController.todos.indexWhere((element) => element.id == todo.id);
    todoController.updateItem(newTodo);

    await HiveService.addNewTodoToLocal(
      newTodo,
      isUpdate: true,
      index: index,
    );
  } else {
    // create new TodoModel Object
    todoController.addItem(newTodo);
    await HiveService.addNewTodoToLocal(newTodo);
  }
  developer.log(newTodo.toJson().toString());

  AwesomeNotifications().cancelAllSchedules();
  // NotificationService.createNewNotification(todo: newTodo);
  developer.log('Reminder Created.');

  controller.updateNewTodo(NewTodoController.newTodoStatic.copyWith());

  Get.back();
}
