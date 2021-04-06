import 'package:epilepsia/model/healthy/status.dart';
import 'package:epilepsia/model/healthy/stimmung.dart';
import 'package:epilepsia/config/widget/widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
final timeController = TextEditingController();
final dateController = TextEditingController();

class Startseite extends StatefulWidget {
  const Startseite({Key key}) : super(key: key);
  @override
  _StartseiteState createState() => _StartseiteState();
}

class _StartseiteState extends State<Startseite> {
  List<StatusIcons> statusList = <StatusIcons>[];

  TimeOfDay timeOfDayTime;
  DateTime dateTimeDay;

  Widget build(BuildContext context) {
    DateFormat format = DateFormat('dd.MM.yyyy');
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
              margin: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Container(
                  
                    child: TextField(
                      readOnly: true,
                      controller: dateController,
                      decoration: InputDecoration(
                          hoverColor: Colors.blue[200],
                          hintText: 'Tag auswählen'),
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
                  TextField(
                    readOnly: true,
                    controller: timeController,
                    decoration: InputDecoration(
                        hoverColor: Colors.blue[200],
                        hintText: 'Zeitpunkt auswählen'),
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
                        'stimmung',
                        'Glücklich',
                        59842,
                        Colors.red[300],
                      
                        statusList,
                      ),
                      StatusWidget(
                        widget.key,
                        'stimmung',
                        'Neutral',
                        59840,
                         Colors.red[300],
                     
                        statusList,
                      ),
                      StatusWidget(
                        widget.key,
                        'stimmung',
                        'Traurig',
                        58361,
                          Colors.red[300],
                        
                        statusList,
                      ),
                      StatusWidget(
                        widget.key,
                        'stimmung',
                        'Gereizt',
                        58365,
                        Colors.red[300],
                        
                        statusList,
                      ),
                    ],
                  ),
                  Divider(
                    height: 10,
                    thickness: 3,
                  ),
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
                        'symptome',
                        'Zucken',
                        58869,
                        Colors.teal[300],
                       
                        statusList,
                      ),
                      StatusWidget(
                        widget.key,
                        'symptome',
                        'Bewusstlos',
                        58419,
                        Colors.teal[300],
                       
                        statusList,
                      ),
                      StatusWidget(
                        widget.key,
                        'symptome',
                        'Krämpfe',
                        60118,
                        Colors.teal[300],
                    
                        statusList,
                      ),
                      StatusWidget(
                        widget.key,
                        'symptome',
                        'Fieber',
                        58534,
                        Colors.teal[300],
                     
                        statusList,
                      ),
                    ],
                  ),
                  Divider(
                    height: 20,
                    thickness: 3,
                  ),
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
                    height: 10,
                    thickness: 3,
                  ),
                
                  Visibility(
                    visible: true,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        print(statusList);
                        saveStatus(statusList, dateTimeDay, timeOfDayTime);
                      },
                      icon: Icon(Icons.add, size: 18),
                label: Text("Hinzufügen"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey[400],
                  onPrimary: Colors.black,
                  onSurface: Colors.grey,
                ),
                    ),
                  )
                ],
              ))),
    );
  }

  void saveStatus(List<StatusIcons> statusList, 
  DateTime dateTimeDay,
      TimeOfDay timeOfDayTime) {
         final User user = FirebaseAuth.instance.currentUser;
      final uid= user.uid;
    StatusIcons stimmung =
        statusList.firstWhere((element) => element.id == "stimmung");
    StatusIcons symptome =
        statusList.firstWhere((element) => element.id == "symptome");
    StatusIcons stress =
        statusList.firstWhere((element) => element.id == "stress");
    Status status = new Status(
        userid: uid,
        datum: dateTimeDay,
        uhrzeit: timeOfDayTime,
        stimmung: stimmung,
        symptome: symptome,
        stress: stress);
    print(status.toJson());
    statusSetup(status);
  }
}

Future<void> statusSetup(Status status) async {
  CollectionReference statusref =
      FirebaseFirestore.instance.collection('status');
  statusref.add(status.toJson());
}
