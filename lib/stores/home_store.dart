
import 'package:mobx/mobx.dart';
import 'package:prevent/models/stream_microfone_model.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:speech_to_text/speech_recognition_result.dart';

part 'home_store.g.dart';

class HomesStore = _HomesStore with _$HomesStore;

abstract class _HomesStore with Store{

  _HomesStore(){
    autorun((_){
      print(escolhaUusario);
    });
  }

  var statusListener;

  stt.SpeechToText speech = stt.SpeechToText();

  @observable
  String words = '';

  @observable
  bool lastStatus;

  @observable
  int mic = 0;

  @observable
  int speak = 0;

  @action
  startMic()async{
    
    print('Inicia o microfone... MIC:' + mic.toString());
    setMicTrue();
    print('Inicia o microfone... MIC:' + mic.toString());
    

    bool available = await speech.initialize(
        onStatus: statusListener);
        
    if (available) {
      await speech.listen(onResult: resultListener);
    } else {
      print("O usuário negou o uso do reconhecimento de fala");
    }
    
  }

  void resultListener(SpeechRecognitionResult  result)async{  
    words = result.recognizedWords.toString();
    lastStatus = result.finalResult;
    if(ultimoStatus){
      setMicFalse();
    }
  }

  @action
  void setSpeakTrue() => speak = 1;

  @action
  void setSpeakFalse() => speak = 0;

  @action
  void setMicFalse() => mic = 0;

  @action
  void setMicOcupado() => mic = 2;

  @action
  void setMicTrue() => mic = 1;

  @computed
  String get lastWords => words;

  @computed
  bool get ultimoStatus => lastStatus == true && mic != 0;

  @computed
  bool get isButtonPressed => mic == 1; 

  @computed
  bool get isMicProcessed => mic == 2; 

  @observable
  bool utilizarVoz = true;

  @action
  void setVoz(){
    words = '';
    utilizarVoz = !utilizarVoz;
    if(utilizarVoz == false && mic == 1){
      setMicFalse();
    }
  }

  @computed
  bool get isVozActive => utilizarVoz == true;

  @observable
  int escolhaUusario;

  @action
  void setEscolha(int value){
    escolhaUusario = value;
    print('A NOVA ESCOLHA É: ' + escolhaUusario.toString());

  }

  @computed
  int get getEscolha => escolhaUusario;





}
