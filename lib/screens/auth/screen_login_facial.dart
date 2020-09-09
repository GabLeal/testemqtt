import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;
import 'package:get_storage/get_storage.dart';
import 'package:prevent/Widgets/load_screen.dart';
import 'package:prevent/local_storage.dart';
import 'package:prevent/models/login_facial_model.dart';
import 'package:prevent/models/login_model.dart';
import 'package:prevent/models/pessoa_model.dart';
import 'package:prevent/screens/pesquisa/screen_pesquisa.dart';
import 'package:prevent/style.dart';
import '../../global.dart' as glob;
import 'package:dio/dio.dart' as dio;
import 'dart:convert' show utf8;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'dart:async';


class LoginFacial extends StatefulWidget {
  FlutterSecureStorage armazenamento = new FlutterSecureStorage();

  loadImagem() async {
    ByteData byteData = await rootBundle.load('assets/logo.png');
    ByteBuffer buffer = byteData.buffer;
    Uint8List uint8list = Uint8List.view(buffer);
    List<int> value = uint8list.sublist(28124, 28156).toList();
    await armazenamento.write(key: 'key', value: utf8.decode(value));
  }

  tela_tente_novamente(context, _titulo, _descricao) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            title: Text(
              _titulo,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.white),
            ),
            content: Text(
              _descricao,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
            actions: <Widget>[
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                color: Colors.white,
                child: Text(
                  'Tirar outra foto',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Style.azul_prevent,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
            backgroundColor: Style.azul_prevent,
          );
        });
  }

  @override
  _LoginFacialState createState() => _LoginFacialState();
}

class _LoginFacialState extends State<LoginFacial> {
  CameraController controller; //Classe responsável para estabelecer conexão com a câmera do dispositivo
  List cameras; //Lista de câmeras (geralmente são duas, traseira e frontal)
  int selectedCameraIdx; //Responsável por armazenar o índice de qual câmera o usuário escolheu (0 cam traseira, 1 cam frontal)
  String imagePath; //Salavará o caminho da foto tirada
  String nomeArquivo, diretorioArquivo = '';
  
  /*Função responsável por iniciar a câmera do dispositivo*/
  @override
  void initState() {
    super.initState();

    availableCameras().then((availableCameras) {
      cameras = availableCameras; //Faz parte do câmera plugins, e retorna a lista de câmeras disponíveis no dispositivo
      if (cameras.length > 0) {
        setState(() {
          selectedCameraIdx = 1; //Seleciono a camera 1(frontal)
        });

        _initCameraController(cameras[selectedCameraIdx]).then((void v) {});
      } else {
        print("Sem câmeras disponíveis");
      }
    }).catchError((erro) {
      print('Erro ao iniciar câmeras' + erro);
    });
  }

  Future _initCameraController(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller.dispose();
    }

    controller = CameraController(cameraDescription, ResolutionPreset.high); //Resolution preset é a qualidade da imagem capturada (low, medium e high)

    /*Será chamado quando se alterar entre 
      câmera frontal e traseira*/
    controller.addListener(() {
      if (mounted) {
        setState(() {});
      }
      if (controller.value.hasError) {
        print('Erro ao trocar de câmera ${controller.value.errorDescription}');
      }
    });

    try {
      await controller.initialize();
    } catch (erro) {
      print('Erro ao iniciar câmera ' + erro);
    }

    if (mounted) {
      setState(() {});
    }
  }

  /*Isso retornará um CameraPreview widget se o objeto do controlador for
    inicializado com êxito, ou um Text widget com o rótulo 'Carregando'.
    O CameraPreview widget retornará uma visão da câmera.*/
  Widget _cameraPreview() {
    if (controller == null || !controller.value.isInitialized) {
      return const Text(
        '',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.w900,
        ),
      );
    }

    return AspectRatio(
      aspectRatio: controller.value.aspectRatio,
      child: CameraPreview(controller),
    );
  }

  void _tirarfoto(context) async {
    try {

      io.Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;

      print('temporária: ');
      print(tempDir);

      nomeArquivo = DateTime.now().microsecondsSinceEpoch.toString() + '.png';
      diretorioArquivo = tempPath + '/' + nomeArquivo; //tempPath substitui appDiretorio

      print('DIRETÓRIO: ' + diretorioArquivo);
      print('ARQUIVO: ' + nomeArquivo);

      await controller.takePicture(diretorioArquivo); //Tira a foto
      await _verFoto(context); //Chama a função de ver foto

    } catch (erro) {
      print('Erro ao tira foto: ' + erro);
    }
  }

  /*Função que retorna um alert dialog exibindo
    para o usuário a foto de perfil do mesmo*/
  _verFoto(context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)
            ),
            title: Text(
              'Olhá só, eu disse que você estava um pão!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: (MediaQuery.of(context).size.width/100)*5.6,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            content: Container(
              decoration: new BoxDecoration(
                image: DecorationImage(image: Image.file(io.File(diretorioArquivo)).image, fit: BoxFit.cover,),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            actions: <Widget>[
              /*Botão responsável por  fechar o alert com a foto 
              tirada e liberar para que o usuário tire outra foto*/
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  'Não Gostei',
                  style: TextStyle(
                      fontSize: (MediaQuery.of(context).size.width/100)*5,
                      color: Style.azul_prevent,
                      fontWeight: FontWeight.bold),
                ),
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),

              /*Botão responsável por enviar a imgem para a API da Azure*/
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  'Gostei',
                  style: TextStyle(
                      fontSize: (MediaQuery.of(context).size.width/100)*5,
                      color: Style.azul_prevent,
                      fontWeight: FontWeight.bold),
                ),
                color: Colors.white,
                onPressed: () async {
                  LoadScreen().onLoading('Buscando Rosto', context);
                  dynamic retorno = await LoginFacialAuth().busca_facial(diretorioArquivo, context);
                  print(retorno.toString());

                  if(retorno['codigo'] == 4){
                    Navigator.pop(context);
                    Navigator.pop(context);
                    return LoginFacial().tela_tente_novamente(context, 'Ta com vergonha?', 'Você tem que aparecer na foto pra eu te reconhecer!');
                  } else if(retorno['codigo'] == 5){
                    Navigator.pop(context);
                    Navigator.pop(context);
                    return LoginFacial().tela_tente_novamente(context, 'Quanta gente bonita!', 'Mas eu tenho que reconhecer apenas você, tira uma foto sozinho(a)');
                  }else if(retorno['codigo'] == 404){
                    Navigator.pop(context);
                    Navigator.pop(context);
                    return LoginFacial().tela_tente_novamente(context, 'Atenção', 'Verifique sua conexão com a internet');
                  }else if(retorno['codigo'] == 405){
                    Navigator.pop(context);
                    Navigator.pop(context);
                    return LoginFacial().tela_tente_novamente(context, 'Atenção', 'Não estou te reconhecendo');
                  }else{
                    Navigator.pop(context);
                    String personId = retorno['personId'].toString();
                    String confianca = retorno['confidence'].toString();
                    String cod_usuario = retorno['cd_usuario'].toString();
                    String cpf_usuario = retorno['nr_cpf'].toString();

                    print('Person ID: ' + personId + ' Confiança: ' + confianca.toString() + ' CodUsuário: ' + cod_usuario + 'CpfUsuário: ' + cpf_usuario);
                    if (cpf_usuario.length == 10) {
                      cpf_usuario = '0' + cpf_usuario;
                      print(cpf_usuario);
                    }

                    if (personId.isEmpty) {
                      return LoginFacial().tela_tente_novamente(context, 'Não estou te reconhecendo!', 'Vamos tirar outra foto?');
                    }

                    if (personId.isNotEmpty && double.parse(confianca) >= 0.8000) {

                      Login login = new Login(cpf_usuario);
                      dynamic status_login = await login.realizar_login();

                      if(status_login == 1){
                        print('Credenciais inválidas...');
                      }else{
                        print('Sucesso ao realizar o login...');

                        /*Envia para a tela Home o objeto do tipo pessoa contendo as
                        informações do usuário que acabou de realizar o login no sistema*/
                        Pessoa usuario_logado;
                        usuario_logado = status_login;
                        print('Bem vindo, ' + usuario_logado.tx_nome.toString());
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Pesquisa(usuario_logado)));
                      }
                    }
                  }},
              ),
            ],
            backgroundColor: Style.azul_prevent,
          );
        });
  }

  //Tela do APP
  @override
  Widget build(BuildContext context) {
    //Container responsável pela dimensão e exibição do preview da câmera
    var symetricalRoundedCorners = Container(

        child: ClipOval(
          child: Align(
            heightFactor: 0.3,
            widthFactor: 0.5,
            child: _cameraPreview(),
          ),
        ),
       );

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(((MediaQuery.of(context).size.height/100)*5)/2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.asset('assets/logo.png', height: (MediaQuery.of(context).size.height/8)),
            Text(
              'Se quiser se logar usando sua face',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: ((MediaQuery.of(context).size.height/100)>6.6)?(MediaQuery.of(context).size.height/100)*5:(MediaQuery.of(context).size.height/100)*4, color: Colors.white),
            ),
            Text(
              'Apenas tire uma foto, sorria!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: ((MediaQuery.of(context).size.height/100)>6.6)?(MediaQuery.of(context).size.height/100)*4.4:(MediaQuery.of(context).size.height/100)*4, color: Colors.white),
            ),
            symetricalRoundedCorners,
            Text(
              'Não se preocupe, você está um pão!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: ((MediaQuery.of(context).size.height/100)>6.6)?(MediaQuery.of(context).size.height/100)*4.4:(MediaQuery.of(context).size.height/100)*4, color: Colors.white),
            ),
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              padding: EdgeInsets.only(top: (MediaQuery.of(context).size.width/100)*3.9, bottom: (MediaQuery.of(context).size.width/100)*3.9, right: (MediaQuery.of(context).size.height/100)*14.4, left: (MediaQuery.of(context).size.height/100)*14.4),
              child: Text(
                'Tirar Foto',
                style: TextStyle(fontSize: (MediaQuery.of(context).size.width/100)*5, color: Style.azul_prevent),
              ),
              onPressed: () {
                _tirarfoto(context);
                print('foto tirada');
              },
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }


  

}
