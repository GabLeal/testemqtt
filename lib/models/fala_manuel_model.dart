import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';

class Fala{

  AudioPlayer audioPlayer = new AudioPlayer();
  Response response;


  Future<AudioPlayer> fala()async{

    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path + '/falaManuel.mp3';
    File file = File(tempPath);

    print('DIRETÓRIO: ' + tempPath.toString());

    RandomAccessFile raf = file.openSync(mode: FileMode.write);
    
    raf.writeFromSync(response.data);
    //print(response.data);
    await raf.close();
    await audioPlayer.play(tempPath, isLocal: true);

    return audioPlayer;
  }





}
