import 'package:flutter/material.dart';
import 'package:my_new_project/services/navigation_service.dart';
import 'package:my_new_project/states/models/todos/priority_model.dart';
import 'package:get/get.dart';

import 'enums.dart';

class CommonMethods {
  const CommonMethods._();

  static final screenHeight =
      MediaQuery.of(NavigationService.navigatorKey.currentContext!).size.height;
  static final screenWidth =
      MediaQuery.of(NavigationService.navigatorKey.currentContext!).size.width;

  static colorFromPriority(PriorityEnum pr) =>
      defaultPriorities.firstWhere((element) => element.priority == pr).color;

  static getPriorityTitle(PriorityEnum pr) =>
      defaultPriorities.firstWhere((element) => element.priority == pr).title;

  static showSnackBar(SnackBarType type, String message) => Get.showSnackbar(
        GetSnackBar(
          message: message,
          backgroundColor: type == SnackBarType.error
              ? Theme.of(NavigationService.navigatorKey.currentContext!)
                  .colorScheme
                  .secondaryContainer
              // : const Color(0xFFff9d27),
              : const Color(0xFFffa840),
          // : Colors.grey.shade800,
          duration: const Duration(milliseconds: 3000),
          margin: const EdgeInsets.symmetric(horizontal: 26, vertical: 30),
          borderRadius: 15,
        ),
      );
}
