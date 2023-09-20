import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_new_project/states/models/todos/todo_model.dart';

import '../../../states/controller/new_todo_controller.dart';
import '../../../states/controller/week_days_selection_controller.dart';
import '../../../states/models/todos/reminder_freq_model.dart';
import '../../../states/models/todos/reminder_model.dart';
import 'package:get/get.dart';

newTodoUpdateFrequencyMethod(BuildContext context) {
  NewTodoController controller = Get.find();
  TodoModel todo = controller.newTodo.value;
  WeekDaysSelectionController weekDaysController = Get.find();

  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Obx(
        () {
          var selectedFrequency =
              controller.newTodo.value.reminder?.frequency.title;
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
              children: ReminderFrequency.frequencies
                  .map(
                    (freq) => InkWell(
                      onTap: () {
                        // set up the current ReminderFrequency object
                        var thisFrequency =
                            ReminderFrequency.frequencies.firstWhere(
                          (fq) => fq.frequency == freq.frequency,
                        );

                        // Update the newTodo state with new ReminderFrequency object
                        controller.updateNewTodo(
                          todo.copyWith(
                            reminder: todo.reminder!.copyWith(
                              frequency: thisFrequency,
                            ),
                          ),
                        );
                        // set the active days for the week
                        // based on selected frequency
                        weekDaysController.setWeekDaysList(freq.frequency);


                        // pop the bottomSheet
                        Get.back();
                      },
                      child: Container(
                        width: double.maxFinite,
                        color: (freq.title == selectedFrequency)
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
                              Text(freq.title),
                              if (freq.title == selectedFrequency)
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
            ),
          );
        },
      );
    },
  );
}
