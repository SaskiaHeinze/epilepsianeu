import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epilepsia/model/medication/medicationModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
final User user = FirebaseAuth.instance.currentUser;

class PlanMedication extends StatefulWidget {
  PlanMedication({
    Key key,
  }) : super(key: key);
  @override
  _PlanMedicationState createState() => _PlanMedicationState();
}

var result;

class _PlanMedicationState extends State<PlanMedication> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Aufbau des Medikamentenplan
    return FutureBuilder(
        
        future: getMedicationData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            //Anzeige eines Ladekreis
            return CupertinoActivityIndicator(
              radius: 20,
            );
          }
          //Bei vorhandenen Daten werden diese angezeigt 
          else {
            var data = snapshot.data as List<Medication>;
            print(data);
            if (data.isNotEmpty) {
              return Scaffold(
                body: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      Medication item = data[index];
                      print(item.toJson());
                      return Card(
                        color: item.color.color,
                        margin:
                            const EdgeInsets.only(right: 25, left: 25, top: 20),
                        //Anzeige des Medikaments 
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                        "Medikamentenname:  " + item.name)),
                                Expanded(
                                  child: Container(
                                      child: Icon(
                                    IconData(item.icon.iconData,
                                        fontFamily: 'MaterialIcons'),
                                  )),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(child: Text("Dosis:  " + item.dose)),
                                Expanded(
                                    child:
                                        Text("Wiederholung:  " + item.repeat)),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
              );
            } 
          }
        });
  }
}
//Auslesen der Medikamentendaten aus der Datenbank anhand der Sammlung und der userId
Future<List<Medication>> getMedicationData() async {
  List<Medication> list = <Medication>[];
//Medikamentdaten werden aus Firestore geholt, bei Übereinstimmung von User-ID mit aktuellem User
  result = await firestore
      .collection("medication")
      .where("id", isEqualTo: user.uid)
      .get();
    //gefundene Daten werden ausgegeben
  result.docs.forEach((result) {
    var data = result.data();
    print(data);
    Medication medication = new Medication.fromJson(data);
    list.add(medication);
  });
  return list;
}
