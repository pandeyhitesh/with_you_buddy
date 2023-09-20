import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:my_new_project/common/enums.dart';
import 'package:my_new_project/screens/todos/methods/delete_todo_method.dart';
import 'package:my_new_project/services/navigation_service.dart';
import 'package:my_new_project/states/models/todos/todo_model.dart';
import 'package:my_new_project/theme/button_styles.dart';

import '../todo_create_new.dart';
import 'common/confirm_action_bottom_sheet.dart';
import 'dart:developer' as developer;

class ButtonsSection extends StatelessWidget {
  const ButtonsSection({super.key, required this.todo});

  final TodoModel todo;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            operationButtons(context),
            okayButton(context),
          ],
        ),
      ),
    );
  }

  Widget operationButtons(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => deleteTodoMethod(context: context, todo: todo),
          child: operationButtonCard(
            OperationEnum.delete,
            FontAwesomeIcons.trashCan,
          ),
        ),
        const SizedBox(
          width: 6,
        ),
        GestureDetector(
          onTap: () async {
            await createNewTodo(
              context: context,
              todoToUpdate: todo,
            );
            Get.back();
          },
          child: operationButtonCard(
            OperationEnum.edit,
            FontAwesomeIcons.pencil,
          ),
        ),
      ],
    );
  }

  Widget operationButtonCard(OperationEnum op, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: Colors.white.withOpacity(.05),
      ),
      padding: const EdgeInsets.all(8),
      child: Icon(
        icon,
        size: 14,
        color: Colors.white54,
      ),
    );
  }

  Widget okayButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Get.back(),
      style: ButtonStyles.popUpActionButtonStyle.copyWith(
        backgroundColor: MaterialStatePropertyAll(
          Theme.of(NavigationService.navigatorKey.currentContext!)
              .colorScheme
              .tertiaryContainer,
        ),
      ),
      child: const Text('Okay'),
    );
  }
}
