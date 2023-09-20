import 'package:flutter/material.dart';
import 'package:my_new_project/theme/button_styles.dart';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'dart:developer' as developer;

class TestAlarm extends StatelessWidget {
  const TestAlarm({super.key});

  // The callback for our alarm
  @pragma('vm:entry-point')
  static Future<void> callback() async {
    developer.log('Alarm fired!');
    // Get the previous cached count and increment it.
    // final prefs = await SharedPreferences.getInstance();
    // final currentCount = prefs.getInt(countKey) ?? 0;
    // await prefs.setInt(countKey, currentCount + 1);
    //
    // // This will be null if we're running in the background.
    // uiSendPort ??= IsolateNameServer.lookupPortByName(isolateName);
    // uiSendPort?.send(null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test alarm'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await AndroidAlarmManager.oneShot(
              const Duration(seconds: 1),
              0,
              callback,
              exact: true,
              wakeup: true,
            );
          },
          style: ButtonStyles.popUpActionButtonStyle,
          child: const Text('Ring Now'),
        ),
      ),
    );
  }
}
