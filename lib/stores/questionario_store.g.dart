// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'questionario_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$QuestionarioStore on _QuestionarioStore, Store {
  Computed<String> _$getPerguntaComputed;

  @override
  String get getPergunta =>
      (_$getPerguntaComputed ??= Computed<String>(() => super.getPergunta,
              name: '_QuestionarioStore.getPergunta'))
          .value;
  Computed<String> _$getsessionIdComputed;

  @override
  String get getsessionId =>
      (_$getsessionIdComputed ??= Computed<String>(() => super.getsessionId,
              name: '_QuestionarioStore.getsessionId'))
          .value;
  Computed<String> _$getFluxoComputed;

  @override
  String get getFluxo =>
      (_$getFluxoComputed ??= Computed<String>(() => super.getFluxo,
              name: '_QuestionarioStore.getFluxo'))
          .value;
  Computed<String> _$getBotaoComputed;

  @override
  String get getBotao =>
      (_$getBotaoComputed ??= Computed<String>(() => super.getBotao,
              name: '_QuestionarioStore.getBotao'))
          .value;
  Computed<dynamic> _$getAlternativasComputed;

  @override
  dynamic get getAlternativas => (_$getAlternativasComputed ??=
          Computed<dynamic>(() => super.getAlternativas,
              name: '_QuestionarioStore.getAlternativas'))
      .value;
  Computed<bool> _$getcontinuaConversaComputed;

  @override
  bool get getcontinuaConversa => (_$getcontinuaConversaComputed ??=
          Computed<bool>(() => super.getcontinuaConversa,
              name: '_QuestionarioStore.getcontinuaConversa'))
      .value;
  Computed<String> _$getRespostaComputed;

  @override
  String get getResposta =>
      (_$getRespostaComputed ??= Computed<String>(() => super.getResposta,
              name: '_QuestionarioStore.getResposta'))
          .value;
  Computed<bool> _$getButtonBlockComputed;

  @override
  bool get getButtonBlock =>
      (_$getButtonBlockComputed ??= Computed<bool>(() => super.getButtonBlock,
              name: '_QuestionarioStore.getButtonBlock'))
          .value;
  Computed<bool> _$getFalaComputed;

  @override
  bool get getFala => (_$getFalaComputed ??= Computed<bool>(() => super.getFala,
          name: '_QuestionarioStore.getFala'))
      .value;

  final _$perguntaAtom = Atom(name: '_QuestionarioStore.pergunta');

  @override
  String get pergunta {
    _$perguntaAtom.reportRead();
    return super.pergunta;
  }

  @override
  set pergunta(String value) {
    _$perguntaAtom.reportWrite(value, super.pergunta, () {
      super.pergunta = value;
    });
  }

  final _$sessionIdAtom = Atom(name: '_QuestionarioStore.sessionId');

  @override
  String get sessionId {
    _$sessionIdAtom.reportRead();
    return super.sessionId;
  }

  @override
  set sessionId(String value) {
    _$sessionIdAtom.reportWrite(value, super.sessionId, () {
      super.sessionId = value;
    });
  }

  final _$fluxoAtom = Atom(name: '_QuestionarioStore.fluxo');

  @override
  String get fluxo {
    _$fluxoAtom.reportRead();
    return super.fluxo;
  }

  @override
  set fluxo(String value) {
    _$fluxoAtom.reportWrite(value, super.fluxo, () {
      super.fluxo = value;
    });
  }

  final _$botaoAtom = Atom(name: '_QuestionarioStore.botao');

  @override
  String get botao {
    _$botaoAtom.reportRead();
    return super.botao;
  }

  @override
  set botao(String value) {
    _$botaoAtom.reportWrite(value, super.botao, () {
      super.botao = value;
    });
  }

  final _$alternativasAtom = Atom(name: '_QuestionarioStore.alternativas');

  @override
  dynamic get alternativas {
    _$alternativasAtom.reportRead();
    return super.alternativas;
  }

  @override
  set alternativas(dynamic value) {
    _$alternativasAtom.reportWrite(value, super.alternativas, () {
      super.alternativas = value;
    });
  }

  final _$continuaConversaAtom =
      Atom(name: '_QuestionarioStore.continuaConversa');

  @override
  bool get continuaConversa {
    _$continuaConversaAtom.reportRead();
    return super.continuaConversa;
  }

  @override
  set continuaConversa(bool value) {
    _$continuaConversaAtom.reportWrite(value, super.continuaConversa, () {
      super.continuaConversa = value;
    });
  }

  final _$respostaAtom = Atom(name: '_QuestionarioStore.resposta');

  @override
  String get resposta {
    _$respostaAtom.reportRead();
    return super.resposta;
  }

  @override
  set resposta(String value) {
    _$respostaAtom.reportWrite(value, super.resposta, () {
      super.resposta = value;
    });
  }

  final _$buttonBlockAtom = Atom(name: '_QuestionarioStore.buttonBlock');

  @override
  bool get buttonBlock {
    _$buttonBlockAtom.reportRead();
    return super.buttonBlock;
  }

  @override
  set buttonBlock(bool value) {
    _$buttonBlockAtom.reportWrite(value, super.buttonBlock, () {
      super.buttonBlock = value;
    });
  }

  final _$falaAtom = Atom(name: '_QuestionarioStore.fala');

  @override
  bool get fala {
    _$falaAtom.reportRead();
    return super.fala;
  }

  @override
  set fala(bool value) {
    _$falaAtom.reportWrite(value, super.fala, () {
      super.fala = value;
    });
  }

  final _$_QuestionarioStoreActionController =
      ActionController(name: '_QuestionarioStore');

  @override
  void setPergunta(String value) {
    final _$actionInfo = _$_QuestionarioStoreActionController.startAction(
        name: '_QuestionarioStore.setPergunta');
    try {
      return super.setPergunta(value);
    } finally {
      _$_QuestionarioStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setsessionId(String value) {
    final _$actionInfo = _$_QuestionarioStoreActionController.startAction(
        name: '_QuestionarioStore.setsessionId');
    try {
      return super.setsessionId(value);
    } finally {
      _$_QuestionarioStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFluxo(String value) {
    final _$actionInfo = _$_QuestionarioStoreActionController.startAction(
        name: '_QuestionarioStore.setFluxo');
    try {
      return super.setFluxo(value);
    } finally {
      _$_QuestionarioStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setBotao(String value) {
    final _$actionInfo = _$_QuestionarioStoreActionController.startAction(
        name: '_QuestionarioStore.setBotao');
    try {
      return super.setBotao(value);
    } finally {
      _$_QuestionarioStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAlternativas(dynamic value) {
    final _$actionInfo = _$_QuestionarioStoreActionController.startAction(
        name: '_QuestionarioStore.setAlternativas');
    try {
      return super.setAlternativas(value);
    } finally {
      _$_QuestionarioStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setcontinuaConversa(bool value) {
    final _$actionInfo = _$_QuestionarioStoreActionController.startAction(
        name: '_QuestionarioStore.setcontinuaConversa');
    try {
      return super.setcontinuaConversa(value);
    } finally {
      _$_QuestionarioStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setResposta(String value) {
    final _$actionInfo = _$_QuestionarioStoreActionController.startAction(
        name: '_QuestionarioStore.setResposta');
    try {
      return super.setResposta(value);
    } finally {
      _$_QuestionarioStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setButtonBlock(bool value) {
    final _$actionInfo = _$_QuestionarioStoreActionController.startAction(
        name: '_QuestionarioStore.setButtonBlock');
    try {
      return super.setButtonBlock(value);
    } finally {
      _$_QuestionarioStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFala() {
    final _$actionInfo = _$_QuestionarioStoreActionController.startAction(
        name: '_QuestionarioStore.setFala');
    try {
      return super.setFala();
    } finally {
      _$_QuestionarioStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
pergunta: ${pergunta},
sessionId: ${sessionId},
fluxo: ${fluxo},
botao: ${botao},
alternativas: ${alternativas},
continuaConversa: ${continuaConversa},
resposta: ${resposta},
buttonBlock: ${buttonBlock},
fala: ${fala},
getPergunta: ${getPergunta},
getsessionId: ${getsessionId},
getFluxo: ${getFluxo},
getBotao: ${getBotao},
getAlternativas: ${getAlternativas},
getcontinuaConversa: ${getcontinuaConversa},
getResposta: ${getResposta},
getButtonBlock: ${getButtonBlock},
getFala: ${getFala}
    ''';
  }
}
