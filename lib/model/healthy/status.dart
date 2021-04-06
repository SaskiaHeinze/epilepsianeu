import 'package:epilepsia/model/healthy/stimmung.dart';
import 'package:flutter/material.dart';

class Status {
  String userid;
  DateTime datum;
  TimeOfDay uhrzeit;
  StatusIcons stimmung;
  StatusIcons symptome;
  StatusIcons stress;

  Status(
      {this.userid,
      this.datum,
      this.uhrzeit,
      this.stimmung,
      this.symptome,
      this.stress});

  factory Status.fromJson(Map<String, dynamic> data) {
    DateTime _datumfirebase = data['datum'].toDate();
    var datum = data['datum'].toDate();
    var uhrZeit = data["uhrZeit"];
    print(datum);
    return Status(
      userid: data['id'],
      datum: datum,
      //uhrzeit: uhrZeit,
      stimmung: StatusIcons.fromJson(data['stimmung']),
      symptome: StatusIcons.fromJson(data['symptome']),
      stress: StatusIcons.fromJson(data['stress']),
    );
  }

  Map<String, dynamic> toJson() {
    Map _stimmung = this.stimmung != null ? this.stimmung.toJson() : null;
    Map _symptome = this.symptome != null ? this.symptome.toJson() : null;
    Map _stress = this.stress != null ? this.stress.toJson() : null;
    return {
      'id': userid,
      'datum': datum,
      'uhrZeit': uhrzeit.toString(),
      'stimmung': _stimmung,
      'symptome': _symptome,
      'stress': _stress
    };
  }
}
