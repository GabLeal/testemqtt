import 'dart:async';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_isolate/flutter_isolate.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:prevent/models/mqtt/mqtt_model.dart';
import 'package:prevent/models/pessoa_model.dart';
import 'package:prevent/mqttConn/mqttConnPageTest.dart';
import 'package:prevent/screens/auth/screen_login.dart';
import 'package:prevent/screens/auth/screen_login_facial.dart';
import 'package:prevent/screens/pesquisa/screen_pesquisa.dart';

import 'package:prevent/token.dart';
import 'package:prevent/local_storage.dart';
import 'package:get_storage/get_storage.dart';
import 'package:workmanager/workmanager.dart';
import 'package:flutter_isolate/flutter_isolate.dart';
import 'package:prevent/notification.dart' as notif;
import 'package:geolocator/geolocator.dart';

import 'models/mqtt/connect_mqtt_model.dart';
const fetchBackground = "fetchBackground";


void callbackDispatcher() {
  Workmanager.executeTask((task, inputData) async {

    switch (task) {
      case fetchBackground:

            notif.Notification notification = new notif.Notification();
            notification.showNotificationWithoutSound("TEXTO DE TESTE");
            ConnectMqtt connectMqtt = ConnectMqtt();
            connectMqtt.conect('631');

        break;
    }
    return Future.value(true);
  });
}

void main() async{


  //Android only (see below)

  await GetStorage.init();
  runApp(MaterialApp(
    home: MqttConnPageTest(),
    theme: ThemeData(
        primaryColor: Color(0xff022346),
        accentColor: Color(0xff022346),
        toggleableActiveColor: Colors.black
    ),

  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override

  void initState() {
    super.initState();
    Token().initState();
    _desabilitarRotacao();
    getloguindaata();
    background();
  }
  void background() async{

    Workmanager.initialize(
      callbackDispatcher,
      isInDebugMode: true,
    );

    Workmanager.registerPeriodicTask(
      "1",
      fetchBackground,
      frequency: Duration(minutes: 15),
    );

  }
  void _desabilitarRotacao() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  getloguindaata() async {

    dynamic usuario_armazenado = await Local_Storage().buscar_pessoa();

    if (usuario_armazenado == null) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Tela_login()));
      await LoginFacial().loadImagem();
    } else {

      print(usuario_armazenado.toString());

      Pessoa usuario_logado;
      usuario_logado = usuario_armazenado;
      print('Seja bem vindo, ' + usuario_logado.tx_nome.toString());

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Pesquisa(usuario_logado)),
      );
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Color(0xff022346),
            child: Center()
        )
    );
  }
}


