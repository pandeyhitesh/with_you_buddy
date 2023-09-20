import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:my_new_project/common/methods.dart';
import 'package:my_new_project/screens/todos/methods/textFieldMethods/new_todo_title_on_changed_method.dart';
import 'package:my_new_project/screens/todos/widgets/common/pop_up_action_button.dart';
import 'package:my_new_project/screens/todos/widgets/new_todo_priority_selection_widget.dart';
import 'package:my_new_project/screens/todos/widgets/week_days_card.dart';
import 'package:my_new_project/states/controller/new_todo_controller.dart';
import 'package:my_new_project/states/controller/reminder_toggle_controller.dart';
import 'package:my_new_project/states/controller/week_days_selection_controller.dart';
import 'package:my_new_project/states/models/todos/priority_model.dart';
import 'package:my_new_project/states/models/todos/reminder_model.dart';
import 'package:my_new_project/states/models/todos/todo_model.dart';
import 'package:my_new_project/theme/button_styles.dart';
import 'package:my_new_project/theme/text_styles.dart';
import 'package:my_new_project/theme/theme_constants.dart';
import 'package:my_new_project/theme/theme_methods.dart';

import '../../states/models/todos/reminder_freq_model.dart';
import 'methods/date_time_selection.dart';
import 'methods/new_todo_update_frequency_method.dart';
import 'methods/update_todo_initialize_controllers_method.dart';

Future<void> createNewTodo({
  required BuildContext context,
  TodoModel? todoToUpdate,
}) async {
  final formKey = GlobalKey<FormState>();
  final controller = Get.put(NewTodoController());
  final reminderToggleController = Get.put(ReminderToggleController());
  final weekDaysController = Get.put(WeekDaysSelectionController());
  // final
  controller.clearController();
  reminderToggleController.clearController();
  weekDaysController.clearController();
  if (todoToUpdate != null) {
    updateTodoInitializeControllersMethod(
      newTodoController: controller,
      todoToUpdate: todoToUpdate,
    );
  }
  await showDialog(
    context: context,
    builder: (context) {
      return Obx(() {
        var newTodoPriority = controller.newTodo.value.priority;

        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ThemeConstants.cardRadius),
            side: BorderSide(
              color: CommonMethods.colorFromPriority(
                  newTodoPriority ?? PriorityEnum.general),
              width: 1.5,
              style: BorderStyle.solid,
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          contentPadding: const EdgeInsets.all(16),
          actionsPadding: const EdgeInsets.fromLTRB(0, 10, 26, 20),
          elevation: 10,
          content: TodoCreateNew(formKey: formKey),
          actions: popUpActionButton(
            context: context,
            controller: controller,
            formKey: formKey,
          ),
        );
      });
    },
  );
  // clear the controllers
  // NewTodoController newTodoController = Get.find();
  // ReminderToggleController reminderToggleController = Get.find();
  // WeekDaysSelectionController weekdaysController = Get.find();
  // newTodoController.clearController();
  // reminderToggleController.clearController();
  // weekdaysController.clearController();
}

class TodoCreateNew extends StatelessWidget {
  TodoCreateNew({super.key, required this.formKey});
  final GlobalKey<FormState> formKey;
  final toggleController = Get.put(ReminderToggleController());
  final weekDaySelectionController = Get.put(WeekDaysSelectionController());
  final NewTodoController newTodoController = Get.find();

  // final newTodoController = Get.put(NewTodoController());

  @override
  Widget build(BuildContext context) {
    TodoModel currentTodo = newTodoController.currentTodo;
    return SizedBox(
      width: CommonMethods.screenWidth,
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 5.0,
                bottom: 30,
                left: 6,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Title(
                    color: Colors.yellow,
                    child: const Text('New ToDo'),
                  ),
                  newTodoPrioritySelectionWidget(context),
                ],
              ),
            ),
            TextFormField(
              decoration: ThemeMethods.inputDecoration(
                labelText: 'Title',
                hintText: 'Enter Title',
              ),
              initialValue: currentTodo.title,
              onChanged: newTodoTitleOnChangedMethod,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a valid title';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              decoration: ThemeMethods.inputDecoration(
                labelText: 'Description',
                hintText: 'Enter Description here...',
                isMultiline: true,
              ),
              maxLines: 3,
              initialValue: currentTodo.content,
              onChanged: newTodoContentOnChangedMethod,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a valid Description';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            ...reminderSection(context),
          ],
        ),
      ),
    );
  }

  List<Widget> reminderSection(BuildContext context) {
    return [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Set Reminder:',
              style: TextStyles.todoContentTextStyle,
            ),
            Obx(
              () {
                return Switch(
                  value: toggleController.isSelected.value,
                  activeColor: Colors.white60,
                  activeTrackColor:
                      Theme.of(context).colorScheme.secondaryContainer,
                  inactiveThumbColor: Colors.white38,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  onChanged: (newValue) {
                    toggleController.toggle();
                    if (!newValue) {
                      newTodoController.updateNewTodo(
                        newTodoController.currentTodo.setReminder(
                          reminder: null,
                        ),
                      );
                    } else {
                      newTodoController.updateNewTodo(
                        newTodoController.currentTodo.copyWith(
                          reminder: ReminderModel(
                            frequency: ReminderFrequency.frequencies.first,
                          ),
                        ),
                      );
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
      const SizedBox(
        height: 16,
      ),
      reminderSelectionCard(context),
    ];
  }

  Widget reminderSelectionCard(BuildContext context) {
    return Obx(
      () {
        var selectedFrequencyTitle =
            newTodoController.newTodo.value.reminder?.frequency.title;
        var selectedFrequency =
            newTodoController.newTodo.value.reminder?.frequency.frequency;

        DateTime? selectedDateTime =
            newTodoController.newTodo.value.reminder?.setOn;
        String? selectedDate = selectedDateTime == null
            ? null
            : ThemeConstants.dateOnlyFormat
                .format(newTodoController.newTodo.value.reminder!.setOn!);
        String? selectedTime = selectedDateTime == null
            ? null
            : ThemeConstants.timeOnlyFormat
                .format(newTodoController.newTodo.value.reminder!.setOn!);

        return toggleController.haveReminder
            ? Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white10,
                ),
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Reminder',
                          style: TextStyles.todoContentTextStyle.copyWith(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => newTodoUpdateFrequencyMethod(context),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: Colors.white12,
                            ),
                            padding: const EdgeInsets.fromLTRB(14, 3, 5, 3),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '$selectedFrequencyTitle',
                                  style: TextStyles.todoVerySmallTextStyle(null)
                                      .copyWith(
                                    color: Colors.white60,
                                  ),
                                ),
                                const SizedBox(
                                  width: 3,
                                ),
                                const Icon(
                                  FontAwesomeIcons.caretDown,
                                  size: 12,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 14,
                    ),

                    // show active/inactive days
                    if (selectedFrequency != ReminderFrequencyEnum.once)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: weekDaySelectionController.weekDays
                            .map(
                              (day) => frequencyDayCard(
                                day,
                                onTap: () {
                                  weekDaySelectionController
                                      .toggleSelection(day);
                                },
                              ),
                            )
                            .toList(),
                      ),

                    //   show timer date and time for
                    //   'Once' type
                    if (selectedFrequency == ReminderFrequencyEnum.once)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Set On: ${selectedDate ?? ''}',
                              style: TextStyles.todoVerySmallTextStyle(null)
                                  .copyWith(
                                color: Colors.white60,
                              ),
                            ),
                            Text(
                              selectedTime ?? '',
                              style: TextStyles.todoVerySmallTextStyle(null)
                                  .copyWith(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                dateTimeSelectionMethod(context: context);
                              },
                              padding: EdgeInsets.zero,
                              visualDensity: VisualDensity.compact,
                              constraints: const BoxConstraints(
                                maxHeight: 40,
                              ),
                              splashRadius: 26,
                              icon: Icon(
                                FontAwesomeIcons.solidCalendarDays,
                                size: 16,
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              )
            : const SizedBox();
      },
    );
  }
}
