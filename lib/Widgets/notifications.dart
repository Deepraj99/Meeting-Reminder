import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService extends ChangeNotifier {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationPlugin =
      FlutterLocalNotificationsPlugin();

  //initilize
  Future initialize() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationPlugin =
        FlutterLocalNotificationsPlugin();

    AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("notification_icon");

    IOSInitializationSettings iosInitializationSettings =
        IOSInitializationSettings();

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: androidInitializationSettings,
            iOS: iosInitializationSettings);

    await flutterLocalNotificationPlugin.initialize(initializationSettings);
  }

  //Instant NotificationService
  Future instantNotification() async {
    var android = AndroidNotificationDetails(
      "id",
      "channel",
      "description",
      // sound: RawResourceAndroidNotificationSound("notification_Sound"),
      playSound: true,
    );
    var ios = IOSNotificationDetails();
    var platform = new NotificationDetails(android: android, iOS: ios);
    await _flutterLocalNotificationPlugin.show(
        0, "Demo instant notofication", "Tap to do somtheing", platform,
        payload: "Welcome to demo app");
  }
}
