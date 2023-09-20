import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_new_project/states/models/todos/priority_model.dart';

import '../../../states/controller/new_todo_controller.dart';
import '../../../states/models/todos/todo_model.dart';
import 'package:get/get.dart';

newTodoUpdatePriorityMethod(BuildContext context) {
  NewTodoController controller = Get.find();
  TodoModel todo = controller.newTodo.value;

  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Obx(
        () {
          var selectedPriority = controller.newTodo.value.priority;
          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(20),
            ),
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: defaultPriorities
                  .map(
                    (pr) => InkWell(
                      onTap: () {
                        // set up the current ReminderFrequency object
                        var thisPriority = pr.priority;

                        // Update the newTodo state with new ReminderFrequency object
                        controller.updateNewTodo(
                          todo.copyWith(
                            priority: thisPriority,
                          ),
                        );

                        // pop the bottomSheet
                        Get.back();
                      },
                      child: Container(
                        width: double.maxFinite,
                        color: (pr.priority == selectedPriority)
                            ? Theme.of(context)
                                .colorScheme
                                .tertiaryContainer
                                .withOpacity(.2)
                            : null,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(pr.title),
                              if (pr.priority == selectedPriority)
                                const Icon(
                                  FontAwesomeIcons.check,
                                  size: 14,
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
              // children: [
              // Container(height: 20, color: Colors.red,),
              // Container(height: 20, color: Colors.grey,),
              // Container(height: 20, color: Colors.blue,),
              // Container(height: 20, color: Colors.purple,),
              // ],
            ),
          );
        },
      );
    },
  );
}
