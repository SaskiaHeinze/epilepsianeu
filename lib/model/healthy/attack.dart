import 'package:epilepsia/model/healthy/mood.dart';
import 'package:flutter/material.dart';

class Attack {
  String userid;
  DateTime date;
  TimeOfDay time;
  String duration;
  String attackArt;
  StatusIcons symptom;
  String notice;

  Attack(
      {this.userid,
      this.date,
      this.time,
      this.duration,
      this.symptom,
      this.attackArt,
      this.notice});

  factory Attack.fromJson(Map<String, dynamic> data) {
    DateTime _datumfirebase = data['date'].toDate();
      var date = data['date'].toDate();
    var uhrZeit = data["uhrZeit"];
    return Attack(
      userid: data['id'],
      date: date,
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
      'datum': date,
      'uhrZeit': time.toString(),
      'duration': duration,
      'attackArt': attackArt,
      'symptom': _symptom,
      'notice': notice,
    };
  }
}
