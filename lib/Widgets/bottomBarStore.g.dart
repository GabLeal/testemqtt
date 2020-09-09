// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bottomBarStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$BottomBarStore on _BottomBarStore, Store {
  Computed<int> _$getIndexComputed;

  @override
  int get getIndex => (_$getIndexComputed ??=
          Computed<int>(() => super.getIndex, name: '_BottomBarStore.getIndex'))
      .value;

  final _$indexSelecionadoAtom = Atom(name: '_BottomBarStore.indexSelecionado');

  @override
  int get indexSelecionado {
    _$indexSelecionadoAtom.reportRead();
    return super.indexSelecionado;
  }

  @override
  set indexSelecionado(int value) {
    _$indexSelecionadoAtom.reportWrite(value, super.indexSelecionado, () {
      super.indexSelecionado = value;
    });
  }

  final _$_BottomBarStoreActionController =
      ActionController(name: '_BottomBarStore');

  @override
  void setIndex(int value) {
    final _$actionInfo = _$_BottomBarStoreActionController.startAction(
        name: '_BottomBarStore.setIndex');
    try {
      return super.setIndex(value);
    } finally {
      _$_BottomBarStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
indexSelecionado: ${indexSelecionado},
getIndex: ${getIndex}
    ''';
  }
}
