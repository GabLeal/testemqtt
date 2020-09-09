import 'package:flutter/material.dart';
import 'package:prevent/constantes.dart';
import 'package:prevent/local_storage.dart';
import 'package:prevent/screens/auth/screen_login.dart';
import 'package:prevent/stores/home_store.dart';
import 'package:prevent/style.dart';
import 'package:flutter_advanced_networkimage/provider.dart';

HomesStore homesStore = HomesStore();

Widget cabecalho({largura, altura, nome, nrCpfMd5, context}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                color: Colors.transparent,
                width: largura/1.05,
                height: largura/4.0,
              ),
              Positioned.fill(
                top: -10,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: largura/1.22,
                    height: altura/15,
                    decoration: BoxDecoration(
                      color: Style.cor_secundaria,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Text('$nome', style: TextStyle(fontSize: Style.fonte_tamanho_padrao * 1.5, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                        ),
                      ],
                    ),
                  ),
                )
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    width: largura/4.0,
                    height: largura/4.0,
                    decoration: BoxDecoration(
                      color: Style.cor_secundaria,
                      borderRadius: BorderRadius.circular(180)
                    ),
                    child: CircleAvatar(
                      backgroundColor: Style.cor_plano_fundo_avisos,
                      backgroundImage: AdvancedNetworkImage(
                        'https://portal.manuelvaiot.com/img/$nrCpfMd5.jpg',
                        fallbackAssetImage: 'assets/camera.png',
                      ),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                         bottom: -12,
                         child: Align(
                           alignment: Alignment.bottomRight,
                           child: Image.asset('assets/logo.png', height: 50, width: 50,),
                         ),
              ),
              Positioned.fill(
                bottom: -3,
                left: 0,
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    margin: EdgeInsets.only(left: largura/3.8, bottom: largura/35),
                    child: Text(
                      'Patologias: ',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: Style.fonte_tamanho_padrao/1.5
                      ),
                    ),
                  ),
                )
              ),
              Positioned.fill(
                top: -16,
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    margin: EdgeInsets.only(top: largura/18,),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              'Última Coleta: ',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: Style.fonte_tamanho_padrao/1.5
                              ),
                            ),
                            Text(
                              'xx/xx/xxxx',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: Style.fonte_tamanho_padrao/1.5
                              ),
                            ),
                          ],
                      ),
                  ),
                )
              ),
              Positioned.fill(
                bottom: 10,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    child: PopupMenuButton<String>(
                      onSelected: (String escolha){
                        switch (escolha) {
                          case 'Sair': 
                            {
                              print('Logout...');
                              Local_Storage().logout();
                              return Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => Tela_login()));
                            }
                          break;
                        }
                      },
                      itemBuilder: (BuildContext context) {
                        return Constantes.escolhas.map((String escolhas) {
                          return PopupMenuItem<String>(
                            value: escolhas,
                            child: Text(
                              escolhas
                            ),
                            textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Style.azul_prevent
                            ),
                          );
                        }).toList();
                      },
                    )
                  )
                )
              )
            ],
            overflow: Overflow.clip,
          ),
        ],
    );
  }
