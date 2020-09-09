import 'package:flutter/material.dart';
import 'package:prevent/models/pessoa_model.dart';

class Configuracoes extends StatelessWidget {

  Pessoa pessoa;
  Configuracoes(this.pessoa);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Text('PAGE CONFIG'),
    );
  }
}
