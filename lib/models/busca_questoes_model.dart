import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:prevent/models/fala_manuel_model.dart';
import 'package:prevent/models/questionario_model.dart';
import 'package:prevent/global.dart' as glob;
import 'dart:convert';
import 'package:http/http.dart' as teste;
import 'package:prevent/local_storage.dart';
import 'package:prevent/stores/questionario_store.dart';
import 'package:prevent/token.dart';

class BuscaQuestoes{

  Dio http = Dio();
  AudioPlayer audioPlayer;
  Response response;
  //Questionario questoao = Questionario();
  QuestionarioStore questionarioStore = QuestionarioStore();
  Token token = Token();

  dynamic idPessoa;


  getQuestao()async{
    try{
      
      print('A FALA ESTÁ ATIVA????? >>>>>>>>>>>>>> ' + questionarioStore.getFala.toString());

      idPessoa = await Local_Storage().buscaId();
      print('O ID É: ' + idPessoa.toString());


      if(glob.token == null){
        await token.gera_token();
      }
    
      print('O token global no getQuestao é: ' + glob.token.toString());
      //http.options.headers['token'] = glob.token.toString();
      //http.options.headers['cdparceiro'] = 395;
      response = await http.post(
        '${glob.link}toxicidadePreventSenior/verifica/fluxo',
      data: {
        "cdusuario" : idPessoa
      }
      );

      dynamic fluxo = json.decode(response.data);

      print(fluxo['fluxo']);

      final Map<String, dynamic> texto = {
        'texto': fluxo['fluxo']
      };

      FormData formData = new FormData.fromMap(texto);

      //http.options.headers['token'] = glob.token.toString();
      //http.options.headers['cdparceiro'] = 395;
      http.options.headers['cdusuario'] = idPessoa;
      http.options.headers['modo'] = 'preventsenior';
      http.options.responseType = ResponseType.bytes;
      response = await http.post(
        '${glob.link_private}conversa',
        data: formData
      );

      //print(response.data);
      //print(response.headers);
    
      //print(response.headers['sessionid'][0]);

      if(response.headers['visual'] != null){
      dynamic resposta = json.decode(response.headers['visual'][0]);
      //print(resposta);

      questionarioStore.setPergunta(retornaFormatado(resposta['texto']));
      questionarioStore.setBotao(retornaFormatado(resposta['tipo']));
      //questionarioStore.setAlternativas(retornaFormatado(resposta['alternativas']));

      questionarioStore.setPergunta(retornaFormatado(resposta['texto']));
      questionarioStore.setBotao(retornaFormatado(resposta['tipo']));
      print('ALTERNATIVAS: ' + resposta['alternativas'].toString());
      questionarioStore.setAlternativas(resposta['alternativas']);
    }
    
      questionarioStore.setsessionId(response.headers['sessionid'][0]);
      print('SESSION ID: ' + response.headers['sessionid'][0]);

      if(questionarioStore.getFala == true){
        print('Solta a voz manuel...');
        Fala fala = Fala();
        fala.response = response;
        fala.fala();
      }else{
        print('NÃO É PRO MANUEL FALAR');
      }  
      return;    
    }catch (erro){
      print('Erro no GET QUESTÃO: ' + erro);
    }
  }

  void sendResposta(String resp)async{
    try{
          Dio dio = Dio();
    Response res;
    print('ENTREI NO SEND RESPOSTA: RESP>>>' + resp);
    print('O ID É: ' + idPessoa.toString());

    if(glob.token == null){
      await token.gera_token();
    }
    
    final Map<String, dynamic> text = {
      'texto': resp
    };

    FormData data = new FormData.fromMap(text);

    /*print(data);

    print(questionarioStore.getsessionId);
    print(questionarioStore.getPergunta);
    print(questionarioStore.getBotao);
    print(questionarioStore.getAlternativas);*/

    //dio.options.headers['token'] = glob.token.toString();
    //dio.options.headers['cdparceiro'] = 395;
    dio.options.headers['sessionid'] = questionarioStore.getsessionId;
    dio.options.headers['cdusuario'] = idPessoa;
    dio.options.headers['modo'] = 'preventsenior';
    dio.options.headers['app'] = 'true';
    dio.options.headers['Content-Type'] = 'application/x-www-form-urlencoded';
    dio.options.responseType = ResponseType.bytes;
    res = await dio.post(
      '${glob.link_private}conversa',
      data: data,
    );

    print(res.headers);
    String tipo;
    

    if(res.headers['visual'] != null){
      print('O visual é diferente de nulo');
    
    dynamic resposta = json.decode(res.headers['visual'][0]);

    
    print(resposta);
    tipo = retornaFormatado(resposta['tipo']);

    questionarioStore.setPergunta(retornaFormatado(resposta['texto']));
    questionarioStore.setBotao(retornaFormatado(resposta['tipo']));
    print('ALTERNATIVAS: ' + resposta['alternativas'].toString());
    questionarioStore.setAlternativas(resposta['alternativas']);
    
    }

    print(res.headers['continuaconversa'][0]);
    if(res.headers['continuaconversa'][0] == 'true'){
      print('CONTINUA CONVERSA É VERDADEIRO');
    }else{
      print('ENCERRAR A CONVERSA');
      questionarioStore.setPergunta('Obrigado!');
      questionarioStore.setBotao('');
    }
 
    print('\n\nHEADERS RECEBIDO: ' + res.headers.toString());

    print('A FALA ESTÁ ATIVA????? >>>>>>>>>>>>>> ' + questionarioStore.getFala.toString());

    if(questionarioStore.getFala == true){
      Fala voz = Fala();
      voz.response = res;
      audioPlayer = await voz.fala();
      print('voltei pro busca de questões...');

      audioPlayer.onPlayerStateChanged.listen(
        (Data) async {
          if (Data == AudioPlayerState.PLAYING) {
            print('Manuel está falando...');
          } else if (Data == AudioPlayerState.COMPLETED) {
            print('Manuel terminou de falar...');
            print(questionarioStore.getButtonBlock.toString());
            questionarioStore.setButtonBlock(false);
            print('to desbloquenado o butoons');
            questionarioStore.setBotao('');
            questionarioStore.setBotao(tipo);
            print(questionarioStore.getButtonBlock.toString());
          }
        }
      );
    }else{
      print('NÃO É PRO MANUEL FALAR');
      print(questionarioStore.getButtonBlock.toString());
      questionarioStore.setButtonBlock(false);
      print('DESBLOQUEANDO OS BOTÕES');
      questionarioStore.setBotao('');
      questionarioStore.setBotao(tipo);
      print(questionarioStore.getButtonBlock.toString());
    }    
    }catch (erro){
      print('ERRO NO SEND RESPOSTA: ' + erro);
    }
  }

  String retornaFormatado(String texto){
    return utf8.decode(latin1.encode(texto), allowMalformed: true);
  }
}
