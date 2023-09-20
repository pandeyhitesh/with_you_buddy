import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_new_project/services/storage_service/hive_service.dart';
import 'package:my_new_project/states/controller/todo_controller.dart';
import 'package:my_new_project/states/models/todos/todo_model.dart';
import 'package:get/get.dart';
import '../widgets/common/confirm_action_bottom_sheet.dart';
import 'dart:developer' as developer;

void deleteTodoMethod({
  required BuildContext context,
  required TodoModel todo,
}) async {
  final result = await confirmActionSelection(context: context);
  developer.log('confirmation result = $result');

  if (result == true) {
    TodoController controller = Get.find();
    final todoList = controller.todos;
    final index = todoList.indexOf(todo);
    developer.log('Index of Todo = $index');
    // remove TodoModel item from TodoController
    controller.deleteItem(todo);
    // Delete item from local storage
    await HiveService.deleteTodoAt(index);

    // pop the details popup for the object
    Get.back();
  }
}
