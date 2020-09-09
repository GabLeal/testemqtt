import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
  
  Widget pergunta({largura, altura, buscaQuestoes}){
    return Observer(
      builder: (_){
        return Column(
          children: <Widget>[
            Container(
              width: largura,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(25),
                    child: Text(
                      buscaQuestoes.questionarioStore.getPergunta,
                      textAlign: TextAlign.center, 
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35
                      )
                    )            
                  ),
                ],
              ),
            ),
          ],
        );
      }  
    );
  }

  
