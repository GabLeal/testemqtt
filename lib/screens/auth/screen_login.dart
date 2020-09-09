import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:prevent/models/stream_microfone_model.dart';
import 'package:prevent/models/login_model.dart';
import 'package:prevent/screens/auth/screen_login_facial.dart';
import 'package:prevent/screens/pesquisa/screen_pesquisa.dart';
import 'package:prevent/style.dart';
import 'package:masked_text/masked_text.dart';
import 'package:string_validator/string_validator.dart';
import 'dart:async';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:prevent/models/pessoa_model.dart';


class Tela_login extends StatefulWidget {
  @override
  _Tela_loginState createState() => _Tela_loginState();
}

class _Tela_loginState extends State<Tela_login> {

  final RoundedLoadingButtonController _btnController = new RoundedLoadingButtonController();
  TextEditingController _controller_cpf = TextEditingController();
  TextEditingController _controller_senha = TextEditingController();
  String stream_text;
  var status_login;
  int _micColor = 0;

  @override
  void initState() {

  }

  void _logon()async{

    Login login = new Login(whitelist(_controller_cpf.text, '0,1,2,3,4,5,6,7,8,9'));
    status_login = await login.realizar_login();

    if(status_login == 1){
      print('Credenciais inválidas...');
      print(status_login);
      //Erro ao realizar login
      _btnController.error();
      Timer(Duration(seconds: 3), () {
        _btnController.reset();
      });
    }else if(status_login == 0) {
      print(status_login);
      print('Tentando novamente...');
      _logon();
    }else{
      //Sucesso ao relizar login
      _btnController.success();
      print('Sucesso ao realizar o login...');
      print(status_login);

      /*Envia para a tela Home o objeto do tipo pessoa contendo as
      informações do usuário que acabou de realizar o login no sistema*/

      Pessoa usuario_logado;
      usuario_logado = status_login;
      print('Bem vindo, ' + usuario_logado.tx_nome.toString());

      Timer(Duration(seconds: 3), () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Pesquisa(usuario_logado)));
      });
    }
  }

  Widget login_cpf(){
    
    var largura = MediaQuery.of(context).size.width;
    var altura = MediaQuery.of(context).size.height;

    return SafeArea(
        child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          margin: EdgeInsets.all(((MediaQuery.of(context).size.height/100)*5)/2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.asset('assets/logo.png', width: largura/1.2,),
                      
                      Text(
                        'Para começar, segure no microfone e fale seu CPF, ou digite - o',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: (altura/100)*4.3,
                          color: Colors.white,
                        ),
                      ),

                      microfone(
                        onLongPressStart: (data) async {
                          setState(() {
                            _micColor = 1;
                          });
                              
                          StreamFala().iniciaStream();
                        },
                        onLongPressEnd: (data) async {
                          setState(() {
                            _micColor = 2;
                          });
                                
                          stream_text = await StreamFala().pararStream();
                             
                          setState(() {
                            _controller_cpf.text = stream_text;
                            _micColor = 0;
                          });
                        }
                      ),

                      Theme(
                        data: ThemeData(hintColor: Colors.white),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 25, wordSpacing: 5.2),
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white, width: 1),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white, width: 1),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            labelText: 'CPF',
                            labelStyle: TextStyle(color: Colors.white),
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                  style: BorderStyle.solid,
                                  width: ((altura)/100)*4.3,
                                  color: Colors.white),
                            ),
                          ),

                          controller: _controller_cpf, //Controller responsável por armazenar o documento digitado
                        ),
                      ),

                      RoundedLoadingButton(
                        child: Text(
                          'Entrar',
                          style: TextStyle(
                            fontSize: (largura/100)*5,
                            color: Style.azul_prevent
                          )
                        ),
                          controller: _btnController,
                          onPressed: _logon,
                          color: Colors.white,
                          valueColor: Style.azul_prevent,

                      ),
                      Image.asset('assets/manuel.png', width: 20,),
                    ],
                  ),
          )
        )
    );
  }

  Widget microfone({onLongPressStart, onLongPressEnd}){
    return Stack(
      children: <Widget>[
        Container(
           width: 105,
          height: 105,
          decoration: BoxDecoration(
            color: _micColor == 1 ? Colors.green : _micColor == 0 ? Colors.white.withOpacity(0.1) : Colors.red,//Color(0xff7BB5D5),
            shape: BoxShape.circle
          ),
        ),
        Positioned(
          left: 7.5,
          top: 7.5,
          width: 90,
          height: 90,
          child: GestureDetector(
            child: Image.asset('assets/mic.png'),
              onLongPressStart: onLongPressStart,   
              onLongPressEnd: onLongPressEnd
          ),
        ),
      ],
    );
  }

  PageController _controller = new PageController(initialPage: 0, viewportFraction: 1.0);
  
  @override
  Widget build(BuildContext context) {

    double largura = MediaQuery.of(context).size.width;
    double altura = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async => false,
      child: MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
              child: Container(
              height: altura,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xff041222), Color(0xff022346)]
                )
              ),
              child: PageView(
                controller: _controller,
                children: <Widget>
                  [login_cpf(), LoginFacial()],
              ),
            ),
          ),
        ),
      ),
    );
  }
} 
