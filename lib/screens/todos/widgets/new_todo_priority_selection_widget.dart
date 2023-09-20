
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_new_project/states/controller/new_todo_controller.dart';

import '../../../common/methods.dart';
import '../../../theme/text_styles.dart';
import '../../../theme/theme_constants.dart';
import 'package:get/get.dart';

import '../methods/new_todo_update_priority_method.dart';

Widget newTodoPrioritySelectionWidget(BuildContext context) {
  NewTodoController controller = Get.find();
  var todo = controller.newTodo.value;
  return GestureDetector(
    onTap: ()=> newTodoUpdatePriorityMethod(context),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ThemeConstants.cardRadius),
        color: CommonMethods.colorFromPriority(todo.priority!),
      ),
      padding: const EdgeInsets.fromLTRB(14, 6, 7, 6),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            CommonMethods.getPriorityTitle(
              todo.priority!,
            ),
            style: TextStyles.todoVerySmallTextStyle(todo.priority),
          ),
          const SizedBox(
            width: 3,
          ),
          const Icon(
            FontAwesomeIcons.caretDown,
            size: 12,
            color: Colors.black87,
          )
        ],
      ),
    ),
  );
}
