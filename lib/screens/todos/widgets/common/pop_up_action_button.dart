import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_new_project/constants/hive_keys/hive_keys.dart';
import 'package:my_new_project/screens/todos/methods/create_new_todo_mothod.dart';
import 'package:my_new_project/screens/todos/todo_create_new.dart';
import 'package:my_new_project/services/storage_service/hive_service.dart';
import 'package:my_new_project/states/controller/new_todo_controller.dart';
import 'package:my_new_project/states/controller/todo_controller.dart';
import 'dart:developer' as developer;
import '../../../../states/models/todos/todo_model.dart';
import '../../../../theme/button_styles.dart';

List<Widget> popUpActionButton({
  required BuildContext context,
  String? title,
  required NewTodoController controller,
  required GlobalKey<FormState> formKey,
}) {
  return [
    ElevatedButton(
      onPressed: () => createNewTodoMethod(formKey: formKey,),
      style: ButtonStyles.popUpActionButtonStyle.copyWith(
        backgroundColor: MaterialStatePropertyAll(
          Theme.of(context).colorScheme.tertiaryContainer,
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('Save'),
      ),
    ),
  ];
}
