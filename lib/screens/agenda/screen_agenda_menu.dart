import 'package:flutter/material.dart';
import 'package:prevent/Widgets/category_selector.dart';
import 'package:prevent/screens/agenda/screen_lista_medicamentos.dart';
import 'package:prevent/screens/chat/chats_recentes.dart';

class AgendaMenu extends StatefulWidget {
  @override
  _AgendaMenuState createState() => _AgendaMenuState();
}

class _AgendaMenuState extends State<AgendaMenu> {

  AppBar appBar = AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          iconSize: 30.0,
          color: Colors.white,
          onPressed: () {},
        ),
        title: Text(
          'Agenda',
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: appBar,
      body: Column(
        children: <Widget>[
          //CategorySelector(['Medicamentos', 'Novo']),
          //ListEventos(),
          Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/1.17,
                margin: EdgeInsets.only(top: appBar.preferredSize.height/2.8),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  child: Container(
                    margin: EdgeInsets.only(top: 25),
                    child: Column(
                      children: <Widget>[
                        ListaMedicamentos(),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                height: 60,
                right: 10,
                top: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(120),
                  child: Material(
                    color: Colors.white, // button color
                    child: InkWell(
                      borderRadius: BorderRadius.circular(60),
                      splashColor: Theme.of(context).accentColor, // splash color
                      onTap: () {}, // button pressed
                      child: Container(
                        decoration: BoxDecoration(
                          //color: Colors.white,
                      borderRadius: BorderRadius.circular(60),
                      border: Border.all(
                        color: Theme.of(context).accentColor,
                        width: 2
                      )
                    ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 3, bottom: 3, top: 3),
                              child: Image.asset('assets/remedioadd.png', height: 40, width: 40,),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text('Adicionar\nMedicação', textAlign: TextAlign.center, style: TextStyle(color: Theme.of(context).accentColor, fontWeight: FontWeight.bold),),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ),
              /*Positioned(
                height: 60,
                width: 60,
                right: 150,
                top: 0,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    border: Border.all(
                      color: Theme.of(context).accentColor,
                      width: 2
                    )
                  ),
                  child: ClipOval(
                    child: Material(
                      color: Colors.white, // button color
                      child: InkWell(
                        splashColor: Theme.of(context).accentColor, // splash color
                        onTap: () {}, // button pressed
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset('assets/calendar.png', height: 40, width: 40,), // icon
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              )*/
            ],
          ),
        ],
      ),
    );
  }
}
