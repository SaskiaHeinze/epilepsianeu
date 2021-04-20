import 'package:epilepsia/model/healthy/IconModel.dart';
import 'package:flutter/material.dart';

class StateOfHealthModel {
  String userid;
  DateTime dateDay;
  TimeOfDay uhrzeit;
  StatusIcons mood;
  StatusIcons symptom;
  StatusIcons stress;

  StateOfHealthModel(
      {this.userid,
      this.dateDay,
      this.uhrzeit,
      this.mood,
      this.symptom,
      this.stress});

  ///Erhaltene Daten werden aus JSON extrahiert
  factory StateOfHealthModel.fromJson(Map<String, dynamic> data) {
    var dateDay = data['dateDay'].toDate();
    return StateOfHealthModel(
      userid: data['id'],
      dateDay: dateDay,
      mood: StatusIcons.fromJson(data['mood']),
      symptom: StatusIcons.fromJson(data['symptom']),
      stress: StatusIcons.fromJson(data['stress']),
    );
  }

  ///Daten Werden in JSON geschrieben
  Map<String, dynamic> toJson() {
    Map _mood = this.mood != null ? this.mood.toJson() : null;
    Map _symptom = this.symptom != null ? this.symptom.toJson() : null;
    Map _stress = this.stress != null ? this.stress.toJson() : null;
    return {
      'id': userid,
      'dateDay': dateDay,
      'uhrZeit': uhrzeit.toString(),
      'mood': _mood,
      'symptom': _symptom,
      'stress': _stress
    };
  }
}
