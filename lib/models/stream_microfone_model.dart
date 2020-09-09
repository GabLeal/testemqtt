import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:string_validator/string_validator.dart';

class StreamFala{

  var errorListener, statusListener, resultListener, finalResult;
  stt.SpeechToText speech = stt.SpeechToText();

  iniciaStream()async{
    print('Inicia Stream CPF');

    bool available = await speech.initialize(
        onStatus: statusListener, onError: errorListener);
    if (available) {
      await speech.listen(onResult: await resultListener);
    } else {
      print("O usuário negou o uso do reconhecimento de fala");
    }
  }

  pararStream()async{
    await Future.delayed(Duration(seconds: 3));
    //print('Para Stream CPF');
    //print(speech.lastRecognizedWords.toString());
    return whitelist(speech.lastRecognizedWords.toString(), '0,1,2,3,4,5,6,7,8,9');
  }


  startMic()async{
    print('Inicia o microfone...');

    bool available = await speech.initialize(
        onStatus: statusListener, onError: errorListener);
        
    if (available) {
      await speech.listen(onResult: await resultListener);
    } else {
      print("O usuário negou o uso do reconhecimento de fala");
    }
  }

}
