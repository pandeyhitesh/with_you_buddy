import 'package:flutter/material.dart';
import 'package:my_new_project/states/controller/new_todo_controller.dart';
import 'package:get/get.dart';

dateTimeSelectionMethod({
  required BuildContext context,
}) async {
  final DateTime? selectedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime(2024, 12, 31),
  );

  TimeOfDay? selectedTime;
  if (selectedDate != null && context.mounted) {
    selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
  }

  if (selectedDate != null && selectedTime != null) {
    final selectedDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );

    NewTodoController controller = Get.find();
    final newTodo = controller.newTodo.value;
    controller.updateNewTodo(
      newTodo.copyWith(
        reminder: newTodo.reminder?.copyWith(
          setOn: selectedDateTime,
        ),
      ),
    );
  }
}
