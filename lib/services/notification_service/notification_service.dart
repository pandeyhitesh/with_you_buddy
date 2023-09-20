import 'dart:math';
import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:intl/intl.dart';
import 'package:my_new_project/states/models/todos/reminder_freq_model.dart';
import 'package:my_new_project/states/models/todos/todo_model.dart';
import 'package:my_new_project/states/models/todos/weekdays_model.dart';

import '../../theme/dark_theme.dart';

class NotificationService {
  const NotificationService._();

  static List<NotificationChannelGroup> notificationChannelGroups = [
    NotificationChannelGroup(
      channelGroupkey: 'buddy_channel_group',
      channelGroupName: 'Buddy Notifications',
    )
  ];

  static List<NotificationChannel> notificationChannels = [
    NotificationChannel(
      channelGroupKey: 'buddy_channel_group',
      channelKey: 'buddy_alarms',
      channelName: 'Buddy Alarms',
      channelDescription: 'Notification channel for alarms from Buddy',
      defaultColor: ThemeColors.primary,
      ledColor: Colors.white,
      importance: NotificationImportance.Max,
      playSound: true,
      enableVibration: true,
      defaultRingtoneType: DefaultRingtoneType.Alarm,
    ),
    NotificationChannel(
      channelGroupKey: 'buddy_channel_group',
      channelKey: 'buddy_reminders',
      channelName: 'Buddy Reminders',
      channelDescription: 'Notification channel for Reminders from Buddy',
      defaultColor: ThemeColors.primary,
      ledColor: Colors.white,
      importance: NotificationImportance.Max,
      playSound: true,
      enableVibration: true,
      defaultRingtoneType: DefaultRingtoneType.Notification,
    ),
  ];

  static initializeAwesomeNotifications() {
    AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      // 'resource://drawable/res_app_icon',
      null,
      notificationChannels,
      channelGroups: notificationChannelGroups,
      debug: true,
    );
  }

  static Future<bool> createNewNotification({
    NotificationCategory notificationCategory = NotificationCategory.Reminder,
    required TodoModel todo,
  }) async {
    AwesomeNotifications().requestPermissionToSendNotifications();
    // AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    //   if (!isAllowed) {
    //     AwesomeNotifications().requestPermissionToSendNotifications();
    //   }
    // });
    final awesomeNotifications = AwesomeNotifications();

    // final permissionList = await awesomeNotifications.checkPermissionList();
    // print("Notification Permissions = ${permissionList.toString()}");

    return awesomeNotifications.createNotification(
      content: NotificationContent(
        id: todo.id ?? Random().nextInt(10000).modPow(3, 7),
        title: todo.title ?? 'You have a new reminder!',
        body: todo.content ??
            'Hello there! Good to see you. You have a new reminder. click here for details.',
        channelKey: 'basic_channel',
        displayOnForeground: true,
        category: notificationCategory,
        fullScreenIntent: true,
        notificationLayout: NotificationLayout.Default,
        autoDismissible: false,
        wakeUpScreen: true,
        // payload: {
        //   ''
        // },
      ),
      actionButtons: notificationCategory == NotificationCategory.Alarm
          ? [
              NotificationActionButton(
                key: 'STOP',
                label: 'Stop',
                buttonType: ActionButtonType.DisabledAction,
              ),
              NotificationActionButton(
                key: 'SNOOZE',
                label: 'Snooze',
                buttonType: ActionButtonType.KeepOnTop,
              ),
            ]
          : null,
      schedule: getSchedule(todo: todo),
      // schedule: NotificationCalendar.fromDate(
      //   date: DateTime.now().add(const Duration(seconds: 3)),
      //   preciseAlarm: true,
      //   repeats: true,
      //   allowWhileIdle: true,
      // ),
      // schedule: NotificationInterval(
      //   interval: 60,
      //   repeats: true,
      //   preciseAlarm: true,
      // ),
    );
  }

  ///  *********************************************
  ///     NOTIFICATION EVENTS LISTENER
  ///  *********************************************
  ///  Notifications events are only delivered after call this method
  // static Future<void> startListeningNotificationEvents() async {
  //   AwesomeNotifications().listScheduledNotifications()displayedStream.listen((event) {
  //     final temp = event.
  //   });
  // }

  static NotificationSchedule? getSchedule({
    required TodoModel todo,
  }) {
    final reminder = todo.reminder;
    if (reminder == null) return null;
    final reminderFrequencyEnum = reminder.frequency.frequency;
    if (reminderFrequencyEnum == ReminderFrequencyEnum.daily) {
      return NotificationAndroidCrontab.daily(
        referenceDateTime: DateTime.now(),
      );
    }
    if (reminderFrequencyEnum == ReminderFrequencyEnum.weekDay) {
      return NotificationAndroidCrontab.workweekDay(
        referenceDateTime: DateTime.now(),
        allowWhileIdle: true,
      );
    }
    if (reminderFrequencyEnum == ReminderFrequencyEnum.once) {
      return NotificationAndroidCrontab.fromDate(date: reminder.setOn!);
    }
    if (reminderFrequencyEnum == ReminderFrequencyEnum.custom) {
      return NotificationAndroidCrontab(
        crontabExpression: getCrontabExpressionForCustomSchedule(
          reminder.frequency.activeDays,
          reminder.setOn!,
        ),
        repeats: true,
        allowWhileIdle: true,
        preciseAlarm: true,
      );
    }
    return null;
  }

  static getCrontabExpressionForCustomSchedule(
    List<WeekDays> weekdays,
    DateTime setOn,
  ) {
    String crontabDays = '';
    for (var day in weekdays) {
      crontabDays += ',${day.getCrontabDay}';
    }

    return '${DateFormat('s m H ? * ').format(setOn)}$crontabDays *';
  }
}
