import 'package:epilepsia/login/bottomNavigationBar.dart';
import 'package:epilepsia/model/healthy/sleepModel.dart';
import 'package:epilepsia/model/healthy/IconModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../config/widget/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final timeController = TextEditingController();
final timeController1 = TextEditingController();
final dateController = TextEditingController();

class SleepWidget extends StatefulWidget {
  SleepWidget({
    Key key,
  }) : super(key: key);
  @override
  _SleepState createState() => _SleepState();
}

class _SleepState extends State<SleepWidget> {
  List<StatusIcons> statusList = <StatusIcons>[];
  TimeOfDay timeOfDayTime;
  DateTime dateTimeDay;
  TimeOfDay startDate = TimeOfDay.now();
  TimeOfDay endDate = TimeOfDay.now();
  String minute = "";
  String hours = "";
  String sleepDuration = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Setzen des Datumsformat
    DateFormat format = DateFormat('dd.MM.yyyy');
    //Anzeige der Schlafdauer je nach Auswahl der Uhrzeiten
    if (hours != "" && minute != "") {
      sleepDuration = "Schlafdauer: " + hours + ":" + minute;
    } else if (hours == "" && minute != "") {
      sleepDuration = "Schlafdauer: " + "00:" + minute;
    } else if (hours != "" && minute == "") {
      sleepDuration = "Schlafdauer: " + hours + ":00";
    } else {
      sleepDuration = "";
    }

    return Container(
        margin: const EdgeInsets.all(15.0),
        child: Column(children: [
          //Datum auswählen
          Container(
            child: TextField(
              readOnly: true,
              controller: dateController,
              decoration: InputDecoration(
                  hoverColor: Colors.blue[200], hintText: 'Tag auswählen'),
              //Variablen mit ausgewähltem Tag befüllen
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
          //Auswahl der Uhrzeit an der man eingeschlafen ist
          TextField(
              readOnly: true,
              controller: timeController,
              decoration: InputDecoration(
                  hoverColor: Colors.blue[200], hintText: 'Eingeschlafen'),
              //Variablen mit ausgewählter Zeit befüllen
              onTap: () async {
                var time = await showTimePicker(
                  initialTime: TimeOfDay.now(),
                  context: context,
                );
                timeController.text = time.format(context);
                //Setzt die Minuten und Stunden der Schlafdauer und berücksichtigt auch einen Tageswechsel
                setState(() {
                  if (startDate.hour <= endDate.hour) {
                    hours = (endDate.hour - startDate.hour).toString();
                  } else {
                    hours = (startDate.hour - endDate.hour).toString();
                  }
                  if (startDate.minute <= endDate.minute) {
                    minute = (endDate.minute - startDate.minute).toString();
                  } else {
                    minute = (startDate.minute - endDate.minute).toString();
                  }
                });
              }),
          //Auswahl der Uhrzeit beim Aufstehen
          TextField(
            readOnly: true,
            controller: timeController1,
            decoration: InputDecoration(
                hoverColor: Colors.blue[200], hintText: 'Aufgestanden'),
            //Variablen mit ausgewählter Zeit befüllen
            onTap: () async {
              endDate = await showTimePicker(
                initialTime: TimeOfDay.now(),
                context: context,
              );
              timeController1.text = endDate.format(context);
              setState(() {
                //Setzt die Minuten und Stunden der Schlafdauer und berücksichtigt auch einen Tageswechsel
                if (startDate.hour <= endDate.hour) {
                  hours = (endDate.hour - startDate.hour).toString();
                } else {
                  hours = (startDate.hour - endDate.hour).toString();
                }
                if (startDate.minute <= endDate.minute) {
                  minute = (endDate.minute - startDate.minute).toString();
                } else {
                  minute = (startDate.minute - endDate.minute).toString();
                }
              });
            },
          ),
          //Abgrenzungslinie
          Divider(
            height: 15,
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              sleepDuration,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ),
          //Abgrenzungslinie
          Divider(
            height: 15,
            thickness: 5,
          ),
          //Sleepicons zum Auswählen von der Klasse StatusWidget --> siehe config/widget/widget.dart
          Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              'Schlafqualität',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            children: [
              StatusWidget(
                widget.key,
                'sleep',
                'Ausgeruht',
                0xeae2,
                Colors.amberAccent[700],
                statusList,
              ),
              StatusWidget(
                widget.key,
                'sleep',
                'Neutral',
                60131,
                Colors.amberAccent[700],
                statusList,
              ),
              StatusWidget(
                widget.key,
                'sleep',
                'Insomnie',
                59566,
                Colors.amberAccent[700],
                statusList,
              ),
              StatusWidget(
                widget.key,
                'sleep',
                'Albträume',
                59222,
                Colors.amberAccent[700],
                statusList,
              ),
            ],
          ),
          //Bei Hinzufügen-Button wird die Funktion saveSleep ausgeführt
          ElevatedButton.icon(
            onPressed: () {
              //ausgewählte Felder werden übergeben
              saveSleep(statusList, dateTimeDay, sleepDuration);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => BottomNavigation()));
            },
            icon: Icon(Icons.add, size: 18),
            label: Text("Hinzufügen"),
            style: ElevatedButton.styleFrom(
              primary: Colors.grey[400],
              onPrimary: Colors.black,
              onSurface: Colors.grey,
            ),
          )
        ]));
  }

  ///Funktion Speichert alle Ausgewählten relevanten Felder als SchlafObjekt --> model/healthy/sleepModel
  void saveSleep(List<StatusIcons> statusList, DateTime dateTimeDay,
      String durationSleep) {
    //User-ID wird von Firebase geholt
    final User user = FirebaseAuth.instance.currentUser;
    final uid = user.uid;
    StatusIcons sleep =
        statusList.firstWhere((element) => element.id == "sleep");
    Sleep sleepclass = new Sleep(
        userid: uid,
        dateDay: dateTimeDay,
        durationSleep: durationSleep,
        sleepicon: sleep);
    //Debug
    print(sleepclass);
    print(sleepclass.toJson());
    //Schlaf-Objekt wird der Funktion sleepSetup() übergeben
    sleepSetup(sleepclass);
    //Debug
    print(statusList[0].toJson());
  }
}

///Das Schlaf-Objekt wird in Firestore in einer Sammlung namens sleep gespeichert
Future<void> sleepSetup(Sleep sleep) async {
  CollectionReference sleepref = FirebaseFirestore.instance.collection('sleep');
  sleepref.add(sleep.toJson());
}
