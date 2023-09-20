import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:my_new_project/constants/hive_keys/hive_keys.dart';

import '../../constants/data_constants.dart' as data;
import '../models/todos/todo_model.dart';

class TodoController extends GetxController {
  // var items = data.todos.obs;
  var items = [].obs;

  // TodoController(){
  //   // var box = Hive.box(StorageKeys.box);
  //   // List<Map<String, dynamic>>? todoListFromLocal = box.get(StorageKeys.todos);
  //   List<Map<String, dynamic>>? todoListFromLocal = ;
  //   if(todoListFromLocal != null && todoListFromLocal.isNotEmpty){
  //     print('todoListFromLocal = $todoListFromLocal');
  //   }
  //
  // }

  List<TodoModel> get todos {
    return [...items];
  }

  void setTodos(List<TodoModel> todoList) => items.value = todoList;

  // TodoModel findProductById(String id){
  //   return _items.firstWhere((todo) => todo.)
  // }

  addItem(TodoModel newTodo) {
    items.insert(0, newTodo);
  }

  deleteItem(TodoModel todoToDelete) {
    items.remove(todoToDelete);
  }

  updateItem(TodoModel todoToUpdate) {
    items.removeWhere((element) => element.id == todoToUpdate.id);
    items.insert(0, todoToUpdate);
  }

  clearTodos() => items.clear();
}
