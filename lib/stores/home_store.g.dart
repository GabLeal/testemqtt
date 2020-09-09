// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomesStore on _HomesStore, Store {
  Computed<String> _$lastWordsComputed;

  @override
  String get lastWords =>
      (_$lastWordsComputed ??= Computed<String>(() => super.lastWords,
              name: '_HomesStore.lastWords'))
          .value;
  Computed<bool> _$ultimoStatusComputed;

  @override
  bool get ultimoStatus =>
      (_$ultimoStatusComputed ??= Computed<bool>(() => super.ultimoStatus,
              name: '_HomesStore.ultimoStatus'))
          .value;
  Computed<bool> _$isButtonPressedComputed;

  @override
  bool get isButtonPressed =>
      (_$isButtonPressedComputed ??= Computed<bool>(() => super.isButtonPressed,
              name: '_HomesStore.isButtonPressed'))
          .value;
  Computed<bool> _$isMicProcessedComputed;

  @override
  bool get isMicProcessed =>
      (_$isMicProcessedComputed ??= Computed<bool>(() => super.isMicProcessed,
              name: '_HomesStore.isMicProcessed'))
          .value;
  Computed<bool> _$isVozActiveComputed;

  @override
  bool get isVozActive =>
      (_$isVozActiveComputed ??= Computed<bool>(() => super.isVozActive,
              name: '_HomesStore.isVozActive'))
          .value;
  Computed<int> _$getEscolhaComputed;

  @override
  int get getEscolha => (_$getEscolhaComputed ??=
          Computed<int>(() => super.getEscolha, name: '_HomesStore.getEscolha'))
      .value;

  final _$wordsAtom = Atom(name: '_HomesStore.words');

  @override
  String get words {
    _$wordsAtom.reportRead();
    return super.words;
  }

  @override
  set words(String value) {
    _$wordsAtom.reportWrite(value, super.words, () {
      super.words = value;
    });
  }

  final _$lastStatusAtom = Atom(name: '_HomesStore.lastStatus');

  @override
  bool get lastStatus {
    _$lastStatusAtom.reportRead();
    return super.lastStatus;
  }

  @override
  set lastStatus(bool value) {
    _$lastStatusAtom.reportWrite(value, super.lastStatus, () {
      super.lastStatus = value;
    });
  }

  final _$micAtom = Atom(name: '_HomesStore.mic');

  @override
  int get mic {
    _$micAtom.reportRead();
    return super.mic;
  }

  @override
  set mic(int value) {
    _$micAtom.reportWrite(value, super.mic, () {
      super.mic = value;
    });
  }

  final _$speakAtom = Atom(name: '_HomesStore.speak');

  @override
  int get speak {
    _$speakAtom.reportRead();
    return super.speak;
  }

  @override
  set speak(int value) {
    _$speakAtom.reportWrite(value, super.speak, () {
      super.speak = value;
    });
  }

  final _$utilizarVozAtom = Atom(name: '_HomesStore.utilizarVoz');

  @override
  bool get utilizarVoz {
    _$utilizarVozAtom.reportRead();
    return super.utilizarVoz;
  }

  @override
  set utilizarVoz(bool value) {
    _$utilizarVozAtom.reportWrite(value, super.utilizarVoz, () {
      super.utilizarVoz = value;
    });
  }

  final _$escolhaUusarioAtom = Atom(name: '_HomesStore.escolhaUusario');

  @override
  int get escolhaUusario {
    _$escolhaUusarioAtom.reportRead();
    return super.escolhaUusario;
  }

  @override
  set escolhaUusario(int value) {
    _$escolhaUusarioAtom.reportWrite(value, super.escolhaUusario, () {
      super.escolhaUusario = value;
    });
  }

  final _$startMicAsyncAction = AsyncAction('_HomesStore.startMic');

  @override
  Future startMic() {
    return _$startMicAsyncAction.run(() => super.startMic());
  }

  final _$_HomesStoreActionController = ActionController(name: '_HomesStore');

  @override
  void setSpeakTrue() {
    final _$actionInfo = _$_HomesStoreActionController.startAction(
        name: '_HomesStore.setSpeakTrue');
    try {
      return super.setSpeakTrue();
    } finally {
      _$_HomesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSpeakFalse() {
    final _$actionInfo = _$_HomesStoreActionController.startAction(
        name: '_HomesStore.setSpeakFalse');
    try {
      return super.setSpeakFalse();
    } finally {
      _$_HomesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMicFalse() {
    final _$actionInfo = _$_HomesStoreActionController.startAction(
        name: '_HomesStore.setMicFalse');
    try {
      return super.setMicFalse();
    } finally {
      _$_HomesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMicOcupado() {
    final _$actionInfo = _$_HomesStoreActionController.startAction(
        name: '_HomesStore.setMicOcupado');
    try {
      return super.setMicOcupado();
    } finally {
      _$_HomesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMicTrue() {
    final _$actionInfo = _$_HomesStoreActionController.startAction(
        name: '_HomesStore.setMicTrue');
    try {
      return super.setMicTrue();
    } finally {
      _$_HomesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setVoz() {
    final _$actionInfo =
        _$_HomesStoreActionController.startAction(name: '_HomesStore.setVoz');
    try {
      return super.setVoz();
    } finally {
      _$_HomesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEscolha(int value) {
    final _$actionInfo = _$_HomesStoreActionController.startAction(
        name: '_HomesStore.setEscolha');
    try {
      return super.setEscolha(value);
    } finally {
      _$_HomesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
words: ${words},
lastStatus: ${lastStatus},
mic: ${mic},
speak: ${speak},
utilizarVoz: ${utilizarVoz},
escolhaUusario: ${escolhaUusario},
lastWords: ${lastWords},
ultimoStatus: ${ultimoStatus},
isButtonPressed: ${isButtonPressed},
isMicProcessed: ${isMicProcessed},
isVozActive: ${isVozActive},
getEscolha: ${getEscolha}
    ''';
  }
}
