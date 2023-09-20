import 'package:hive/hive.dart';
import 'package:my_new_project/states/models/todos/todo_model.dart';

import '../../constants/hive_keys/hive_keys.dart';

class HiveService {
  // static Box<dynamic>? _box;
  // HiveService(){
  //   _box = Hive.openBox(StorageKeys.box);
  // }

  static Future<Box<dynamic>> _getBox(String boxName) async {
    final box = await Hive.openBox<TodoModel>(boxName);
    return box;
  }

  static dynamic getFromStorage(String boxName, String key) async {
    var box = await _getBox(boxName);
    // var box = Hive.box(StorageKeys.box);
    final result = box.get(key);
    return result;
  }

  static saveToLocal(String boxName, String key, dynamic value) async {
    var box = await _getBox(boxName);
    // var box = Hive.box(StorageKeys.box);
    box.put(key, value);
  }

  static addItemToLocalList(String boxName, String key, dynamic value) async {
    var box = await _getBox(boxName);
    // var box = Hive.box(StorageKeys.box);
    final localList = box.get(key) as List?;
    if (localList == null) {
      box.put(key, [value]);
    } else {
      localList.insert(0, value);
      box.put(key, localList);
    }
  }

  //   ---------------- TodoModel Objects CRED --------------------//
  static Future<List<TodoModel>> getTodosFromLocal() async {
    var box = await Hive.openBox<TodoModel>(StorageKeys.box);
    // var box = await _getBox(StorageKeys.box);
    final List<TodoModel> todosFromLocal = box.values.toList();
    return todosFromLocal;
  }

  static Future<void> addNewTodoToLocal(
    TodoModel newTodo, {
    bool isUpdate = false,
    int index = -1,
  }) async {
    var box = await Hive.openBox<TodoModel>(StorageKeys.box);
    if (isUpdate && index != -1) {
      await box.deleteAt(index);
    }
    final List<TodoModel> todosFromLocal = box.values.toList();
    todosFromLocal.add(newTodo);
    todosFromLocal.sort((a, b) => a.createdDate!.compareTo(b.createdDate!));
    final updateTodoList = todosFromLocal.reversed.toList();
    await box.clear();

    await box.addAll(updateTodoList);
    // await newTodo.save();
  }

  static Future<void> deleteTodoAt(int index) async {
    var box = await Hive.openBox<TodoModel>(StorageKeys.box);
    await box.deleteAt(index);
  }

  static Future<void> clearAllTodos() async {
    var box = await Hive.openBox<TodoModel>(StorageKeys.box);
    await box.clear();
  }
}
