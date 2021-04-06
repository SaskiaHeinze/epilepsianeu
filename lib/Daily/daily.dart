import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epilepsia/Home/home.dart';
import 'package:epilepsia/model/daily/sport.dart';
import 'package:epilepsia/model/healthy/stimmung.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../config/widget/widgetsport.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

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
  List<String> sportdauer = <String>[
    "10 Minuten",
    "20 Minuten",
    "30 Minuten",
    "45 Minuten",
    "60 Minuten",
    "90 Minuten"
  ];
  String _dropDownSportdauer;
  DateTime dateTimeDay;
  String daySelect = "";
  @override
  Widget build(BuildContext context) {
    String format = 'dd.MM.yyyy';

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              saveSport(statusList, timeOfDayTime, _dropDownSportdauer, dateTimeDay);
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 30.0),
          child: Column(children: [
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
              margin: const EdgeInsets.all(15),
              child: TextField(
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
            ),
            Divider(
              height: 15,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                'Wie lange machst du heute Sport?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
              child: DropdownButton(
                hint: _dropDownSportdauer == null
                    ? Text('Sportdauer')
                    : Text(
                        _dropDownSportdauer,
                        style: TextStyle(color: Colors.blue),
                      ),
                iconSize: 30.0,
                style: TextStyle(color: Colors.blue),
                items: sportdauer.map(
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
                      _dropDownSportdauer = val;
                    },
                  );
                },
              ),
            ),
            Row(
              children: [
                SportWidget(widget.key, 'sportart', 'Joggen', 59070,
                    Colors.grey[300],statusList),
                SportWidget(widget.key, 'sportart', 'Gehen', 59073, Colors.grey[300],
                    statusList),
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

void saveSport(
  List<StatusIcons> statusList,
  TimeOfDay timeOfDayTime,
  String sportdauer,
  DateTime dateTimeDay,
) {
   final User user = FirebaseAuth.instance.currentUser;
      final uid= user.uid;
  StatusIcons sportart =
      statusList.firstWhere((element) => element.id == "sportart");
  Sport sporti = new Sport(
    userid: uid,
    uhrzeit: timeOfDayTime,
    sportdauer: sportdauer,
    sportart: sportart,
    datum: dateTimeDay,
  );
  print(sporti.toJson());
  sportSetup(sporti);
}

Future<void> sportSetup(Sport sport) async {
  CollectionReference sportref = FirebaseFirestore.instance.collection('sport');
  sportref.add(sport.toJson());
}
