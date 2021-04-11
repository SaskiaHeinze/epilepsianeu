import 'package:epilepsia/model/healthy/mood.dart';
import 'package:flutter/material.dart';

class Status {
  String userid;
  DateTime datum;
  TimeOfDay uhrzeit;
  StatusIcons mood;
  StatusIcons symptom;
  StatusIcons stress;

  Status(
      {this.userid,
      this.datum,
      this.uhrzeit,
      this.mood,
      this.symptom,
      this.stress});

  factory Status.fromJson(Map<String, dynamic> data) {
    DateTime _datumfirebase = data['datum'].toDate();
    var datum = data['datum'].toDate();
    var uhrZeit = data["uhrZeit"];
    return Status(
      userid: data['id'],
      datum: datum,
      mood: StatusIcons.fromJson(data['mood']),
      symptom: StatusIcons.fromJson(data['symptom']),
      stress: StatusIcons.fromJson(data['stress']),
    );
  }

  Map<String, dynamic> toJson() {
    Map _mood = this.mood != null ? this.mood.toJson() : null;
    Map _symptom = this.symptom != null ? this.symptom.toJson() : null;
    Map _stress = this.stress != null ? this.stress.toJson() : null;
    return {
      'id': userid,
      'datum': datum,
      'uhrZeit': uhrzeit.toString(),
      'mood': _mood,
      'symptom': _symptom,
      'stress': _stress
    };
  }
}
