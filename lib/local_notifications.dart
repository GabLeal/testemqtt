import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:meta/meta.dart';

import 'models/mqtt/connect_mqtt_model.dart';

class LocalNotificationsT {

  NotificationDetails get _noSound {
    final androidChannelSpecifics = AndroidNotificationDetails(
      'silent channel id',
      'silent channel name',
      'silent channel description',
      playSound: false,
    );
    final iOSChannelSpecifics = IOSNotificationDetails(presentSound: false);

    return NotificationDetails(androidChannelSpecifics, iOSChannelSpecifics);
  }

  Future showSilentNotification(
      FlutterLocalNotificationsPlugin notifications, {
        @required String title,
        @required String body,
        int id = 0,
      }) =>
      _showNotification(notifications,
          title: title, body: body, id: id, type: _noSound);

  NotificationDetails get _ongoing {
    final androidChannelSpecifics = AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      'your channel description',
      importance: Importance.Max,
      priority: Priority.High,    
      ongoing: false,
      autoCancel: false,
    );
    final iOSChannelSpecifics = IOSNotificationDetails();
    return NotificationDetails(androidChannelSpecifics, iOSChannelSpecifics);
  }

  Future showOngoingNotification(
    FlutterLocalNotificationsPlugin notifications, {
    @required String title,
    @required String body,
    int id = 0,
  }) =>
      _showNotification(notifications,
          title: title, body: body, id: id, type: _ongoing);

  Future _showNotification(
    FlutterLocalNotificationsPlugin notifications, {
    @required String title,
    @required String body,
    @required NotificationDetails type,
    int id = 0,
  }) =>
      notifications.show(id, title, body, type);

  Future onSelectNotification(
    FlutterLocalNotificationsPlugin notifications, {
    @required Function function,
    @required ConnectMqtt connectMqtt,
  }) =>
      _onSelectNotification(
        notifications,
        function: function,
        connectMqtt: connectMqtt
      );  
  
  Future _onSelectNotification(FlutterLocalNotificationsPlugin notifications,
                {Function function, ConnectMqtt connectMqtt }){
    print('teste');
  }



}