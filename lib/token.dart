import 'package:prevent/global.dart' as glob;
import 'package:dio/dio.dart' as dio;
import 'dart:convert';
import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:prevent/local_storage.dart';

class Token{

  String token;

  dio.Response response;
  dio.Dio http = dio.Dio();
  FlutterSecureStorage storage = new FlutterSecureStorage();

  void initState() {
    gera_token();
    token_future();
  }

  Future<String>token_future() {
    Future.delayed(Duration(seconds: 240), (){
      gera_token();
      token_future();
    });
  }

  Future<String>buscaToken()async{
    if(this.token == null){
      await gera_token();
    }
  }
  
  
  Future gera_token()async{      
    try{
      response = await http.post(
        "${glob.link_private}token_api_manuel",
        options: dio.Options(
          validateStatus: (status) {
            return status < 500;
          },
          headers: {
            'cdparceiro': 395,
            'chave_primaria': await storage.read(key: 'key')
          }
        )
      );

      dynamic token_api = json.decode(response.data);
      //print(token_api['msg']);

      
      glob.token = token_api['msg'];
      this.token = token_api['msg'];

     
    

    }catch(e){
      print('Erro ao gerar token da API' + e.toString());
    }
  }
}
