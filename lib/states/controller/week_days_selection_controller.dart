import 'package:get/get.dart';
import 'package:my_new_project/states/models/todos/reminder_model.dart';

import '../models/todos/reminder_freq_model.dart';
import '../models/todos/weekdays_model.dart';

class WeekDaysSelectionController extends GetxController {
  var weekDays = [...WeekDays.weekDays].obs;

  List<WeekDays> get days => weekDays.value;

  void toggleSelection(WeekDays day) {
    var currList = [...weekDays];
    final index = weekDays.indexWhere((element) => element.id == day.id);
    final newDay = day.copyWith(isActive: !day.isActive);
    currList.removeAt(index);
    currList.insert(index, newDay);
    weekDays.value = currList;
  }

  void setWeekDaysList(ReminderFrequencyEnum freq) {
    if (freq == ReminderFrequencyEnum.once ||
        freq == ReminderFrequencyEnum.custom) {
      weekDays.value = [...WeekDays.weekDays];
      return;
    }
    if (freq == ReminderFrequencyEnum.daily) {
      weekDays.value = ReminderFrequency.dailyActiveWeek;
      return;
    }
    if (freq == ReminderFrequencyEnum.weekDay) {
      weekDays.value = ReminderFrequency.weekdaysActiveWeek;
      return;
    }
  }

  void setControllerValue(List<WeekDays> weekListToUpdate) => weekDays.value = weekListToUpdate;

  void clearController() => weekDays.value = [...WeekDays.weekDays];
}
