import 'package:mobx/mobx.dart';
import 'package:prevent/models/busca_questoes_model.dart';
part 'questionario_store.g.dart';

class QuestionarioStore = _QuestionarioStore with _$QuestionarioStore;

abstract class _QuestionarioStore with Store{

  _QuestionarioStore(){
    autorun((_){
     print('FALA: ' + fala.toString());
    });
  }

  @observable
  String pergunta = '';

  @action
  void setPergunta(String value) => pergunta = value;

  @computed
  String get getPergunta => pergunta;

  @observable
  String sessionId;

  @action
  void setsessionId(String value) => sessionId = value;

  @computed
  String get getsessionId => sessionId;

  @observable
  String fluxo;

  @action
  void setFluxo(String value) => fluxo = value;

  @computed
  String get getFluxo => fluxo;

  @observable
  String botao;

  @action
  void setBotao(String value) => botao = value;

  @computed
  String get getBotao => botao;

  @observable
  dynamic alternativas;
  
  @action
  void setAlternativas(dynamic value) => alternativas = value;

  @computed
  dynamic get getAlternativas => alternativas;

  @observable
  bool continuaConversa;

  @action
  void setcontinuaConversa(bool value) => continuaConversa = value;

  @computed
  bool get getcontinuaConversa => continuaConversa;

  @observable
  String resposta;

  @action
  void setResposta(String value){
    resposta = value;
    
  }

  @computed
  String  get getResposta => resposta;

  @observable
  bool buttonBlock = false;

  @action
  void setButtonBlock(bool value) => buttonBlock = value;

  @computed
  bool get getButtonBlock => buttonBlock;

  @observable
  bool fala = true;

  @action
  void setFala() => fala = !fala;

  @computed
  bool get getFala => fala;

}
