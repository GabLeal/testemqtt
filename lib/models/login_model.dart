import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:prevent/token.dart';
import 'package:prevent/local_storage.dart';
import 'package:prevent/models/pessoa_model.dart';
import 'package:prevent/global.dart' as glob;

class Login{

  String _cpf;
  
  Login(this._cpf);

  verificaToken(){

  }

  realizar_login()async{
    try{
      /*if(glob.token == null){
        int nullo = 0;
          await Future.delayed(Duration(seconds: 10), (){
            if(glob.token == null){
              nullo = 1;
              print('continua nuloooo');
            }
          });
          if(nullo == 1){
              return 1;
            }else{
              return 0;
            }
      }else{*/
        Dio http = Dio();
        Response response;

        print('O TOKEN NA HORA DE REALIZAR O LOGIN É: ' + glob.token.toString());
    
        //http.options.headers['token'] = glob.token.toString();
        //http.options.headers['cdparceiro'] = 395;
        response = await http.get(
          '${glob.link}usuario/cpf/$_cpf',
        );

          var resposta = json.decode(response.data);
          //Salva o json completo que retornou da api no armzenamento local do dispositivo
          Local_Storage().salvar_pessoa(response.data.toString().replaceAll('[', '').replaceAll(']', ''));

          print(resposta.toString());

          Pessoa pessoa = Pessoa(
            resposta['tp_pessoa'],
            resposta['tx_nome'],
            resposta['tx_sobrenome'],
            resposta['nr_cpf_cnpj'],
            resposta['nr_rg'],
            resposta['tx_sexo'],
            resposta['tx_endereco'],
            resposta['nr_endereco'],
            resposta['tx_complemento'],
            resposta['tx_cep'],
            resposta['tx_bairro'],
            resposta['cd_cidade'],
            resposta['tx_estado'],
            resposta['nr_ibge'],
            resposta['dt_nascimento'],
            resposta['dt_cadastro'],
            resposta['tp_tipo_sanguineo'],
            resposta['tx_foto_perfil_caminho'],
            resposta['tx_cidade'],
            resposta['tx_email'],
            resposta['cd_cargo'],
            resposta['tx_cargo'],
            resposta['cd_pessoa'],
          );
          return pessoa;
      //}
    }catch(error){
      print('Erro ao buscar perfil cadastrado: $error');
      return 1;
    }
    
  }


}
