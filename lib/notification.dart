import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:geolocator/geolocator.dart';

import 'models/mqtt/mqtt_model.dart';

class Notification {

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  Future showNotificationWithoutSound(notification) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        '1', 'notification-bg', 'Teste notif',
        playSound: false, importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics =
    new IOSNotificationDetails(presentSound: false);
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Titulo',
      notification.toString(),
      platformChannelSpecifics,
      payload: '',
    );
  }

  Notification() {
    var initializationSettingsAndroid = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }
}

