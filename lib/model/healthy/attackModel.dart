import 'package:epilepsia/model/healthy/IconModel.dart';
import 'package:flutter/material.dart';

class Attack {
  String userid;
  DateTime dateDay;
  TimeOfDay time;
  String duration;
  String attackArt;
  StatusIcons symptom;
  String notice;

  Attack(
      {this.userid,
      this.dateDay,
      this.time,
      this.duration,
      this.symptom,
      this.attackArt,
      this.notice});

  ///Erhaltene Daten werden aus JSON extrahiert
  factory Attack.fromJson(Map<String, dynamic> data) {
    var dateDay = data['dateDay'].toDate();
    return Attack(
      userid: data['id'],
      dateDay: dateDay,
      duration: data['duration'],
      attackArt: data['attackArt'],
      symptom: StatusIcons.fromJson(data['symptom']),
      notice: data['notice'],
    );
  }

  ///Daten Werden in JSON geschrieben
  Map<String, dynamic> toJson() {
    Map _symptom = this.symptom != null ? this.symptom.toJson() : null;
    return {
      'id': userid,
      'dateDay': dateDay,
      'uhrZeit': time.toString(),
      'duration': duration,
      'attackArt': attackArt,
      'symptom': _symptom,
      'notice': notice,
    };
  }
}
