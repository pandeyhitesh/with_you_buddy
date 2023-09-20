// import 'package:flutter/scheduler.dart';
import 'dart:ffi';

import 'package:my_new_project/states/models/todos/priority_model.dart';
import 'package:my_new_project/states/models/todos/reminder_model.dart';
import 'package:my_new_project/states/models/todos/todo_model.dart';

import '../states/models/todos/reminder_freq_model.dart';

final todos = [
  TodoModel(
    id: 0001,
    title: 'Title One',
    content: description,
    priority: PriorityEnum.urgent,
    createdDate: DateTime(2023, 09, 10),
    reminder: ReminderModel(
      title: 'Title Three',
      content: 'This is a reminder description',
      setOn: DateTime(2023, 09, 13),
      frequency: ReminderFrequency.getFrequencySetting(
        ReminderFrequencyEnum.weekDay,
      ),
    ),
  ),
  TodoModel(
    id: 0002,
    title: 'Title Two',
    content: description,
    priority: PriorityEnum.urgent,
    createdDate: DateTime(2023, 09, 10),
    reminder: null,
  ),
  TodoModel(
    id: 0003,
    title: 'Title Three',
    content: description,
    priority: PriorityEnum.important,
    createdDate: DateTime(2023, 09, 10),
    reminder: ReminderModel(
      title: 'Title Three',
      content: 'This is a reminder description',
      setOn: DateTime(2023, 09, 13),
      frequency: ReminderFrequency.getFrequencySetting(
        ReminderFrequencyEnum.once,
      ),
    ),
  ),
  TodoModel(
    id: 0004,
    title: 'Title Four',
    content: description,
    priority: PriorityEnum.general,
    createdDate: DateTime(2023, 09, 10),
    reminder: ReminderModel(
      title: 'Title Four',
      content: 'This is a reminder description',
      setOn: null,
      frequency: ReminderFrequency.getFrequencySetting(
        ReminderFrequencyEnum.daily,
      ),
    ),
  ),
  TodoModel(
    id: 0005,
    title: 'Title Five',
    content: description,
    priority: PriorityEnum.important,
    createdDate: DateTime(2023, 09, 10),
    reminder: ReminderModel(
      title: 'Title Five',
      content: 'This is a reminder description',
      setOn: null,
      frequency: ReminderFrequency.getFrequencySetting(
        ReminderFrequencyEnum.custom,
      ),
    ),
  ),
];

const description =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat';
