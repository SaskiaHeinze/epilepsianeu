import 'package:epilepsia/login/bottomNavigationBar.dart';
import 'package:epilepsia/model/healthy/StateOfHealthModel.dart';
import 'package:epilepsia/model/healthy/IconModel.dart';
import 'package:epilepsia/config/widget/widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

final timeController = TextEditingController();
final dateController = TextEditingController();

class StateOfHealth extends StatefulWidget {
  const StateOfHealth({Key key}) : super(key: key);
  @override
  _StateOfHealthState createState() => _StateOfHealthState();
}

class _StateOfHealthState extends State<StateOfHealth> {
  List<StatusIcons> statusList = <StatusIcons>[];
  TimeOfDay timeOfDayTime;
  DateTime dateTimeDay;

  Widget build(BuildContext context) {
    DateFormat format = DateFormat('dd.MM.yyyy');
    return Scaffold(
      //Funktion ermöglich das Scrollen innerhalb der App
      body: SingleChildScrollView(
          child: Container(
              margin: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  //Datum auswählen
                  Container(
                    child: TextField(
                      readOnly: true,
                      controller: dateController,
                      decoration: InputDecoration(
                          hoverColor: Colors.blue[200],
                          hintText: 'Tag auswählen'),
                      //Variablen mit ausgewählten Datum befüllen
                      onTap: () async {
                        var date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100));

                        dateController.value =
                            TextEditingValue(text: format.format(date));

                        setState(() {
                          dateTimeDay = date;
                        });
                      },
                    ),
                  ),
                  //Uhrzeit auswählen
                  TextField(
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
                  Divider(
                    height: 40,
                    thickness: 3,
                  ),
                  //Stimmungsicons zum Auswählen von der Klasse StatusWidget --> siehe config/widget/widget.dart
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Stimmung: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      StatusWidget(
                        widget.key,
                        'mood',
                        'Glücklich',
                        59842,
                        Colors.red[300],
                        statusList,
                      ),
                      StatusWidget(
                        widget.key,
                        'mood',
                        'Neutral',
                        59841,
                        Colors.red[300],
                        statusList,
                      ),
                      StatusWidget(
                        widget.key,
                        'mood',
                        'Traurig',
                        58361,
                        Colors.red[300],
                        statusList,
                      ),
                      StatusWidget(
                        widget.key,
                        'mood',
                        'Gereizt',
                        58365,
                        Colors.red[300],
                        statusList,
                      ),
                    ],
                  ),
                  //Symptomicons zum Auswählen von der Klasse StatusWidget --> siehe config/widget/widget.dart
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Symptome',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      StatusWidget(
                        widget.key,
                        'symptom',
                        'Symptomfrei',
                        58964,
                        Colors.teal[300],
                        statusList,
                      ),
                      StatusWidget(
                        widget.key,
                        'symptom',
                        'Zucken',
                        58869,
                        Colors.teal[300],
                        statusList,
                      ),
                      StatusWidget(
                        widget.key,
                        'symptom',
                        'Krämpfe',
                        60118,
                        Colors.teal[300],
                        statusList,
                      ),
                      StatusWidget(
                        widget.key,
                        'symptom',
                        'Fieber',
                        58534,
                        Colors.teal[300],
                        statusList,
                      ),
                    ],
                  ),
                  //Stressicons zum Auswählen von der Klasse StatusWidget --> siehe config/widget/widget.dart
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Stress',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      StatusWidget(
                        widget.key,
                        'stress',
                        'Entspannt',
                        60130,
                        Colors.amberAccent[700],
                        statusList,
                      ),
                      StatusWidget(
                        widget.key,
                        'stress',
                        'Unruhe',
                        60126,
                        Colors.amberAccent[700],
                        statusList,
                      ),
                      StatusWidget(
                        widget.key,
                        'stress',
                        'Anspannung',
                        58869,
                        Colors.amberAccent[700],
                        statusList,
                      ),
                      StatusWidget(
                        widget.key,
                        'stress',
                        'Stress',
                        59222,
                        Colors.amberAccent[700],
                        statusList,
                      ),
                    ],
                  ),
                  Divider(
                    height: 30,
                    thickness: 3,
                  ),
                  //Bei Hinzufügen-Button wird die Funktion saveStatus ausgeführt
                  ElevatedButton.icon(
                    onPressed: () {
                      //Debug
                      print(statusList);
                      //ausgewählte Felder werden übergeben
                      saveStatus(statusList, dateTimeDay, timeOfDayTime);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  BottomNavigation()));
                    },
                    icon: Icon(Icons.add, size: 16),
                    label: Text("Hinzufügen"),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey[400],
                      onPrimary: Colors.black,
                      onSurface: Colors.grey,
                    ),
                  ),
                ],
              ))),
    );
  }

  ///Funktion Speichert alle Ausgewählten relevanten Felder als StatusObjekt --> model/healthy/StateOfHealthModel
  void saveStatus(List<StatusIcons> statusList, DateTime dateTimeDay,
      TimeOfDay timeOfDayTime) {
    //User-ID wird von Firebase geholt
    final User user = FirebaseAuth.instance.currentUser;
    final uid = user.uid;
    StatusIcons mood = statusList.firstWhere((element) => element.id == "mood");
    StatusIcons symptom =
        statusList.firstWhere((element) => element.id == "symptom");
    StatusIcons stress =
        statusList.firstWhere((element) => element.id == "stress");
    StateOfHealthModel status = new StateOfHealthModel(
        userid: uid,
        dateDay: dateTimeDay,
        uhrzeit: timeOfDayTime,
        mood: mood,
        symptom: symptom,
        stress: stress);
    //Debug
    print(status.toJson());
    //Schlaf-Objekt wird der Funktion statusSetup() übergeben
    statusSetup(status);
  }
}

///Das Status-Objekt wird in Firestore in einer Sammlung namens status gespeichert
Future<void> statusSetup(StateOfHealthModel status) async {
  CollectionReference statusref =
      FirebaseFirestore.instance.collection('status');
  statusref.add(status.toJson());
}
