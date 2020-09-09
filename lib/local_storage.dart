import 'package:get_storage/get_storage.dart';
import 'package:prevent/models/pessoa_model.dart';
import 'package:string_validator/string_validator.dart' as validator;
import 'dart:convert';

class Local_Storage{

  final box = GetStorage();

  void salvar_pessoa(String pessoa) async{
    await box.write('pessoa', pessoa);
    print('Pessoa armazenada: ' + pessoa.toString());
    return;
  }

  buscar_pessoa()async{
    //print('Pessoa salva: ' + box.read('pessoa').toString());
    //Busca a pessoa salva e transforma ela em um objeto do tipo pessoa

    if(box.read('pessoa') == null){
      return null;
    }else{
      
      Map<String,dynamic> json_salvo  = json.decode(box.read('pessoa').trim());
      Pessoa nova_pessoa = new Pessoa.fromJson(json_salvo);
      print('O CPF DO FULANO É:' + nova_pessoa.nr_cpf_cnpj.toString());
      //retorna o objeto pessoa que está salvo no celular
      return nova_pessoa;
    }
  }

  buscaId()async{
      Map<String,dynamic> json_salvo  = json.decode(box.read('pessoa').trim());
      Pessoa nova_pessoa = new Pessoa.fromJson(json_salvo);
      print('O ID DO FULANO É:' + nova_pessoa.id_pessoa.toString());
      //retorna o objeto pessoa que está salvo no celular
      return nova_pessoa.id_pessoa;
  }

  logout(){
    box.remove('pessoa');
  }

}
