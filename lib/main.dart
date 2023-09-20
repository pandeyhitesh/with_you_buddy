import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_new_project/constants/hive_keys/hive_keys.dart';
// import 'package:hive/hive.dart';
import 'package:my_new_project/screens/todos/todo_home_screen.dart';
import 'package:my_new_project/services/navigation_service.dart';
import 'package:my_new_project/services/storage_service/todo_hive_model.dart';
import 'package:my_new_project/states/controller/todo_controller.dart';
import 'package:my_new_project/states/controller/utilities/priority_view_controller.dart';
import 'package:my_new_project/states/models/todos/priority_model.dart';
import 'package:my_new_project/states/models/todos/reminder_freq_model.dart';
import 'package:my_new_project/states/models/todos/reminder_model.dart';
import 'package:my_new_project/states/models/todos/todo_model.dart';
import 'package:my_new_project/states/models/todos/weekdays_model.dart';
import 'package:my_new_project/test_alarm_screen.dart';
import 'package:my_new_project/theme/button_styles.dart';
import '../theme/dark_theme.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
// FlutterLocalNotificationsPlugin();
//
// /// Streams are created so that app can respond to notification-related events
// /// since the plugin is initialised in the `main` function
// final StreamController<ReceivedNotification> didReceiveLocalNotificationStream =
// StreamController<ReceivedNotification>.broadcast();



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  // Hive.registerAdapter(TodoHiveModelAdapter());
  // await Hive.openBox(StorageKeys.box);

  Hive.registerAdapter(TodoModelAdapter());
  Hive.registerAdapter(ReminderModelAdapter());
  Hive.registerAdapter(ReminderFrequencyAdapter());
  Hive.registerAdapter(WeekDaysAdapter());
  Hive.registerAdapter(PriorityEnumAdapter());
  Hive.registerAdapter(ReminderFrequencyEnumAdapter());

  // initialize AndroidAlarmManager
  await AndroidAlarmManager.initialize();
  runApp(
    const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(TodoController());
    Get.put(PriorityViewController());
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: NavigationService.navigatorKey,
      debugShowCheckedModeBanner: false,
      darkTheme: darkTheme,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const TestAlarm(),
    );
  }
}


