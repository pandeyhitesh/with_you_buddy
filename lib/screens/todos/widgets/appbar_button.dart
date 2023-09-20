import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../states/controller/utilities/priority_view_controller.dart';
import '../../../states/models/todos/priority_model.dart';

Widget appbarPrioritySelectionButton({
  required String? title,
  PriorityEnum? priority,
  bool isSelected = false,
}) {
  return Obx(() {
    PriorityViewController controller = Get.find();

    if (title == 'All' && (controller.item.value == null)) {
      isSelected = true;
    } else if (priority == controller.item.value) {
      isSelected = true;
    }else{
      isSelected = false;
    }
    return GestureDetector(
      onTap: () {
        if (title == 'All' && controller.item.value!=null) {
          controller.clear();
        } else if (title != 'All' && controller.item.value != priority) {
          controller.updatePriority(priority);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: Colors.white70,
            width: 1.5,
          ),
          color: isSelected ? Colors.white : null,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        margin: const EdgeInsets.only(right: 10),
        child: Center(
          child: Text(
            title ?? '',
            style: TextStyle(color: isSelected ? Colors.black87 : null),
          ),
        ),
      ),
    );
  });
}
