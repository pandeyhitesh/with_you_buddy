import 'package:flutter/material.dart';
import 'package:my_new_project/services/navigation_service.dart';
import 'package:my_new_project/states/models/todos/priority_model.dart';

class TextStyles {
  const TextStyles._();

  static final todoTitleTextStyle = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w600,
    fontSize: 14,
    letterSpacing: .7,
    color: Colors.white.withOpacity(.9),
  );

  static final todoContentTextStyle = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
    fontSize: 12,
    letterSpacing: .3,
    color: Colors.white.withOpacity(.8),
  );

  static TextStyle todoVerySmallTextStyle(PriorityEnum? pr) => TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400,
        fontSize: 12,
        letterSpacing: .3,
        color: pr == PriorityEnum.urgent
            ? Colors.white
            : Theme.of(NavigationService.navigatorKey.currentContext!)
                .colorScheme
                .primaryContainer,
      );
}
