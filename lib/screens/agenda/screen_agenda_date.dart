import 'package:flutter/material.dart';

class ListEventos extends StatefulWidget {

  @override
  _ListEventosState createState() => _ListEventosState();
}

class _ListEventosState extends State<ListEventos> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.0,
      color: Theme.of(context).primaryColor,
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Text('AAAA'),
      )
    );
  }
}
