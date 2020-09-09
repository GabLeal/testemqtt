import 'package:flutter/material.dart';
import 'package:prevent/mqttConn/mqttConnControlClass.dart';



class MqttConnPageTest extends StatefulWidget {
  @override

  _ConnStatus createState() => new _ConnStatus();
}

class _ConnStatus extends State<MqttConnPageTest> {
  ///O client
  MqttConnControlClass connDemo = MqttConnControlClass("manuelmobile", "123", randomId: false);

  ///Variaveis para controle de textField
  TextEditingController ctrltxtUsername = TextEditingController();
  TextEditingController ctrltxtPassword = TextEditingController();
  TextEditingController ctrltxtSubscribeTopic = TextEditingController();
  TextEditingController ctrltxtMessage = TextEditingController();

  ///Variaveis para controle de log
  String txtListenerLastReceivedMessage = '';
  String txtListenerConnectionStatus = '';
  String txtListenerLastPublishedMessage = '';
  String txtListenerSubscribeStatus = '';
  String txtListenerLog = '<<LOG>>\n<<ATENCAO>>\nEssa é uma pagina de testes.\nNao foram tratadas excecoes.\nNao clicar em Start caso nao tenha um username e password.\nNao tentar startar mais do que uma vez.';

  @override
  initState(){
    super.initState();
  }

  ///log para que seja tratado todos eventos que ocorrem com o _client.
  void _listenerCliente(){
    int code = connDemo.listenerCode;
    print('log - listenerClient heard code [$code]');
    String temp = '';
    switch(code){
      case 0:
      ///trata status de conexao
        txtListenerConnectionStatus = connDemo.listenerStatusClient;
        temp = txtListenerLog;
        txtListenerLog = txtListenerConnectionStatus + "\n" + temp;
        break;
      case 1:
      ///trata subscricao
        txtListenerSubscribeStatus = connDemo.listenerSubscriptionsClient;
        temp = txtListenerLog;
        txtListenerLog = txtListenerSubscribeStatus + "\n" + temp;
        break;
      case 2:
      ///trata mensagem recebida
        txtListenerLastReceivedMessage = connDemo.listenerReceivedLastMessage;
        temp = txtListenerLog;
        txtListenerLog = txtListenerLastReceivedMessage + "\n" + temp;
        break;
      case 3:
      ///trata mensagem publicada
        txtListenerLastPublishedMessage = connDemo.listenerLastPublishedMessage;
        temp = txtListenerLog;
        txtListenerLog = txtListenerLastPublishedMessage + "\n" + temp;
        break;
    }
    setState(() {
      txtListenerLog + '';
    });
    print('-----------DEVICE LOG START-----------');
    print(txtListenerLog);
    print('-----------DEVICE LOG END-----------');
  }

  Widget build(BuildContext context) {

    /**
        ///Textfield para recer username
        final txtUsername = TextField(
        obscureText: false,
        controller: ctrltxtUsername,
        decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "USERNAME",
        border:
        OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
        );
        ///Textfield para receber password
        final txtPassword = TextField(
        obscureText: false,
        controller: ctrltxtPassword,
        decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "PASSWORD",
        border:
        OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
        );
     */

    //Textfield para subscrever em topico
    final txtSubscribeTopic = TextField(
      obscureText: false,
      controller: ctrltxtSubscribeTopic,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "SUBSCRIBE TOPIC",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    ///TextField para receber Messagem a ser publicada
    final txtMessage = TextField(
      obscureText: false,
      controller: ctrltxtMessage,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "MESSAGE",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    ///Botao para criar, connectar e subscrever o cliente.
    ///Ao crir um cliente, ele é conectado automaticamente.
    ///Nao tentar criar o cliente multiplas vezes, a excecao nao foi tratada pois esse é apenas um teste.
    final btnCreateClient = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          print("loghj> clicado.");
          txtListenerLog = '<<LOG>>';
          connDemo.addListener(_listenerCliente);
          try {
            await connDemo.connectClient();
          } catch (e) {
            print("Could not connect, e [$e]");
          }
          try{
            connDemo.subscribeClient("demo/topic");
          }catch (e){
            print('Could not subscribe, e[$e]');
          }
          //it already checks if the client is connected...
          try{
            connDemo.publishClient("demo/topic", "This is a sample message from START");
          }catch (e){
            print ("could not publish, e[$e]");
          }
          print("loghj> fim do clicado.");
        },
        child: Text("Start (Connect subscribe and publish client)",
          textAlign: TextAlign.center,
        ),
      ),
    );

    final btnSubscribeTopic = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {connDemo.subscribeClient(ctrltxtSubscribeTopic.text);},
        child: Text("Subscribe to topic",
          textAlign: TextAlign.center,
        ),
      ),
    );

    final btnPublishMessage = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {connDemo.publishClient("demo/topic", ctrltxtMessage.text);},
        child: Text("Publish message",
          textAlign: TextAlign.center,
        ),
      ),
    );

    final btnStatusClient = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          String temp = txtListenerLog ;
          txtListenerLog = ">>" +connDemo.statusClient() + "\n" + temp;
          setState(() {
            txtListenerLog + '';
          });
        },
        child: Text("Criar 2° Cliente. 2° Clique subscribe t/2/",
          textAlign: TextAlign.center,
        ),
      ),
    );

    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                txtSubscribeTopic,
                SizedBox(height: 15.0),
                txtMessage,
                SizedBox(
                  height: 35.0,
                ),
                btnCreateClient,
                SizedBox(height: 10.0),
                btnSubscribeTopic,
                SizedBox(height: 10.0),
                btnPublishMessage,
                SizedBox(height: 10.0),
                btnStatusClient,
                SizedBox(height: 10.0),
                new Expanded(
                  flex: 1,
                  child: new SingleChildScrollView(
                    child: new Text(txtListenerLog ,
                      style: new TextStyle(
                        fontSize: 16.0, color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}