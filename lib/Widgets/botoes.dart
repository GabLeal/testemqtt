import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';  
import 'package:flutter/services.dart';
  Widget botoes({largura, altura, buscaQuestoes, textEditingController}){
    return Container(
      child: Column(
        children: <Widget>[
          Observer(
            builder: (_){
              switch (buscaQuestoes.questionarioStore.getBotao) {
                case 'unico_bt':
                  print('UNICO BOTÃO DETECTED');
                    return unicoBt(buscaQuestoes, largura: largura);
                  break;
                case 'unico_rd':
                  print('UNICO RD DETECTED');
                    //return textual_ln(largura: largura, altura: altura);
                    return unicoRd(buscaQuestoes, largura: largura);
                    //return unicoBt(largura: largura);
                  break;
                case 'textual_ln':
                  print('textual_ln DETECTED');
                    return textual_ln(buscaQuestoes, textEditingController, largura: largura, altura: altura);
                  break;
                case 'textual_ar':
                  print('textual_ar DETECTED');
                    return Text('');
                  break;
                default:
                   print('BOTÃO VAZIO DETECTED');
                    return Text('');
              }
            },
          ),
        ],
      ),
    );
  }

Widget unicoBt(buscaQuestoes, {largura}){
  List<dynamic> list = buscaQuestoes.questionarioStore.alternativas;
  print(list);
  buscaQuestoes.retornaFormatado(list[0]['valor']);

  if(list.length == 2){
    if(buscaQuestoes.retornaFormatado(list[0]['texto']) == 'SIM' && buscaQuestoes.retornaFormatado(list[1]['texto']) == 'NÃO'){
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            disabledColor: Colors.grey[400],
            color: Colors.white,
           child: Text(
              'Sim',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20
             ),
            ),
            onPressed: buscaQuestoes.questionarioStore.getButtonBlock == false ? (){
             buscaQuestoes.sendResposta('Sim');
             buscaQuestoes.questionarioStore.setButtonBlock(true);
           } : null,
         ),
          SizedBox(width: largura/8,),
          RaisedButton(
            disabledColor: Colors.grey[400],
            color: Colors.white,
            child: Text(
             'Não',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20
             ),
            ),
            onPressed: buscaQuestoes.questionarioStore.getButtonBlock == false ? (){
              buscaQuestoes.sendResposta('Não');
              buscaQuestoes.questionarioStore.setButtonBlock(true);
            } : null,
          ),
        ],
      );
    }
  }else{
    return unicoRd(buscaQuestoes, largura: largura);
  }
}

Widget unicoRd(buscaQuestoes, {largura}){
    List<dynamic> list = buscaQuestoes.questionarioStore.alternativas;
    final ScrollController scrollController = ScrollController();
    return Container(
      height: largura/2,
      child: Scrollbar(
        controller: scrollController,
        isAlwaysShown: false,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: list.length,
          scrollDirection: Axis.vertical,
          controller: scrollController,
          itemBuilder: (context, i){
            return Container(
              width: largura,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                          Container(
                            width: largura/1.2,
                            margin: EdgeInsets.only(bottom: 15),
                            child: RaisedButton(
                              disabledColor: Colors.grey[400],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.all(15),
                              child: Text(buscaQuestoes.retornaFormatado(list[i]['texto']), style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                              color: Colors.white,
                              onPressed: buscaQuestoes.questionarioStore.getButtonBlock == false ? (){
                                //homesStore.setEscolha(i);
                                buscaQuestoes.questionarioStore.setButtonBlock(true);
                                buscaQuestoes.questionarioStore.setBotao('');
                                buscaQuestoes.questionarioStore.setBotao('unico_rd');
                                buscaQuestoes.sendResposta(buscaQuestoes.retornaFormatado(list[i]['valor']));
                              } : null,
                            ),
                          )
                    ],
                  )
                ],
            ));
          }
        ),
      ),
    );
}

Widget textual_ln(buscaQuestoes, textEditingController, {largura, altura}){
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      Container(
        width: largura/3,
          child: TextField(
            onSubmitted: (String aaa){
              buscaQuestoes.questionarioStore.setButtonBlock(true);
              buscaQuestoes.questionarioStore.setBotao('');
              buscaQuestoes.questionarioStore.setBotao('textual_ln');
              print('Enviando: ' + textEditingController.text);
              buscaQuestoes.sendResposta(textEditingController.text);
              textEditingController.text = '';
            },
            inputFormatters: [
              WhitelistingTextInputFormatter(RegExp("[1-9]"))
            ],
            maxLength: 1,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 25, wordSpacing: 5.2),
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(30),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(30),
                ),
                //labelText: 'Quantas vezes ao dia?',
                //labelStyle: TextStyle(color: Colors.white),
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    style: BorderStyle.solid,
                    width: ((altura)/100)*4.3,
                    color: Colors.white
                  ),
                ),
                counterText: "",
              ),
            controller: textEditingController,
          ),
      ),
      Container(
        margin: EdgeInsets.only(top: 10),
        child: RaisedButton(
          disabledColor: Colors.grey[400],
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            'Enviar',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20
            ),
           ),
          onPressed: buscaQuestoes.questionarioStore.getButtonBlock == false ? (){
            buscaQuestoes.questionarioStore.setButtonBlock(true);
            buscaQuestoes.questionarioStore.setBotao('');
            buscaQuestoes.questionarioStore.setBotao('textual_ln');
            print('Enviando: ' + textEditingController.text);
            buscaQuestoes.sendResposta(textEditingController.text);
            textEditingController.text = '';
          } : null,
        ),
      )
    ],
  );
}
