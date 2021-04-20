import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epilepsia/login/bottomNavigationBar.dart';
import 'package:epilepsia/model/healthy/IconModel.dart';
import 'package:epilepsia/config/widget/widget.dart';
import 'package:epilepsia/model/medication/medicationModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class AddMedication extends StatefulWidget {
  AddMedication({
    Key key,
  }) : super(key: key);
  @override
  _AddMedicationState createState() => _AddMedicationState();
}

class _AddMedicationState extends State<AddMedication> {
  DateTime dateTimeDay;
  final dateController = TextEditingController();
  final dateController1 = TextEditingController();
  List<String> repeat = <String>["Täglich", "Wöchentlich"];
  String _dropDownrepeat;
  final timeController = TextEditingController();
  final timeController1 = TextEditingController();
  final timeController2 = TextEditingController();
  int itemCount = 0;
  TextEditingController nameControllername = TextEditingController();
  TextEditingController nameControllerdose = TextEditingController();
  TextEditingController nameControllerplan = TextEditingController();
  TextEditingController nameControllertext = TextEditingController();
  DateTime dateTimeDay1;
  bool isSwitched = false;

  TimeOfDay timeOfDayTime;

  String fullName = '';
  String fullNameDose = '';
  String fullNameReminder = '';
  List<StatusIcons> statusList = <StatusIcons>[];

  @override
  Widget build(BuildContext context) {
    DateFormat format = DateFormat('dd.MM.yyyy');
    return Container(
      margin: const EdgeInsets.all(15.0),
      //Funktion ermöglich das Scrollen innerhalb der App
      child: SingleChildScrollView(
        child: Column(children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
          ),
          //Name des neuen Medikaments
          TextField(
              controller: nameControllername,
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.drive_file_rename_outline),
                border: OutlineInputBorder(),
                labelText: 'Name',
              ),
              onChanged: (text) {
                setState(() {
                  fullName = text;
                });
              }),
          //Textfeld zum Ausfüllen der Medikamentendosis
          TextField(
              controller: nameControllerdose,
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.drive_file_rename_outline),
                border: OutlineInputBorder(),
                labelText: 'Dosis: z.B. 300mg oder 2 Tabletten',
              ),
              onChanged: (text) {
                setState(() {
                  fullNameDose = text;
                });
              }),
          Divider(
            height: 10,
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              'Icon',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          //Darstellung der auswählbaren Icons von der Klasse StatusWidget --> siehe config/widget/widget.dart
          Row(
            children: [
              StatusWidget(
                widget.key,
                'pill',
                '',
                58858,
                Colors.grey[400],
                statusList,
              ),
              StatusWidget(
                widget.key,
                'pill',
                '',
                58865,
                Colors.grey[400],
                statusList,
              ),
              StatusWidget(
                widget.key,
                'pill',
                '',
                58893,
                Colors.grey[400],
                statusList,
              ),
              StatusWidget(
                widget.key,
                'pill',
                '',
                58905,
                Colors.grey[400],
                statusList,
              ),
              StatusWidget(
                widget.key,
                'pill',
                '',
                57541,
                Colors.grey[400],
                statusList,
              ),
            ],
          ),
          //Darstellung der auswählbaren Farben von der Klasse StatusWidget --> siehe config/widget/widget.dart
          Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              'Farbe',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            children: [
              StatusWidget(
                widget.key,
                'color',
                '',
                57594,
                Colors.red[300],
                statusList,
              ),
              StatusWidget(
                widget.key,
                'color',
                '',
                57594,
                Colors.teal[300],
                statusList,
              ),
              StatusWidget(
                widget.key,
                'color',
                '',
                57594,
                Colors.amberAccent[700],
                statusList,
              ),
              StatusWidget(
                widget.key,
                'color',
                '',
                57594,
                Colors.teal[700],
                statusList,
              ),
            ],
          ),
          Divider(
            thickness: 3,
          ),
          //Switch zum Aktivieren der Erinnerungsfunktion
          Row(
            children: [
              Text(
                "Erinnerungsfunktion:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              Switch(
                value: isSwitched,
                onChanged: (value) {
                  setState(() {
                    //Bei Aktivierung wird isSwitched true
                    isSwitched = value;
                    itemCount = 1;
                  });
                },
                activeColor: Colors.red[300],
              ),
              isSwitched ? Text("Aktiv") : Text("Deaktiviert"),
            ],
          ),
          //Uhrzeit auswählen
          Visibility(
            visible: isSwitched,
            child: Container(
              margin: const EdgeInsets.only(
                left: 15,
              ),
              height: 50,
              child: ListView.builder(
                  itemCount: itemCount,
                  itemBuilder: (BuildContext context, int index) {
                    return TextField(
                      readOnly: true,
                      controller: timeController,
                      decoration: InputDecoration(
                          hoverColor: Colors.blue[200],
                          hintText: 'Uhrzeit auswählen'),
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
                    );
                  }),
            ),
          ),
          //Dropdownmenü für die Auswahl der Wiederholungen
          Container(
            margin: const EdgeInsets.only(
              left: 15,
            ),
            child: Row(children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Wiederholungen: ',
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
                child: DropdownButton(
                  hint: _dropDownrepeat == null
                      ? Text('')
                      : Text(
                          _dropDownrepeat,
                          style: TextStyle(color: Colors.black),
                        ),
                  iconSize: 30.0,
                  style: TextStyle(color: Colors.black),
                  items: repeat.map(
                    (val) {
                      return DropdownMenuItem<String>(
                        value: val,
                        child: Text(val),
                      );
                    },
                    //Bei Auswahl eines Wertes aus dem Dropdownmenü wird die Variable mit diesem Wert befüllt
                  ).toList(),
                  onChanged: (val) {
                    setState(
                      () {
                        _dropDownrepeat = val;
                      },
                    );
                  },
                ),
              ),
            ]),
          ),
          Divider(
            height: 15,
          ),
          //Auswahl des Datums der ersten Einnahme des Medikaments
          Container(
            margin: const EdgeInsets.only(left: 15.0),
            child: TextField(
              readOnly: true,
              controller: dateController1,
              decoration: InputDecoration(
                  hoverColor: Colors.blue[200],
                  hintText: 'Startdatum der Einnahme'),
              //Variablen mit ausgewähltem Dauer befüllen
              onTap: () async {
                var date1 = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100));
                dateController1.value =
                    TextEditingValue(text: format.format(date1));

                setState(() {
                  dateTimeDay1 = date1;
                });
              },
            ),
          ),
          //Auswahl des Datums bis zur letzten Einnahme
          Container(
            margin: const EdgeInsets.all(15.0),
            child: TextField(
              readOnly: true,
              controller: dateController,
              decoration: InputDecoration(
                  hoverColor: Colors.blue[200],
                  hintText: 'Enddatum der Einnahme'),
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
          //Textfeld zum Hinzufügen von einem Erinnerungstext
          Container(
            margin: const EdgeInsets.all(15.0),
            child: TextField(
                controller: nameControllertext,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.drive_file_rename_outline),
                  border: OutlineInputBorder(),
                  labelText: 'Erinnerungstext',
                ),
                //Werte setzen
                onChanged: (text) {
                  setState(() {
                    fullNameReminder = text;
                  });
                }),
          ),
          //Bei Hinzufügen-Button wird die Funktion saveMedication ausgeführt
          ElevatedButton.icon(
            onPressed: () {
              //ausgewählte Felder werden übergeben
              saveMedication(fullName, fullNameDose, statusList,
                  _dropDownrepeat, timeOfDayTime, dateTimeDay1, dateTimeDay);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => BottomNavigation()));
              //Wenn die Erinnerungsfunktion aktiviert wurde wird die Funktion postNotification() ausgelöst und die Felder übergeben
              if (isSwitched) {
                postNotification(fullName, dateTimeDay1, dateTimeDay,
                    timeOfDayTime, _dropDownrepeat);
              }
            },
            icon: Icon(Icons.add, size: 18),
            label: Text("Hinzufügen"),
            style: ElevatedButton.styleFrom(
              primary: Colors.grey[400],
              onPrimary: Colors.black,
              onSurface: Colors.grey,
            ),
          )
        ]),
      ),
    );
  }
}

///Funktion Speichert alle ausgewählten relevanten Felder als Medikation-Objekt --> model/healthy/medicationModel
void saveMedication(
  String name,
  String dose,
  List<StatusIcons> statusList,
  String repeat,
  TimeOfDay timeOfDayTime,
  DateTime begin,
  DateTime end,
) {
//User-ID wird von Firebase geholt
  final User user = FirebaseAuth.instance.currentUser;
  final uid = user.uid;
  StatusIcons icon = statusList.firstWhere((element) => element.id == "pill");
  StatusIcons color = statusList.firstWhere((element) => element.id == "color");
  Medication medication = new Medication(
    userid: uid,
    name: name,
    dose: dose,
    icon: icon,
    color: color,
    repeat: repeat,
    time: timeOfDayTime.toString(),
    begin: begin,
    end: end,
  );
  print(medication.toJson());
  //Medikation-Objekt wird der Funktion medicationSetup() übergeben
  medicationSetup(medication);
}

///Das Medikation-Objekt wird in Firestore in einer Sammlung namens medication gespeichert
Future<void> medicationSetup(Medication medication) async {
  CollectionReference medicationref =
      FirebaseFirestore.instance.collection('medication');
  medicationref.add(medication.toJson());
}

///Funktion erstellt eine Notification mithilfe von OneSignal
Future<void> postNotification(String medication, DateTime begin, DateTime end,
    TimeOfDay time, String repeat) async {
  int i = 0;
  var status = await OneSignal.shared.getPermissionSubscriptionState();
  //User-ID wird von One Signal geholt
  var playerId = status.subscriptionStatus.userId;
  var dateTimebegin =
      DateTime(begin.year, begin.month, begin.day, time.hour - 2, time.minute);
  final dateTimeend =
      DateTime(end.year, end.month, end.day, end.hour, end.minute);
  print(dateTimebegin);
//Bei Auswahl der täglichen Wiederholungen wird die Notification ab dem Startdatum bis zum Enddatum jeden Tag erstellt. Nur 30 Tage im Voraus
  if (repeat == 'Täglich') {
    while (dateTimebegin.isBefore(dateTimeend) && i < 30) {
      await OneSignal.shared.postNotification(OSCreateNotification(
          playerIds: [playerId],
          content: 'Bitte nehmen Sie Ihre Medikamente ein',
          heading: medication,
          sendAfter: dateTimebegin,
          buttons: [
            OSActionButton(text: "Alles klar!", id: "id1"),
          ]));
      dateTimebegin = DateTime(dateTimebegin.year, dateTimebegin.month,
          dateTimebegin.day + 1, dateTimebegin.hour, dateTimebegin.minute);
    }
  }
//Bei Auswahl der täglichen Wiederholungen wird die Notification ab dem Startdatum bis zum Enddatum alle 7 Tage erstellt. Nur 28 Tage im Voraus
  else {
    while (dateTimebegin.isBefore(dateTimeend) && i < 4) {
      await OneSignal.shared.postNotification(OSCreateNotification(
          playerIds: [playerId],
          content: 'Bitte nehmen Sie Ihre Medikamente ein',
          heading: medication,
          sendAfter: dateTimebegin,
          buttons: [
            OSActionButton(text: "Alles klar!", id: "id1"),
          ]));
      dateTimebegin = DateTime(dateTimebegin.year, dateTimebegin.month,
          dateTimebegin.day + 7, dateTimebegin.hour, dateTimebegin.minute);
    }
  }
}
