import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:mqtt_client/mqtt_client.dart';

/// Classe para conexao com o Mosquitto.
/// Foi utilizado a biblioteca mqtt_client.
///
/// Para garantir que o cliente receba as mensagens, em topicos já subscritos, que perdeu por estar offline,
/// tenha certeza de iniciar uma conexão NOT CLEAN. A outra exigencia é que o ID do usuario seja o mesmo.
/// Por padrao, a classe ja define que o IDENTIFICADOR é broker/username, entao basta informar o mesmo username.
/// A classe aceita n instancias.
///
/// Para controlar o cadastro em topicos, utiliza-se o ID da conexao, e nao o username/password.
/// Voce pode ter n devices conectados com o mesmo user/password/id (o id pode ser diferente para mesmas combinaçoes de user/password),
/// onde cada um recebera as mensagens dos respectivos topicos cadastrados em seus devices.
/// Para recebimento de mensagens, inclusive mensagens nao lidas por estar offline, o device/id deve estar subscrito ao topico desejado, e uma conexão
/// NOT clean deve ser estabelecida.

class MqttConnControlClass extends ChangeNotifier{
  MqttClient client;
  String _username, _password;
  bool _randomId;
  int _listenerCode = -1;
  String _listenerReceivedLastMessage = '';
  String _listenerStatusClient = '';
  String _listenerSubscriptionsClient = '';
  String _listenerLastPublishedMessage = '';

  MqttConnControlClass(String username, String password, {String broker = "manuelvaiotbr.brazilsouth.cloudapp.azure.com", bool randomId = true}){
    client = MqttClient.withPort(broker, '', 1883);
    client.logging(on: false);
    client.keepAlivePeriod = 20;
    client.setProtocolV311();
    client.useWebSocket = false;
    client.secure = false;
    client.onDisconnected = onDisconnected;
    client.onConnected = onConnected;
    client.onSubscribed = onSubscribed;
    client.pongCallback = pong;
    client.onSubscribeFail = onSubscribeFail;
    this._randomId = randomId;
    this._username = username;
    this._password = password;
    ///Caso queira, eh possivel gerar o id randomicamente, uma cominacao de 10 numeros no range 00 - 99, inclusivo.
    if(randomId){
      var rng = new Random();
      var randomList = new List.generate(10, (_) => rng.nextInt(100));
      String generatedId = '';
      for(final i in randomList){
        generatedId = generatedId + '$i';
      }
      client.clientIdentifier = ('$generatedId');
    }else{
      client.clientIdentifier = ('$broker/$username');
    }
  }

  /// Um listener para tratar todos eventos e ser acessivel externamente.
  void _constructListener(int code, String payload){
    listenerCode = code;
    print('log - construcListener code[$code] - payload [$payload]');
    switch(code){
      case 0:
      ///trata status de conexao
        listenerStatusClient = "CON>" +payload+ " [" +client.connectionStatus.state.toString()+ "] - ID [" +client.clientIdentifier+ "]";
        break;
      case 1:
      ///trata subscricao
        listenerSubscriptionsClient = "SUB>" + payload;
        break;
      case 2:
      ///trata mensagem recebida
        //listenerReceivedLastMessage = "REC>" + payload;
        listenerReceivedLastMessage =  payload;
        break;
      case 3:
      ///trata mensagem publicada
        listenerLastPublishedMessage = "PUB>" + payload;
        break;
    }
    notifyListeners();
  }

  /// The onSubscribed callback
  void onSubscribed(String topic) {
    _constructListener(1, 'Callback>Cliente Subscrito ao [$topic]');
    print('log - onSubscribed client callback - cliente subscrito com sucesso');
  }

  void onSubscribeFail(String topic) {
    _constructListener(1, 'Callback>Cliente NAO subscrito ao [$topic]');
    print('log - onSubscribedFail client callback - cliente NAO subscrito');
  }

  /// The unsolicited disconnect callback
  void onDisconnected() {
    _constructListener(0, 'Callback>Cliente desconectado');
    print('log - OnDisconnected client callback - O cliente perdeu a conexao inesperadamente');
    connectClient();
    if (client.connectionStatus.returnCode == MqttConnectReturnCode.solicited) {
      print('log - OnDisconnected client callback - O cliente solicitou a desconexão');
    }
  }



  void onReceivedMessageCB(String message){
    _constructListener(2, '$message');
    print('log onReceivedMessage client callback - Mensagem [$message] recebida');
  }

  void onPublishMessageCB(String message){
    _constructListener(3, 'Callback>Mensagem publicada [$message]');
    print('log onPublishMessage client callback - Mensagem [$message]');
  }

  /// The onConnect callback
  void onConnected() {
    _constructListener(0, 'Callback>Cliente conectado');
    print('log onConnected client callback - Cliente conectado com sucesso.');
    ///listener para updates nos topicos em que o cliente está subscrito.
    client.updates.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage recMess = c[0].payload;
      final String pt =
      MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      print('log - client.updates Mensagem recebida [$pt] | Topico [${c[0].topic}]');
      onReceivedMessageCB(pt);
    });
  }

  /// Pong callback
  void pong() {
  //print('log - Ping response client pong callback invoked');
  }

  ///Conencta o cliente.
  Future<int> connectClient() async {
    if((client.connectionStatus.state==MqttConnectionState.disconnected)){
      print('log - connectClient - Conectando cliente com id[' +client.clientIdentifier+ '] user [$_username] pass [$_password]...');
      try {
        await client.connect(_username, _password);
        return 0;
      } on Exception catch (e) {
        _constructListener(0, 'connectClient>Cliente nao conectado, excep: [$e]');
        print('log - connectClient - Cliente nao conectado, excep: [$e]');
        client.disconnect();
        return -1;
      }
    }else {
      throw GradeException("Exception orging: connectClient. Message: [O cliente esta ocupado com a conexao... Status" + client.connectionStatus.state.toString() +"].");
    }
  }

  bool isConnected(){
    if(client.connectionStatus.state!=MqttConnectionState.connected) {
      return false;
    }
    return true;
  }

  ///publicar mensagem a um topico especifico.
  void publishClient(String topic, String message) {
    if(isConnected()){
      print('log - publishClient - Publicando...');
      final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
      builder.addString(message);
      try {
        client.publishMessage(topic, MqttQos.atLeastOnce, builder.payload, retain: false);
        //onPublishMessageCB('Sucesso mensagem [$message]');
      }  on Exception catch (e) {
        String falha = 'Falha ao publicar em topico [$topic] | mensagem [$message] | excecao [$e]';
        //onPublishMessageCB(falha);
      }
    }else{

      throw GradeException("Exception orging: publishClient. Message: [O cliente precisa estar conectado para publicar] Status [" +client.connectionStatus.state.toString()+ "]");
    }
  }

  ///Subscreva ao topico especifico
  subscribeClient(String subscribeTopic) {
    if(isConnected()) {
      print('log - Subscrevendo cliente...');
      try {
        client.subscribe(subscribeTopic, MqttQos.atLeastOnce);
      } on Exception catch (e) {
        print(
            'log - subscribeClient - Falha ao subscrever ao topico [$subscribeTopic] | excecao [$e]');
      }
    }else{
      throw GradeException("Exception orging: subscribeClient. Message: [O cliente precisa estar conectado para subscrever].");
    }
  }

  unsubscribeClient(String unsubTopic){
    print('log - Desescrevendo cliente...');
    try {
      client.unsubscribe(unsubTopic);
      _constructListener(1, 'unsubscribeClient>Cliente desubscrito [$unsubTopic]');
    }on Exception catch (e){
      print('log - subscribeClient - Falha ao desescreverao topico [$unsubTopic] | excecao [$e]');
      _constructListener(1, 'unsubscribeClient>Cliente NAO desubscrito [$unsubTopic]');
    }
  }

  void disconnectClient(){
    client.disconnect();
    print('log - disconnectClient - Solicitado desconexao do cliente');
    _constructListener(0, 'disconnectClient>Solicitado desconexao do cliente');
  }

  String statusClient(){
    print('log - statusClient - Solicitado status do cliente');
    _constructListener(0, 'statusClient>Solicitado status do cliente');
    return client.connectionStatus.toString();
  }

  String get listenerReceivedLastMessage => _listenerReceivedLastMessage;

  set listenerReceivedLastMessage(String value) {
    _listenerReceivedLastMessage = value;
  }

  String get listenerStatusClient => _listenerStatusClient;

  set listenerStatusClient(String value) {
    _listenerStatusClient = value;
  }

  String get listenerSubscriptionsClient => _listenerSubscriptionsClient;

  set listenerSubscriptionsClient(String value) {
    _listenerSubscriptionsClient = value;
  }

  String get listenerLastPublishedMessage => _listenerLastPublishedMessage;

  set listenerLastPublishedMessage(String value) {
    _listenerLastPublishedMessage = value;
  }

  int get listenerCode => _listenerCode;

  set listenerCode(int value) {
    _listenerCode = value;
  }
}

class GradeException implements Exception {
  String message;

  GradeException(this.message);

  String error() {
    return message;
  }
}
