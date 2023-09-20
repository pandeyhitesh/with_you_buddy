import 'package:get/get.dart';
import 'package:my_new_project/states/controller/todo_controller.dart';
import 'package:my_new_project/states/models/todos/priority_model.dart';
import 'package:my_new_project/states/models/todos/reminder_model.dart';

import '../models/todos/reminder_freq_model.dart';
import '../models/todos/todo_model.dart';

class NewTodoController extends GetxController {
  // TodoController todosController = Get.find();

  static var newTodoStatic = TodoModel(
    priority: PriorityEnum.general,
  );

  var newTodo = TodoModel(
    priority: PriorityEnum.general,
  ).obs;

  TodoModel get currentTodo => newTodo.value;

  void updateNewTodo(TodoModel updatedTodo) => newTodo.value = updatedTodo;

  void clearController() => newTodo.value = newTodoStatic.copyWith();
}
