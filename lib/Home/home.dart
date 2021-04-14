import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epilepsia/config/router.dart';
import 'package:epilepsia/config/widget/widget.dart';
import 'package:epilepsia/model/healthy/IconModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/meetingModel.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class Home extends StatefulWidget {
  Home({
    Key key,
  }) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

final timeController = TextEditingController();
final timeController1 = TextEditingController();
final dateController = TextEditingController();
TextEditingController nameController = TextEditingController();
String fullName = '';
DateFormat format = DateFormat('dd.MM.yyyy');
TimeOfDay from;
TimeOfDay to;
DateTime dateDay;
List<StatusIcons> statusList = <StatusIcons>[];

class _HomeState extends State<Home> {
  List<StatusIcons> statusList = <StatusIcons>[];
  @override
  Widget build(BuildContext context) {
    //PopUp mit Termin erstellen geht auf
    //PopUp wird erst bei klick auf Termin ausgelöst
    final AlertDialog dialog = AlertDialog(
      title: Text('Termin hinzufügen'),
      content: Form(
        //Funktion ermöglich das Scrollen innerhalb der App
        child: SingleChildScrollView(
          child: Column(
            children: [
              //Name für den Termin kann gesetzt werden
              TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.drive_file_rename_outline),
                    border: OutlineInputBorder(),
                    labelText: 'Terminname',
                  ),
                  onChanged: (text) {
                    setState(() {
                      fullName = text;
                    });
                  }),
              //Tag für den Termin kann ausgewählt werden
              Container(
                child: TextField(
                  readOnly: true,
                  controller: dateController,
                  decoration: InputDecoration(
                      hoverColor: Colors.blue[200], hintText: 'Datum'),
                  //Variablen mit ausgewähltem Datum befüllen
                  onTap: () async {
                    var date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100));
                    dateController.value =
                        TextEditingValue(text: format.format(date));

                    setState(() {
                      dateDay = date;
                    });
                  },
                ),
              ),
              //Uhrzeit von kann ausgewählt werden
              TextField(
                readOnly: true,
                controller: timeController,
                decoration: InputDecoration(
                    hoverColor: Colors.blue[200], hintText: 'Von'),
                //Variablen mit ausgewählter Zeit befüllen
                onTap: () async {
                  var time = await showTimePicker(
                    initialTime: TimeOfDay.now(),
                    context: context,
                  );

                  timeController.text = time.format(context);

                  setState(() {
                    from = time;
                  });
                },
              ),
              //Uhrzeit bis kann ausgewählt werden
              TextField(
                readOnly: true,
                controller: timeController1,
                decoration: InputDecoration(
                    hoverColor: Colors.blue[200], hintText: 'Bis'),
                //Variablen mit ausgewählter Zeit befüllen
                onTap: () async {
                  var time = await showTimePicker(
                    initialTime: TimeOfDay.now(),
                    context: context,
                  );
                  timeController1.text = time.format(context);

                  setState(() {
                    to = time;
                  });
                },
              ),
              //Icons für die Art de Termins kann ausgewählt werden
              Row(
                children: [
                  StatusWidget(
                    widget.key,
                    'color',
                    'Arzt',
                    57594,
                    Colors.red[300],
                    statusList,
                  ),
                  StatusWidget(
                    widget.key,
                    'color',
                    'Privat',
                    57594,
                    Colors.teal[300],
                    statusList,
                  ),
                  StatusWidget(
                    widget.key,
                    'color',
                    'Arbeit',
                    57594,
                    Colors.amberAccent[700],
                    statusList,
                  ),
                  StatusWidget(
                    widget.key,
                    'color',
                    'Familie',
                    57594,
                    Colors.teal[700],
                    statusList,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Abbrechen'),
        ),
        //Bei Hinzufügen-Button wird die Funktion saveMeeting ausgeführt
        TextButton(
          onPressed: () {
            //ausgewählte Felder werden übergeben
            saveMeeting(null, fullName, dateDay, from, to, statusList);
            Navigator.pop(context);
          },
          child: Text("Hinzufügen"),
        ),
      ],
    );
    //Aufbau der Startseite
    return Container(
      padding: EdgeInsets.only(bottom: 2),
      color: Colors.blueGrey[50],
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 30),
          ),
          Column(
            children: [
              Container(
                  margin: EdgeInsets.only(left: 10, right: 1),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          //Willkommen Text oben auf der Startseite
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'WILLKOMMEN!',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          //Anzeige unseres Logos
                          Container(
                            margin: const EdgeInsets.only(
                              left: 50,
                            ),
                            alignment: Alignment.center,
                            child: Image.asset(
                              'assets/image/logo.png',
                              width: 140,
                              height: 90,
                            ),
                          ),
                        ],
                      ),
                      //Anzeige unseres Spruches
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          '"Wer den Tag mit einem Lächeln beginnt, hat ihn bereits gewonnen."',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )),
              //Anzeige der Kategorie der Medikation
              Container(
                width: 400,
                margin: EdgeInsets.only(top: 10, bottom: 5, left: 1, right: 1),
                height: 100,
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 10),
                      child: TextButton(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                alignment: Alignment.bottomLeft,
                                child: Column(
                                  children: [
                                    Text(
                                      "Medikation",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                      ),
                                    ),
                                  ],
                                ))
                          ],
                        ), //Weiterleitung zu Medication/medication
                        onPressed: () {
                          Navigator.pushNamed(context, routeMedication);
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        left: 110,
                      ),
                      alignment: Alignment.centerRight,
                      child: Image.asset(
                        'assets/image/medication.png',
                        width: 130,
                        height: 100,
                      ),
                    ),
                  ],
                ),
                color: Colors.red[300],
              ),
              //Anzeige der Kategorie der Gesundheit
              Container(
                width: 400,
                margin: EdgeInsets.only(top: 10, bottom: 5, left: 1, right: 1),
                height: 100,
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.bottomLeft,
                      margin: EdgeInsets.only(left: 10),
                      child: TextButton(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Gesundheit",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ), //Weiterleitung zu Health/stateOfHealth
                        onPressed: () {
                          Navigator.pushNamed(context, routeHealth);
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        left: 100,
                      ),
                      alignment: Alignment.centerRight,
                      child: Image.asset(
                        'assets/image/health2.png',
                        width: 140,
                        height: 100,
                      ),
                    ),
                  ],
                ),
                color: Colors.teal[300],
              ),
              //Anzeige der Kategorie der Sport
              Container(
                width: 400,
                margin: EdgeInsets.only(top: 10, bottom: 5, left: 1, right: 1),
                height: 100,
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.bottomLeft,
                      margin: EdgeInsets.only(left: 10),
                      child: TextButton(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Sport",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                        //Weiterleitung zu Sport/sport
                        onPressed: () {
                          Navigator.pushNamed(context, routeDaily);
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        left: 190,
                      ),
                      alignment: Alignment.centerRight,
                      child: Image.asset(
                        'assets/image/sport.png',
                        width: 90,
                        height: 200,
                      ),
                    ),
                  ],
                ),
                color: Colors.amberAccent[700],
              ),
              //Anzeige der Kategorie der "Termin erstellen"
              Container(
                width: 400,
                margin: EdgeInsets.only(top: 10, bottom: 5, left: 1, right: 1),
                height: 100,
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.bottomLeft,
                      margin: EdgeInsets.only(left: 10),
                      child: TextButton(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Termin",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ), //PopUp wird angezeigt
                        onPressed: () {
                          showDialog<void>(
                              context: context, builder: (context) => dialog);
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        left: 180,
                      ),
                      alignment: Alignment.centerRight,
                      child: Image.asset(
                        'assets/image/termin.png',
                        width: 90,
                        height: 200,
                      ),
                    ),
                  ],
                ),
                color: Colors.teal[700],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

///Funktion Speichert alle Ausgewählten relevanten Felder als TerminObjekt --> model/meetingModel
void saveMeeting(
  String userid,
  String name,
  DateTime dateMeeting,
  TimeOfDay fromdate,
  TimeOfDay todate,
  List<StatusIcons> statusList,
) {
  DateTime from = new DateTime(dateMeeting.year, dateMeeting.month,
      dateMeeting.day, fromdate.hour, fromdate.minute);
  DateTime to = new DateTime(dateMeeting.year, dateMeeting.month,
      dateMeeting.day, todate.hour, todate.minute);
  Meeting meeting = new Meeting(
      eventName: name,
      from: from,
      to: to,
      isAllDay: false,
      background: statusList[0].color,
      //User-ID wird von Firebase geholt
      userId: FirebaseAuth.instance.currentUser.uid);
  //Termin-Objekt wird der Funktion meetingSetup() übergeben
  meetingSetup(meeting);
}

///Das Termin-Objekt wird in Firestore in einer Sammlung namens meeting gespeichert
Future<void> meetingSetup(Meeting meeting) async {
  CollectionReference meetingref =
      FirebaseFirestore.instance.collection('meeting');
  meetingref.add(meeting.toJson());
}
