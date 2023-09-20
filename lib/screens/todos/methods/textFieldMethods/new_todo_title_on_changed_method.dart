import 'package:my_new_project/states/controller/new_todo_controller.dart';
import 'package:get/get.dart';

newTodoTitleOnChangedMethod(String? value) {
  NewTodoController controller = Get.find();
  controller.updateNewTodo(
    controller.newTodo.value.copyWith(
      title: value,
    ),
  );
}

newTodoContentOnChangedMethod(String? value) {
  NewTodoController controller = Get.find();
  controller.updateNewTodo(
    controller.newTodo.value.copyWith(
      content: value,
    ),
  );
}


