import 'package:epilepsia/model/healthy/stimmung.dart';
import 'package:flutter/material.dart';

class Attack {
  String userid;
  DateTime datum;
  TimeOfDay uhrzeit;
  String dauer;
  String anfallsart;
  StatusIcons symptome;
  String notizen;

  Attack(
      {this.userid,
      this.datum,
      this.uhrzeit,
      this.dauer,
      this.symptome,
      this.anfallsart,
      this.notizen});

  factory Attack.fromJson(Map<String, dynamic> data) {
    DateTime _datumfirebase = data['datum'].toDate();
      var datum = data['datum'].toDate();
    var uhrZeit = data["uhrZeit"];
    return Attack(
      userid: data['id'],
      datum: datum,
      dauer: data['dauer'],
      anfallsart: data['anfallsart'],
      symptome: StatusIcons.fromJson(data['symptome']),
      notizen: data['notizen'],
    );
  }

  Map<String, dynamic> toJson() {
    Map _symptome = this.symptome != null ? this.symptome.toJson() : null;
    return {
      'id': userid,
      'datum': datum,
      'uhrZeit': uhrzeit.toString(),
      'dauer': dauer,
      'anfallsart': anfallsart,
      'symptome': _symptome,
      'notizen': notizen,
    };
  }
}
