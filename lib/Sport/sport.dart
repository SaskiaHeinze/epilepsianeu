import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epilepsia/Home/home.dart';
import 'package:epilepsia/login/bottomNavigationBar.dart';
import 'package:epilepsia/model/daily/sportModel.dart';
import 'package:epilepsia/model/healthy/IconModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../config/widget/widgetsport.dart';



class Daily extends StatefulWidget {
  Daily({
    Key key,
  }) : super(key: key);
  @override
  _DailyState createState() => _DailyState();
}

String dropdownValue = 'One';

class _DailyState extends State<Daily> {
  final timeController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  String fullName = '';
  TimeOfDay timeOfDayTime;
  //Erstellung einer Liste von der Sportdauer
  List<String> sportDuration = <String>[
    "10 Minuten",
    "20 Minuten",
    "30 Minuten",
    "45 Minuten",
    "60 Minuten",
    "90 Minuten",
  ];
  String _dropDownSportDuration;
  DateTime dateTimeDay;
  String daySelect = "";
  @override
  Widget build(BuildContext context) {
    String format = 'dd.MM.yyyy';

    return Scaffold(
      //obere Leiste - Zurück-Button oder Hinzufügen-Button
      appBar: AppBar(
        backgroundColor: Colors.amberAccent[700],
        actions: [
          Row(
            children: [
              Text(
                "Hinzufügen: ",
                style: TextStyle(color: Colors.black, fontSize: 10),
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  saveSport(statusList, timeOfDayTime, _dropDownSportDuration,
                      dateTimeDay);
                      Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              BottomNavigation()));
                },
              ),
            ],
          )
        ],
      ),
      //Funktion ermöglich das Scrollen innerhalb der App
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 30.0),
          child: Column(children: [
            //Auswahl eines Tages
            Container(
              margin: const EdgeInsets.all(15.0),
              child: TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                    hoverColor: Colors.blue[200],
                    hintText: (daySelect == "") ? "Tag auswählen" : daySelect),
                onTap: () async {
                  final DateTime picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                  );
                   //Variablen mit ausgewähltem Datum befüllen
                  if (picked != null)
                    setState(() {
                      dateTimeDay = picked;
                      DateFormat formatter = DateFormat(format);
                      daySelect = formatter.format(picked);
                      print(daySelect);
                    });
                },
              ),
            ),
            //Auswahl der Uhrzeit
            Container(
              margin: const EdgeInsets.all(15),
              child: TextField(
                readOnly: true,
                controller: timeController,
                decoration: InputDecoration(
                    hoverColor: Colors.blue[200],
                    hintText: 'Zeitpunkt auswählen'),
                //Variablen mit ausgewählter Zeit befüllen
                onTap: () async {
                  var time = await showTimePicker(
                    initialTime: TimeOfDay.now(),
                    context: context,
                  );

                  timeController.text = time.format(context);

                  setState(() {
                    timeOfDayTime = time;
                  });
                },
              ),
            ),
            Divider(
              height: 15,
            ),
            //Textfeld
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                'Wie lange machst du heute Sport?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            //Dropdown für die Sportdauer
            Container(
              margin: EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
              child: DropdownButton(
                hint: _dropDownSportDuration == null
                    ? Text('Sportdauer')
                    : Text(
                        _dropDownSportDuration,
                        style: TextStyle(color: Colors.blue),
                      ),
                iconSize: 30.0,
                style: TextStyle(color: Colors.blue),
                items: sportDuration.map(
                  (val) {
                    return DropdownMenuItem<String>(
                      value: val,
                      child: Text(val),
                    );
                  },
                ).toList(),
                onChanged: (val) {
                  setState(
                    () {
                      _dropDownSportDuration = val;
                    },
                  );
                },
              ),
            ),
            //Darstellung der auswählbaren Sporticon von der Klasse StatusWidget --> siehe config/widget/widgetSport.dart
            Row(
              children: [
                SportWidget(widget.key, 'sportart', 'Joggen', 59070,
                    Colors.grey[300], statusList),
                SportWidget(widget.key, 'sportart', 'Gehen', 59073,
                    Colors.grey[300], statusList),
              ],
            ),
            Row(
              children: [
                SportWidget(widget.key, 'sportart', 'Reiten', 59389,
                    Colors.grey[300], statusList),
                SportWidget(widget.key, 'sportart', 'Fahrrad fahren', 0xe6b8,
                    Colors.grey[300], statusList),
              ],
            ),
            Row(
              children: [
                SportWidget(widget.key, 'sportart', 'Schwimmen', 59714,
                    Colors.grey[300], statusList),
                SportWidget(widget.key, 'sportart', 'Golfen', 59280,
                    Colors.grey[300], statusList),
              ],
            ),
            Row(
              children: [
                SportWidget(widget.key, 'sportart', 'Fußball', 59931,
                    Colors.grey[300], statusList),
                SportWidget(widget.key, 'sportart', 'Gymnastik', 58769,
                    Colors.grey[300], statusList),
              ],
            ),
            Row(
              children: [
                SportWidget(widget.key, 'sportart', 'Tischtennis', 59921,
                    Colors.grey[300], statusList),
                SportWidget(widget.key, 'sportart', 'Fitness', 59216,
                    Colors.grey[300], statusList),
              ],
            ),
            Row(
              children: [
                SportWidget(widget.key, 'sportart', 'Tennis', 59932,
                    Colors.grey[300], statusList),
                SportWidget(widget.key, 'sportart', 'Ski fahren', 58712,
                    Colors.grey[300], statusList),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
//Funktion Speichert alle Ausgewählten relevanten Felder als SportObjekt --> model/healthy/sportModel
void saveSport(
  List<StatusIcons> statusList,
  TimeOfDay timeOfDayTime,
  String durationSport,
  DateTime dateTimeDay,
) {
  //User-ID wird von Firebase geholt
  final User user = FirebaseAuth.instance.currentUser;
  final uid = user.uid;
  StatusIcons sportIcon =
      statusList.firstWhere((element) => element.id == "sportart");
  Sport sport = new Sport(
    userid: uid,
    time: timeOfDayTime,
    durationSport: durationSport,
    sportIcon: sportIcon,
    dateDay: dateTimeDay,
  );
  //Sport-Objekt wird der Funktion sportSetup() übergeben
  sportSetup(sport);
}
//Das Sport-Objekt wird in Firestore in einer Sammlung namens sport gespeichert
Future<void> sportSetup(Sport sport) async {
  CollectionReference sportref = FirebaseFirestore.instance.collection('sport');
  sportref.add(sport.toJson());
}
