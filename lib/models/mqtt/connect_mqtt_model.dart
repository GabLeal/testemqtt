import 'dart:convert';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:prevent/local_notifications.dart';
import 'package:prevent/models/mqtt/mqtt_model.dart';

class ConnectMqtt {

  final MqttConnControlClass client = MqttConnControlClass("manuelmobile", "123");

  
  final notifications = FlutterLocalNotificationsPlugin();
  LocalNotificationsT localNotifications = LocalNotificationsT();
  var jsonDataMqttNotification;
  void conect(cdPessoa) async {
    print('CONECTANDO A FILA DE VIDEOCALL...');
    client.isConnected();
    client.addListener(_listnerMqtt);
    try {
      await client.connectClient();
      await client.subscribeClient("manuelConsumer/$cdPessoa/publishPrevent");
    } catch (e) {
      print('EXCEÇÃO NO MQTT' + e.toString());
    }
  }

  void _listnerMqtt() async {
    int code = client.listenerCode;
    switch (code) {
      case 0:
        print('CONECTANDO A FILA...');
        break;
      case 1:
        print('SUBSCRITO NA FILA...');
        break;
      case 2:
        print('MESNAGEM RECEBIDA PELO MQTT');
        jsonDataMqttNotification = jsonDecode(client.listenerReceivedLastMessage);
        localNotifications.showOngoingNotification(notifications, title: 'boa tarde', body: jsonDataMqttNotification["title"]);
        enviarFilaMqtt('/manuelconsumer/dev/publish/', false);
        break;
      case 3:
        print('ENVIADO DADOS PELO MQTT');
        break;
    }
  }

  void enviarFilaMqtt(String fila, bool inLeitura, {String cdPessoa}  /*, valor1, valor2, leitura*/) async {
    //DateTime now = DateTime.now();
    // var notification;
    client.addListener(_listnerMqtt);

    try {
      print("/manuelconsumer/publish/teste");
      
        var notification = {
          "tpenvio":"confirmaNotificacao",
          "cd_notificacao": jsonDataMqttNotification["cd_notificacao"],
          "in_leitura": inLeitura,
          "timestamp": DateTime.now().toString()
        };

      print('DADOS DE SENSORES ENVIADOS MANUALMENTE:\n');
      print(json.encode(notification));

      //arrumar aqui
      client.publishClient(fila, json.encode(notification));
    } catch (e) {
      print(e);
    }
  }
}
