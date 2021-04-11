import 'package:epilepsia/model/healthy/mood.dart';
import 'package:flutter/material.dart';

class Attack {
  String userid;
  DateTime datum;
  TimeOfDay time;
  String duration;
  String attackArt;
  StatusIcons symptom;
  String notice;

  Attack(
      {this.userid,
      this.datum,
      this.time,
      this.duration,
      this.symptom,
      this.attackArt,
      this.notice});

  factory Attack.fromJson(Map<String, dynamic> data) {
    DateTime _datumfirebase = data['datum'].toDate();
    var datum = data['datum'].toDate();
    var uhrZeit = data["uhrZeit"];
    return Attack(
      userid: data['id'],
      datum: datum,
      duration: data['duration'],
      attackArt: data['attackArt'],
      symptom: StatusIcons.fromJson(data['symptom']),
      notice: data['notice'],
    );
  }

  Map<String, dynamic> toJson() {
    Map _symptom = this.symptom != null ? this.symptom.toJson() : null;
    return {
      'id': userid,
      'datum': datum,
      'uhrZeit': time.toString(),
      'duration': duration,
      'attackArt': attackArt,
      'symptom': _symptom,
      'notice': notice,
    };
  }
}
