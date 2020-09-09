import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:prevent/style.dart';

class LoadScreen{

  void onLoading(texto, context) {

    double largura = MediaQuery.of(context).size.width;
    double altura = MediaQuery.of(context).size.height;
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
        onWillPop: () async => false,
        child: Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Container(
            height: altura / 8,
            decoration: BoxDecoration(
                color: Style.azul_prevent,
                borderRadius: BorderRadius.circular(15)
            ),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 15),
                  child: new SpinKitChasingDots(
                    color: Colors.white,
                    size: 50.0,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15),
                  child: new Text(
                    texto,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: largura / 100 * 5
                    ),
                  )
                ),
              ]
          ),
          ),
        )
        );
      }
    );
  }
}
