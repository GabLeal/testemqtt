import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart' as dpt;
import 'package:prevent/models/medicamento.dart';
import 'package:prevent/models/mensagem_model.dart';


class ListaMedicamentos extends StatelessWidget {
  
  DateTime dataHoje = DateTime.now();
  DateTime ultimoMes = DateTime.now().subtract(Duration(days: 30));
  dpt.DatePickerController _controller = dpt.DatePickerController();
  // _controller.animateToSelection(); >> Chamar no initState...






  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 20),
                child: dpt.DatePicker(
                  ultimoMes,
                  onDateChange: (data){
                    print(data);
                  },
                  selectionColor: Theme.of(context).accentColor,
                  daysCount: 60,
                  locale: "pt_BR",
                  initialSelectedDate: dataHoje,
                  controller: _controller,                  
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) {
                    //final Medicamento medicamento = meds[index];
                    return GestureDetector(
                      /*onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => med(
                            user: med.pessoa,
                          ),
                        ),
                      ),*/
                      child: Container(
                        //margin: EdgeInsets.only(top: 5.0, bottom: 5.0, right: 20.0),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey[200]
                          ),
                          color: index%2 == 0 ? Colors.blue[50] : Colors.white,
                          /*borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0),
                          ),*/
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 30,
                                  backgroundImage: AssetImage('assets/remedio.png'),
                                ),
                                SizedBox(width: 10.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                     'med.medicamento.txNome',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 5.0),
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.45,
                                      child: Text(
                                        'aaa',
                                        style: TextStyle(
                                          color: Colors.blueGrey,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Text(
                                  'qaaa',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5.0),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
