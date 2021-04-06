import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epilepsia/model/healthy/attack.dart';
import 'package:epilepsia/model/healthy/stimmung.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../config/widget/widget.dart';


FirebaseFirestore firestore = FirebaseFirestore.instance;
final timeController = TextEditingController();
final dateController = TextEditingController();

class Attackwidget extends StatefulWidget {
  Attackwidget({
    Key key,
  }) : super(key: key);
  @override
  _AttackwidgetState createState() => _AttackwidgetState();
}

class _AttackwidgetState extends State<Attackwidget> {
  TextEditingController nameController = TextEditingController();
  String fullName = '';
  List<String> dauer = <String>[
    "10 Minuten",
    "20 Minuten",
    "30 Minuten",
    "45 Minuten",
    "60 Minuten",
    "90 Minuten"
  ];
  List<String> anfallsart = <String>[
    "Vorgefühl",
    "Aura",
    "Fokal klonischer Anfall",
    "Fokal tonischer Anfall",
    "Fokal komplexer Anfall",
    "Fokal komplexer Anfall",
    "Absencen",
    "Grand mal Anfall",
    "Myoklonischer Anfall"
  ];
  List<StatusIcons> statusList = <StatusIcons>[];
  String _dropDownDauer;
  String _dropDownAnfallsart;
  DateTime dateTimeDay;
  TimeOfDay timeOfDayTime;
  String daySelect = "";
  String timeSelect = "";

  @override
  Widget build(BuildContext context) {
    String format = 'dd.MM.yyyy';
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(15.0),
                child: TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                      hoverColor: Colors.blue[200], hintText: (daySelect== "")? "Tag auswählen":daySelect ),
                  onTap: () async {
                    final DateTime picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                    );
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
              Container(
                margin: const EdgeInsets.all(15.0),
                child: TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                      hoverColor: Colors.blue[200],
                      hintText: (timeSelect== "")? "Zeitpunkt auswählen":timeSelect ),

                  onTap: () async {
                   final TimeOfDay picked = await showTimePicker(
                      initialTime: TimeOfDay.now(),
                      context: context,
                    );
                    if (picked != null)
                      setState(() {
                        timeOfDayTime = picked;
                        final MaterialLocalizations localizations = MaterialLocalizations.of(context);
                        timeSelect = localizations.formatTimeOfDay(picked);
                        print(timeSelect);
                      });
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 15, left: 15),
                child: Row(children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'Dauer: ',
                      style: 
                      TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
                    child: DropdownButton(
                      hint: _dropDownDauer == null
                          ? Text('')
                          : Text(
                              _dropDownDauer,
                              style: TextStyle(color: Colors.blue),
                            ),
                      iconSize: 30.0,
                      style: TextStyle(color: Colors.blue),
                      items: dauer.map(
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
                            _dropDownDauer = val;
                          },
                        );
                      },
                    ),
                  ),
                ]),
              ),
              Container(
                margin: const EdgeInsets.only(top: 15, left: 15, bottom: 15),
                child: Row(children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'Anfallsart: ',
                      style: TextStyle(
                        fontSize: 17,
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
                      hint: _dropDownAnfallsart == null
                          ? Text('')
                          : Text(
                              _dropDownAnfallsart,
                              style: TextStyle(color: Colors.blue),
                            ),
                      iconSize: 30.0,
                      style: TextStyle(color: Colors.blue),
                      items: anfallsart.map(
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
                            _dropDownAnfallsart = val;
                          },
                        );
                      },
                    ),
                  ),
                ]),
              ),
              Divider(
                thickness: 3,
              ),
              Container(
                margin: const EdgeInsets.only(top: 15, left: 15),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Symptome',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  StatusWidget(
                    widget.key,
                    'symptome',
                    'Zucken',
                    58869,
                    Colors.amberAccent[700],
                   
                    statusList,
                  ),
                  StatusWidget(
                    widget.key,
                    'symptome',
                    'Bewusstlos',
                    58419,
                   Colors.amberAccent[700],
             
                    statusList,
                  ),
                  StatusWidget(
                    widget.key,
                    'symptome',
                    'Krämpfe',
                    60118,
                    Colors.amberAccent[700],
               
                    statusList,
                  ),
                  StatusWidget(
                    widget.key,
                    'symptome',
                    'Fieber',
                    58534,
                    Colors.amberAccent[700],
                
                    statusList,
                  ),
                ],
              ),
              Divider(
                thickness: 3,
              ),
              Container(
                margin: const EdgeInsets.all(15.0),
                child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.drive_file_rename_outline),
                      border: OutlineInputBorder(),
                      labelText: 'Notizen',
                    ),
                    onChanged: (text) {
                      setState(() {
                        fullName = text;
                      });
                    }),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  saveAttack(statusList, dateTimeDay, timeOfDayTime,
                      _dropDownDauer, _dropDownAnfallsart, fullName);
                },
                icon: Icon(Icons.add, size: 18),
                label: Text("Hinzufügen"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey[400],
                  onPrimary: Colors.black,
                  onSurface: Colors.grey,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void saveAttack(
      List<StatusIcons> statusList,
      DateTime dateTimeDay,
      TimeOfDay timeOfDayTime,
      String dauer,
      String anfallsart,
      String notizen) {
       final User user = FirebaseAuth.instance.currentUser;
      final uid= user.uid;
    StatusIcons symptome =
        statusList.firstWhere((element) => element.id == "symptome");
    Attack attack = new Attack(
        userid: uid,
        datum: dateTimeDay,
        uhrzeit: timeOfDayTime,
        dauer: dauer,
        anfallsart: anfallsart,
        symptome: symptome,
        notizen: notizen);
    print(attack.toJson());
    attackSetup(attack);
  }
}

Future<void> attackSetup(Attack attack) async {
  CollectionReference attackref =
      FirebaseFirestore.instance.collection('attack');
  attackref.add(attack.toJson());
}
