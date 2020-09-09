
import 'package:mobx/mobx.dart';
import 'package:prevent/models/stream_microfone_model.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:speech_to_text/speech_recognition_result.dart';

part 'bottomBarStore.g.dart';

class BottomBarStore = _BottomBarStore with _$BottomBarStore;

abstract class _BottomBarStore with Store{

  @observable
  int indexSelecionado = 0;

  @action
  void setIndex(int value) => indexSelecionado = value;

  @computed
  int get getIndex => indexSelecionado;



}

