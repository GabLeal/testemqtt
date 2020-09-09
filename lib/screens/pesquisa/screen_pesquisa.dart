import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:prevent/models/mqtt/connect_mqtt_model.dart';
import 'package:prevent/models/stream_microfone_model.dart';
import 'package:prevent/models/pessoa_model.dart';
import 'package:prevent/models/busca_questoes_model.dart';
import 'package:prevent/models/questionario_model.dart';
import 'package:prevent/Widgets/botoes.dart';
import 'package:prevent/Widgets/cabecalho.dart';
import 'package:prevent/Widgets/microfone.dart';
import 'package:prevent/Widgets/pergunta.dart';
import 'package:prevent/constantes.dart';
import 'package:prevent/local_storage.dart';
import 'package:prevent/models/mensagem_model.dart';
import 'package:prevent/screens/agenda/screen_agenda_menu.dart';
import 'package:prevent/screens/chat/screen_chat_menu.dart';
import 'package:prevent/stores/home_store.dart';
import 'package:prevent/stores/questionario_store.dart';
import 'package:prevent/style.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

import '../../local_notifications.dart';

class Pesquisa extends StatefulWidget {

  Pessoa usuario_logado;
  Pesquisa(this.usuario_logado);

  @override
  _PesquisaState createState() => _PesquisaState();
}

class _PesquisaState extends State<Pesquisa> with TickerProviderStateMixin {

  static const List<IconData> icons = const [ Icons.sms, Icons.search ];

  AnimationController _controller;
  HomesStore homesStore = HomesStore();
  TextEditingController textEditingController;
  ConnectMqtt connectMqtt = ConnectMqtt();

  var nr_cpf_md5;
  BuscaQuestoes quest = BuscaQuestoes();

  @override
  void initState(){
    super.initState();
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    seta_variaveis();
    quest.getQuestao();
    textEditingController = TextEditingController();
    
    //notificação config
    var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(initializationSettingsAndroid, initializationSettingsIOS);
    
    final notifications = FlutterLocalNotificationsPlugin();
    notifications.initialize(initializationSettings,
      onSelectNotification: onSelectNotification, 
    );
    //iniciando mqttt
    //widget.usuario_logado.id_pessoa
    connectMqtt.conect(widget.usuario_logado.id_pessoa);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
  }

  Future onSelectNotification(String payload) async{
    connectMqtt.enviarFilaMqtt('/manuelconsumer/dev/publish/', true);
  }

  //teste
  // void teste() async{
  //   final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  //   var androidPlatformChannelSpecifics =
  //     AndroidNotificationDetails('repeating channel id',
  //         'repeating channel name', 'repeating description',
  //               importance: Importance.Max,
  //     priority: Priority.High,    
  //     ongoing: true,
  //     autoCancel: false
  //         );
  //   var iOSPlatformChannelSpecifics =
  //     IOSNotificationDetails();
  //   var platformChannelSpecifics = NotificationDetails(
  //     androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  //   await flutterLocalNotificationsPlugin.periodicallyShow(0, 'repeating title',
  //     'repeating body', RepeatInterval.EveryMinute, platformChannelSpecifics, );
  // }
  //teste

  void seta_variaveis(){
    nr_cpf_md5 = md5.convert(utf8.encode(widget.usuario_logado.nr_cpf_cnpj.toString()));
  }

  bool status = false;

  @override
  Widget build(BuildContext context) {

    dynamic nome_aux = widget.usuario_logado.tx_nome.toString().split(" ");

    var largura = MediaQuery.of(context).size.width;
    var altura = MediaQuery.of(context).size.height;

    const double larg = 80;
    
    Style.fonte_tamanho_padrao = largura/28;

    

  return Container(
    decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xff041222), Color(0xff022346)]
        )
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Container(
              height: (altura/1.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  cabecalho(largura: largura, altura: altura, nome: nome_aux[0].toString(), nrCpfMd5: nr_cpf_md5, context: context),
                  pergunta(largura: largura, altura: altura, buscaQuestoes: quest),
                  Container(
                    child: Column(
                      children: <Widget>[
                        botoes(largura: largura , altura: altura, buscaQuestoes: quest, textEditingController: textEditingController),
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Observer(
                            builder: (_){
                               return Text(homesStore.lastWords, style: TextStyle(color: Colors.white));
                            },
                          ),
                        ),
                        //microfone(homesStore, quest),
                        utilizarVoz(homesStore, quest, largura)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: Padding(
            padding: EdgeInsets.only(right: largura/1.28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: new List.generate(icons.length, (int index) {
                Widget child = new Container(
              height: 70.0,
              width: 56.0,
              alignment: FractionalOffset.topCenter,
              child: new ScaleTransition(
                scale: new CurvedAnimation(
                  parent: _controller,
                  curve: new Interval(
                    0.0,
                    1.0 - index / icons.length / 2.0,
                    curve: Curves.easeOut
                  ),
                ),
                child: new FloatingActionButton(
                  heroTag: null,
                  backgroundColor: Color(0xff041222),
                  mini: true,
                  child: new Icon(icons[index], color: Colors.white),
                  onPressed: () {
                    if(index == 0){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ChatMenu()));
                    }else if(index == 1){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AgendaMenu()));
                    }
                  },
                ),
              ),
            );
            return child;
        },).toList()..add(
            new FloatingActionButton(
              backgroundColor: Color(0xff041222),
              heroTag: null,
              child: new AnimatedBuilder(
                animation: _controller,
                builder: (BuildContext context, Widget child) {
                  return new Transform(
                    transform: new Matrix4.rotationZ(_controller.value * 0.5 * math.pi),
                    alignment: FractionalOffset.center,
                    child: new Icon(_controller.isDismissed ? Icons.keyboard_arrow_up : Icons.close),
                  );
                },
              ),
              onPressed: () {
                if (_controller.isDismissed) {
                  _controller.forward();
                } else {
                  _controller.reverse();
                }
              },
            )
            )
        ),
          ),
      ),
    )
  );
  }
}
