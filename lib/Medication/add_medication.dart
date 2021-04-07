import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epilepsia/model/healthy/mood.dart';
import 'package:epilepsia/config/widget/widget.dart';
import 'package:epilepsia/model/medication/medication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:epilepsia/model/pushnotification.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
//FirebaseMessaging _messaging = FirebaseMessage();

class AddMedication extends StatefulWidget {
  AddMedication({
    Key key,
  }) : super(key: key);
  @override
  _AddMedicationState createState() => _AddMedicationState();
}

class _AddMedicationState extends State<AddMedication> {
  DateTime dateTimeDay;
  List<bool> _values = [true, false, true, false, false];
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
  List<String> timeOfDayTimeList = [];

  String fullName = '';
  String fullNameDose = '';
  String fullNameReminder = '';
  List<StatusIcons> statusList = <StatusIcons>[];

  @override
  Widget build(BuildContext context) {
    final int count = 1;
    DateFormat format = DateFormat('dd.MM.yyyy');
    return Container(
      margin: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 5, left: 10),
              ),
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
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Icon',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
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
              Container(
                margin: const EdgeInsets.only(left: 15.0),
                child: Row(children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'Wiederholungen: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  VerticalDivider(
                    width: 20,
                  ),
                  Container(
                    margin:
                        EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
                    child: DropdownButton(
                      hint: _dropDownrepeat == null
                          ? Text('')
                          : Text(
                              _dropDownrepeat,
                              style: TextStyle(color: Colors.blue),
                            ),
                      iconSize: 30.0,
                      style: TextStyle(color: Colors.blue),
                      items: repeat.map(
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
                            _dropDownrepeat = val;
                          },
                        );
                      },
                    ),
                  ),
                ]),
              ),
              Row(
                children: [
                  Text("Erinnerungsfunktion:"),
                  Switch(
                    value: isSwitched,
                    onChanged: (value) {
                      setState(() {
                        isSwitched = value;
                      });
                    },
                    activeColor: Colors.green,
                  ),
                  isSwitched ? Text("Aktiv") : Text("Deaktiviert"),
                ],
              ),
              Row(children: [
                Text("Anzahl der Pilleneinnahmen - Uhrzeit auswählen --> "),
                IconButton(
                  icon: Icon(Icons.add_alarm),
                  onPressed: () {
                    setState(() {
                      itemCount = 1;
                    });
                  },
                ),
              ]),
              Container(
                height: 60,
                child: ListView.builder(
                    itemCount: itemCount,
                    itemBuilder: (BuildContext context, int index) {
                      return TextField(
                        readOnly: true,
                        controller: timeController,
                        decoration: InputDecoration(
                            hoverColor: Colors.blue[200],
                            hintText: 'Uhrzeit auswählen'),
                        onTap: () async {
                          var time = await showTimePicker(
                            initialTime: TimeOfDay.now(),
                            context: context,
                          );
                          timeController.text = time.format(context);
                        },
                      );
                    }),
              ),
              Divider(
                height: 15,
              ),
              Container(
                margin: const EdgeInsets.only(left: 15.0),
                child: TextField(
                  readOnly: true,
                  controller: dateController1,
                  decoration: InputDecoration(
                      hoverColor: Colors.blue[200],
                      hintText: 'Startdatum der Einnahme'),
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
              Container(
                margin: const EdgeInsets.only(right: 15.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    '*Kann auch leer gelassen werden',
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(15.0),
                child: TextField(
                    controller: nameControllertext,
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.drive_file_rename_outline),
                      border: OutlineInputBorder(),
                      labelText: 'Erinnerungstext',
                    ),
                    onChanged: (text) {
                      setState(() {
                        fullNameReminder = text;
                      });
                    }),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  saveMedication(fullName, fullNameDose, statusList,
                      _dropDownrepeat, dateTimeDay1, dateTimeDay);
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

void saveMedication(
   // String userid,
    String name,
    String dose,
    List<StatusIcons> statusList,
    String repeat,
    DateTime begin,
    DateTime end) {
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
    begin: begin,
    end: end,
  );
  print(medication.toJson());
  medicationSetup(medication);
}

void pushNotification(){
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  PushNotification _notificationInfo;
  
      //PushNotification notification = PushNotification.fromJson(data);

     
    
  
}

Future<void> medicationSetup(Medication medication) async {
  CollectionReference medicationref =
      FirebaseFirestore.instance.collection('medication');
  medicationref.add(medication.toJson());
}
