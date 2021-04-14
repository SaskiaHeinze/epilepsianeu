import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epilepsia/model/daily/sportModel.dart';
import 'package:epilepsia/model/healthy/attackModel.dart';
import 'package:epilepsia/model/healthy/sleepModel.dart';
import 'package:epilepsia/model/healthy/StateOfHealthModel.dart';
import 'package:epilepsia/model/healthy/IconModel.dart';
import 'package:epilepsia/config/widget/widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
final User user = FirebaseAuth.instance.currentUser;

class Diary extends StatefulWidget {
  Diary({
    Key key,
  }) : super(key: key);
  @override
  _DiaryState createState() => _DiaryState();
}

var result;

class _DiaryState extends State<Diary> {
  final dateController = TextEditingController();
  List<StatusIcons> statusList = <StatusIcons>[];

  List<StateOfHealthModel> statusDataList = <StateOfHealthModel>[];
  List<Attack> attackDataList = <Attack>[];
  List<Sleep> sleepDataList = <Sleep>[];
  List<Sport> sportDataList = <Sport>[];
  bool getDataBoolStatus = false;
  bool getDataBoolAttack = false;
  bool getDataBoolSleep = false;
  bool getDataBoolSport = false;

  void dispose() {
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateFormat format = DateFormat('dd.MM.yyyy');
    var date;

    return Scaffold(
        //Funktion ermöglich das Scrollen innerhalb der App
        body: SingleChildScrollView(
      child: Column(
        children: [
          //Auswählen eines Tages
          Container(
            margin: EdgeInsets.only(top: 60, bottom: 5, left: 50, right: 50),
            child: TextField(
              readOnly: true,
              controller: dateController,
              decoration: InputDecoration(
                  hoverColor: Colors.blue[200],
                  hintText: 'Auswählen eines Tages'),
              //Beim Auswahl des Tages wird der Tag den folgenden Funktionen übergeben
              onTap: () async {
                date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100));
                dateController.value =
                    TextEditingValue(text: format.format(date));
                statusDataList = await getData(date);
                attackDataList = await getAttackData(date);
                sleepDataList = await getSleepData(date);
                sportDataList = await getSportData(date);
              },
            ),
          ),
          //Wenn keinen Daten zum ausgewählten Tag gefunden werden, wird eine entsprechende Meldung angezeigt
          Container(
              child: Column(
            children: [
              //wird nur angezeigt wenn es keine Daten gibt
              Visibility(
                  visible: getDataBoolStatus &&
                      statusDataList.isEmpty &&
                      getDataBoolAttack &&
                      attackDataList.isEmpty &&
                      getDataBoolSleep &&
                      sleepDataList.isEmpty &&
                      getDataBoolSport &&
                      sportDataList.isEmpty,
                  child: Column(
                    children: [
                      Icon(Icons.warning, size: 60),
                      Text(
                        "Keinen Eintrag gefunden!",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("Bitte Daten speichern!"),
                    ],
                  )),
              //Wenn Daten zum Befinden Gefunden werden Werden diese Angezeigt
              Visibility(
                visible: getDataBoolStatus,
                child: Container(
                  height: 160 *
                      double.parse(statusDataList.length.toStringAsFixed(0)),
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: statusDataList.length,
                      //Gefundene Daten zum Befinden
                      itemBuilder: (BuildContext context, int index) {
                        StateOfHealthModel item = statusDataList[index];
                        var newFormat = DateFormat("dd.MM.yyyy");
                        String updatedDt = newFormat.format(item.dateDay);
                        return Column(children: [
                          Text("Sie haben ausgewählt: " + updatedDt),
                          //ausgewählte Icons werden angezeigt
                          Card(
                            color: Colors.grey[300],
                            child: Row(children: [
                              StatusWidget(
                                widget.key,
                                item.mood.id,
                                item.mood.name,
                                item.mood.iconData,
                                item.mood.color,
                                null,
                              ),
                              StatusWidget(
                                widget.key,
                                item.symptom.id,
                                item.symptom.name,
                                item.symptom.iconData,
                                item.symptom.color,
                                null,
                              ),
                              StatusWidget(
                                widget.key,
                                item.stress.id,
                                item.stress.name,
                                item.stress.iconData,
                                item.stress.color,
                                null,
                              ),
                            ]),
                          ),
                        ]);
                      }),
                ),
              ),
              //Wenn Daten zu Anfall gefunden werden, werden diese angezeigt

              Visibility(
                visible: getDataBoolAttack,
                child: Container(
                  height: 120 *
                      double.parse(attackDataList.length.toStringAsFixed(0)),
                  child: Card(
                    color: Colors.grey[300],
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: attackDataList.length,
                        itemBuilder: (BuildContext context, int index) {
                          Attack item = attackDataList[index];
                          return ListTile(
                            title: Text("Anfall von " + item.duration),
                            subtitle: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: "mit folgender Anfallsart: " +
                                          item.attackArt),
                                  TextSpan(
                                      text: " Symptome: " + item.symptom.name),
                                ],
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            leading: Icon(
                              Icons.warning,
                              size: 40,
                              color: Colors.black,
                            ),
                          );
                        }),
                  ),
                ),
              ),

              //Wenn Daten zum Schlaf gefunden werden, werden diese angezeigt
              Visibility(
                visible: getDataBoolSleep,
                child: Container(
                  height: 130 *
                      double.parse(sleepDataList.length.toStringAsFixed(0)),
                  child: Card(
                    color: Colors.grey[300],
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: sleepDataList.length,
                        itemExtent: 50,
                        itemBuilder: (BuildContext context, int index) {
                          Sleep item = sleepDataList[index];
                          return ListTile(
                            title: Text(item.durationSleep + " h"),
                            subtitle: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(text: "Schlafqualität war: "),
                                  TextSpan(text: item.sleepicon.name),
                                ],
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            leading: Icon(
                              IconData(item.sleepicon.iconData,
                                  fontFamily: 'MaterialIcons'),
                              color: Colors.black,
                              size: 45,
                            ),
                          );
                        }),
                  ),
                ),
              ),
              //Wenn Daten zum Sport gefunden werden, werden diese angezeigt
              Visibility(
                visible: getDataBoolSport,
                child: Container(
                  height: 120 *
                      double.parse(sportDataList.length.toStringAsFixed(0)),
                  child: Card(
                    color: Colors.grey[300],
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: sportDataList.length,
                        itemBuilder: (BuildContext context, int index) {
                          Sport item = sportDataList[index];
                          return ListTile(
                            title: Text("Du hast heute " +
                                item.durationSport +
                                " Sport gemacht"),
                            subtitle: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(text: "Aktivität: "),
                                  TextSpan(text: item.sportIcon.name),
                                ],
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            leading: Icon(
                              IconData(item.sportIcon.iconData,
                                  fontFamily: 'MaterialIcons'),
                              color: Colors.black,
                              size: 45,
                            ),
                          );
                        }),
                  ),
                ),
              ),
            ],
          )),
        ],
      ),
    ));
  }

  ///Auslesen der Statusdaten aus der Datenbank anhand der Sammlung und der userId
  Future<List<StateOfHealthModel>> getData(DateTime date) async {
    List<StateOfHealthModel> list = <StateOfHealthModel>[];

    //Statusdaten werden aus Firestore geholt, bei Übereinstimmung von User-ID mit aktuellem User
    result = await firestore
        .collection("status")
        .where("dateDay", isEqualTo: date)
        .where("id", isEqualTo: user.uid)
        .get();
    //gefundene Daten werden ausgegeben
    result.docs.forEach((result) {
      var data = result.data();
      StateOfHealthModel status = new StateOfHealthModel.fromJson(data);
      list.add(status);
    });

    setState(() {
      getDataBoolStatus = true;
    });

    return list;
  }

  //Auslesen der Anfalldaten aus der Datenbank anhand der Sammlung und der userId
  Future<List<Attack>> getAttackData(DateTime date) async {
    List<Attack> list = <Attack>[];

    //Anfalldaten werden aus Firestore geholt, bei Übereinstimmung von User-ID mit aktuellem User
    result = await firestore
        .collection("attack")
        .where("dateDay", isEqualTo: date)
        .where("id", isEqualTo: user.uid)
        .get();

    //gefundene Daten werden ausgegeben
    result.docs.forEach((result) {
      var data = result.data();
      Attack attack = new Attack.fromJson(data);

      list.add(attack);
    });

    setState(() {
      getDataBoolAttack = true;
    });

    return list;
  }

  //Auslesen der Schlafdaten aus der Datenbank anhand der Sammlung und der userId
  Future<List<Sleep>> getSleepData(DateTime date) async {
    List<Sleep> list = <Sleep>[];

    //Schlafdaten werden aus Firestore geholt, bei Übereinstimmung von User-ID mit aktuellem User
    result = await firestore
        .collection("sleep")
        .where("dateDay", isEqualTo: date)
        .where("id", isEqualTo: user.uid)
        .get();
    //gefundene Daten werden ausgegeben
    result.docs.forEach((result) {
      var data = result.data();
      Sleep sleep = new Sleep.fromJson(data);

      list.add(sleep);
    });

    setState(() {
      getDataBoolSleep = true;
    });

    return list;
  }

  //Auslesen der Sportdaten aus der Datenbank anhand der Sammlung und der userId
  Future<List<Sport>> getSportData(DateTime date) async {
    List<Sport> list = <Sport>[];

    //Sportdaten werden aus Firestore geholt, bei Übereinstimmung von User-ID mit aktuellem User
    result = await firestore
        .collection("sport")
        .where("dateDay", isEqualTo: date)
        .where("id", isEqualTo: user.uid)
        .get();
    //gefundene Daten werden ausgegeben
    result.docs.forEach((result) {
      var data = result.data();
      Sport sport = new Sport.fromJson(data);

      list.add(sport);
    });

    setState(() {
      getDataBoolSport = true;
    });

    return list;
  }
}
