import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epilepsia/model/daily/sport.dart';
import 'package:epilepsia/model/healthy/attack.dart';
import 'package:epilepsia/model/healthy/sleep.dart';
import 'package:epilepsia/model/healthy/status.dart';
import 'package:epilepsia/model/healthy/mood.dart';
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

  List<Status> statusDataList = <Status>[];
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
    final timeController = TextEditingController();
    final timeController1 = TextEditingController();
    final dateController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    String fullName = '';
    DateFormat format = DateFormat('dd.MM.yyyy');

    return Scaffold(
        body: SingleChildScrollView(
      child: Column(children: [
        Container(
          margin: EdgeInsets.only(top: 10, bottom: 5, left: 50, right: 50),
          child: TextField(
            readOnly: true,
            controller: dateController,
            decoration: InputDecoration(
                hoverColor: Colors.blue[200],
                hintText: 'Auswählen eines Tages'),
            onTap: () async {
              var date = await showDatePicker(
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
        Container(
            height: 1500,
            child: Column(
              children: [
                Visibility(
                    visible: getDataBoolStatus && statusDataList.isEmpty,
                    child: Container(
                        child: Text("Kein Eintrag für den Status gefunden!"))),
                Visibility(
                  visible: getDataBoolStatus,
                  child: Container(
                    height: 100,
                    child: ListView.builder(
                        itemCount: statusDataList.length,
                        itemBuilder: (BuildContext context, int index) {
                          Status item = statusDataList[index];
                          var newFormat = DateFormat("dd-MM-yyyy");
                          String updatedDt = newFormat.format(item.date);
                          return Container(
                            margin: const EdgeInsets.all(15.0),
                            child: Column(children: [
                              Text(updatedDt),
                              Row(children: [
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
                            ]),
                          );
                        }),
                  ),
                ),
                Visibility(
                    visible: getDataBoolAttack && attackDataList.isEmpty,
                    child: Container(
                        child:
                            Text("Kein Eintrag für einen Anfall gefunden!"))),
                Visibility(
                  visible: getDataBoolAttack,
                  child: Container(
                    height: 100,
                    child: ListView.builder(
                        itemCount: attackDataList.length,
                        itemBuilder: (BuildContext context, int index) {
                          Attack item = attackDataList[index];
                          return Container(
                            height: 200,
                            child: Column(children: [
                              Row(children: [
                                StatusWidget(
                                  widget.key,
                                  item.symptom.id,
                                  item.symptom.name,
                                  item.symptom.iconData,
                                  item.symptom.color,
                                  null,
                                ),
                              ]),
                              Text(item.duration),
                              Text(item.attackArt)
                            ]),
                          );
                        }),
                  ),
                ),
                Visibility(
                    visible: getDataBoolSleep && sleepDataList.isEmpty,
                    child: Container(
                        child:
                            Text("Kein Eintrag für einen Schlaf gefunden!"))),
                Visibility(
                  visible: getDataBoolSleep,
                  child: Container(
                    height: 100,
                    child: ListView.builder(
                        itemCount: sleepDataList.length,
                        itemBuilder: (BuildContext context, int index) {
                          Sleep item = sleepDataList[index];
                          return Container(
                            height: 200,
                            child: Column(children: [
                              Row(children: [
                                StatusWidget(
                                  widget.key,
                                  item.sleepicon.id,
                                  item.sleepicon.name,
                                  item.sleepicon.iconData,
                                  item.sleepicon.color,
                                  null,
                                ),
                              ]),
                              Text(item.durationSleep)
                            ]),
                          );
                        }),
                  ),
                ),
                Visibility(
                    visible: getDataBoolSport && sportDataList.isEmpty,
                    child: Container(
                        child: Text("Kein Eintrag für einen Sport gefunden!"))),
                Visibility(
                  visible: getDataBoolSport,
                  child: Container(
                    height: 100,
                    child: ListView.builder(
                        itemCount: sportDataList.length,
                        itemBuilder: (BuildContext context, int index) {
                          Sport item = sportDataList[index];
                          return Container(
                            height: 200,
                            child: Column(children: [
                              Row(children: [
                                StatusWidget(
                                  widget.key,
                                  item.sportIcon.id,
                                  item.sportIcon.name,
                                  item.sportIcon.iconData,
                                  item.sportIcon.color,
                                  null,
                                ),
                              ]),
                              Text(item.durationSport),
                            ]),
                          );
                        }),
                  ),
                ),
              ],
            )),
      ]),
    ));
  }

  Future<List<Status>> getData(DateTime date) async {
    List<Status> list = <Status>[];

    Timestamp myTimeStamp = Timestamp.fromDate(date);

    result = await firestore
        .collection("status")
        .where("datum", isEqualTo: date)
        .where("id", isEqualTo: user.uid)
        .get();

    result.docs.forEach((result) {
      var data = result.data();
      Status status = new Status.fromJson(data);
      list.add(status);
    });

    setState(() {
      getDataBoolStatus = true;
    });

    return list;
  }

  Future<List<Attack>> getAttackData(DateTime date) async {
    List<Attack> list = <Attack>[];

    Timestamp myTimeStamp = Timestamp.fromDate(date);

    result = await firestore
        .collection("attack")
        .where("datum", isEqualTo: date)
        .where("id", isEqualTo: user.uid)
        .get();

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

  Future<List<Sleep>> getSleepData(DateTime date) async {
    List<Sleep> list = <Sleep>[];

    Timestamp myTimeStamp = Timestamp.fromDate(date);

    result = await firestore
        .collection("sleep")
        .where("datum", isEqualTo: date)
        .where("id", isEqualTo: user.uid)
        .get();

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

  Future<List<Sport>> getSportData(DateTime date) async {
    List<Sport> list = <Sport>[];

    Timestamp myTimeStamp = Timestamp.fromDate(date);

    result = await firestore
        .collection("sport")
        .where("datum", isEqualTo: date)
        .where("id", isEqualTo: user.uid)
        .get();

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
