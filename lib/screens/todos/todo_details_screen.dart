import 'package:flutter/material.dart';
import 'package:my_new_project/screens/todos/widgets/buttons_section.dart';
import 'package:my_new_project/screens/todos/widgets/week_days_card.dart';
import 'package:my_new_project/states/models/todos/reminder_model.dart';
import 'package:my_new_project/states/models/todos/todo_model.dart';

import '../../common/methods.dart';
import '../../states/models/todos/reminder_freq_model.dart';
import '../../theme/text_styles.dart';
import '../../theme/theme_constants.dart';

showTodoDetails({
  required BuildContext context,
  required TodoModel todo,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        elevation: 10,

        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            ThemeConstants.cardRadius,
          ),
          side: BorderSide(
            color: CommonMethods.colorFromPriority(todo.priority!),
            width: 1.5,
            style: BorderStyle.solid,
          ),
        ),
        // contentPadding: EdgeInsets.zero,
        content: TodoDetailsScreen(
          todo: todo,
        ),
      );
    },
  );
}

class TodoDetailsScreen extends StatelessWidget {
  TodoDetailsScreen({super.key, required this.todo});

  final _scrollController = ScrollController();

  final TodoModel todo;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              flex: 2,
              child: Text(
                todo.title ?? '',
                style: TextStyles.todoTitleTextStyle,
                maxLines: 2,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            // ------------ <hidden> show Priority of the todoObject
            // Flexible(
            //   flex: 1,
            //   child: Align(
            //     alignment: Alignment.centerRight,
            //     child: Container(
            //       decoration: BoxDecoration(
            //         borderRadius:
            //             BorderRadius.circular(ThemeConstants.cardRadius),
            //         color: CommonMethods.colorFromPriority(todo.priority!),
            //       ),
            //       padding: const EdgeInsets.symmetric(
            //         horizontal: 14,
            //         vertical: 3,
            //       ),
            //       child: Text(
            //         CommonMethods.getPriorityTitle(
            //           todo.priority!,
            //         ),
            //         style: TextStyles.todoVerySmallTextStyle(todo.priority),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          constraints: BoxConstraints(
            maxHeight: CommonMethods.screenHeight / 5,
          ),
          child: Scrollbar(
            controller: _scrollController,
            thickness: 1.5,
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Text(
                todo.content ?? '',
                style: TextStyles.todoContentTextStyle,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 25,
        ),

        //show created Date
        Text(
          'Created On: ${ThemeConstants.dateFormat.format(todo.createdDate!)}',
          style:
              TextStyles.todoContentTextStyle.copyWith(color: Colors.white54),
        ),

        //show active days
        if (todo.reminder != null) ...[
          const SizedBox(
            height: 25,
          ),
          reminderSection(),
        ],

        //show buttons section
        ButtonsSection(
          todo: todo,
        ),
      ],
    );
  }

  Widget reminderSection() {
    return Container(
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
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: Colors.white12,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 3,
                ),
                child: Text(
                  todo.reminder!.frequency.title,
                  style:
                      TextStyles.todoVerySmallTextStyle(todo.priority).copyWith(
                    color: Colors.white60,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 14,
          ),

          // show active/inactive days
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: todo.reminder!.frequency.activeDays
                .map((day) => frequencyDayCard(day))
                .toList(),
          ),

          //   show timer date and time for
          //   'Once' type
          if (todo.reminder != null &&
              todo.reminder!.frequency.frequency == ReminderFrequencyEnum.once)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Set On: ${ThemeConstants.dateOnlyFormat.format(todo.reminder!.setOn!)}',
                  style:
                      TextStyles.todoVerySmallTextStyle(todo.priority).copyWith(
                    color: Colors.white60,
                  ),
                ),
                Text(
                  ThemeConstants.timeOnlyFormat.format(todo.reminder!.setOn!),
                  style:
                      TextStyles.todoVerySmallTextStyle(todo.priority).copyWith(
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
