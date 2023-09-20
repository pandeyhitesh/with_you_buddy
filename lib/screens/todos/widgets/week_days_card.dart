import 'package:flutter/material.dart';

import '../../../states/models/todos/reminder_model.dart';
import '../../../states/models/todos/weekdays_model.dart';

Widget frequencyDayCard(WeekDays day, {Function? onTap}) {
  return Flexible(
    fit: FlexFit.tight,
    child: GestureDetector(
      onTap: onTap == null ? null : () => onTap(),
      child: Container(
        // width: double.maxFinite,
        height: 25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: day.isActive ? Colors.white10 : Colors.transparent,
        ),
        margin: const EdgeInsets.only(right: 5),
        padding: const EdgeInsets.all(5),
        child: FittedBox(
          child: Text(day.title),
        ),
      ),
    ),
  );
}
