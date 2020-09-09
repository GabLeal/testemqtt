import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:custom_switch/custom_switch.dart';
import 'package:prevent/models/busca_questoes_model.dart';
import 'package:prevent/stores/home_store.dart';

Widget microfone(HomesStore micStore, BuscaQuestoes quest){
    return Stack(
      children: <Widget>[
        Observer(
          builder: (_){
            return Container(
             width: 105,
            height: 105,
            decoration: BoxDecoration(
              color: micStore.isButtonPressed ? Colors.green : micStore.isMicProcessed ? Colors.red :  Colors.white.withOpacity(0.1),//Color(0xff7BB5D5),
              shape: BoxShape.circle
            ),
          );
          }, 
        ),
        Positioned(
          left: 7.5,
          top: 7.5,
          width: 90,
          height: 90,
          child: Observer(
            builder: (_){
              print(micStore.lastStatus);
              if(micStore.lastStatus == true){
                print(micStore.lastWords);
                quest.sendResposta(micStore.lastWords);
                //micStore.setSpeakTrue;
              }
              return GestureDetector(
                child: micStore.isVozActive
                  ? Image.asset('assets/mic.png')
                  : Image.asset('assets/mic_off.png'),
                  onTap: micStore.isVozActive ? micStore.startMic : (){print('destaivado');},   
              );
            }
          ),
        ),
      ],
    );
  }

Widget utilizarVoz(HomesStore micStore, BuscaQuestoes quest, double largura){
  return Container(
    margin: EdgeInsets.all(10),
    child: Stack(
      children: <Widget>[
        Container(
          color: Colors.transparent,
          width: largura/1.05,
          height: largura/4.0,
        ),
        Positioned(
          left: 0,
          bottom: 0,
          child: Container(
            width: largura/1.05,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Observer(
                  builder: (_){
                    return Container(
                     width: 95,
                    height: 95,
                    decoration: BoxDecoration(
                      color: micStore.isButtonPressed ? Colors.green : micStore.isMicProcessed ? Colors.red :  Colors.white.withOpacity(0.1),//Color(0xff7BB5D5),
                      shape: BoxShape.circle
                    ),
                  );
                  }, 
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 0,
          bottom: 6,
          child: Container(
            width: largura/1.05,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 82,
                  height: 82,
                  child: Observer(
                    builder: (_){
                      print(micStore.lastStatus);
                      if(micStore.lastStatus == true){
                      print(micStore.lastWords);
                      quest.sendResposta(micStore.lastWords);
                      //micStore.setSpeakTrue;
                      }
                      return GestureDetector(
                        child: micStore.isVozActive
                          ? Image.asset('assets/mic.png')
                          : Image.asset('assets/mic_off.png'),
                        onTap: micStore.isVozActive ? micStore.startMic : (){print('destaivado');},   
                      );
                    }
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 11,
          bottom: 0,
          child: Column(
            children: <Widget>[
              Text('Utilizar voz', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
              Padding(padding: EdgeInsets.only(bottom: 5)),
              CustomSwitch(
                activeColor: Color(0xff00AD3D),
                value: micStore.isVozActive,
                onChanged: (val){
                  micStore.setVoz();
                  quest.questionarioStore.setFala();
                },
//                width: 50,
//                height: 25,
              ),
            ],
          )
        )
      ],
    ),
    );
  }
