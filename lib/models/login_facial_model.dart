
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:prevent/global.dart' as glob;
import 'package:prevent/local_storage.dart';

class LoginFacialAuth{
  dynamic erro;

  busca_facial(String imagem_path, context)async{
    if(glob.token == null){

        erro = {
          "codigo": 404,
          "mensagem": "Verifique sua conexão com a internet"
        };

        print(erro);

        return erro;
      }else{
        try{
          Response response;
          Dio http = new Dio();

          print('DIRETÓRIO IMAGEM: ' + imagem_path);

          var bytes = await new File(imagem_path).readAsBytes();
          String imgBase64 = base64.encode(bytes);

          final Map<String, dynamic> novaFace = {
            'img': imgBase64,
            'emocoes': 0,
            'mobile': 1
          };

          //FormData formData = new FormData.from(novaFace);

          http.options.headers['Content-Type'] = 'application/json';
          //http.options.headers['token'] = glob.token.toString();
          //http.options.headers['cdparceiro'] = 395;
          response = await http.post('${glob.link_private}comparaImg',
              data: {
                'img': imgBase64,
                'emocoes': 0,
                'mobile': 1
              },
          );

          return response.data[0];
      
          //print(formData);
          //print(response.data);

          //print(response.data.toString()); 
          }catch (e){
            
            erro = {
              "codigo": 405,
              "mensagem": "Não estou te reconhecendo"
            };

            print(erro);

            return erro;
          }
      }  
  }
}
