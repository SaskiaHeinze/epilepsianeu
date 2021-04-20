import 'package:epilepsia/model/healthy/IconModel.dart';
import 'package:flutter/material.dart';

class Sport {
  String userid;
  TimeOfDay time;
  String durationSport;
  StatusIcons sportIcon;
  DateTime dateDay;

  Sport({
    this.userid,
    this.time,
    this.durationSport,
    this.sportIcon,
    this.dateDay,
  });

  ///Erhaltene Daten werden aus JSON extrahiert
  factory Sport.fromJson(Map<String, dynamic> data) {
    var dateDay = data['dateDay'].toDate();
    return Sport(
      userid: data['id'],
      durationSport: data['sportDuration'],
      sportIcon: StatusIcons.fromJson(data['SportIcon']),
      dateDay: dateDay,
    );
  }

  ///Daten Werden in JSON geschrieben
  Map<String, dynamic> toJson() {
    Map _sport = this.sportIcon != null ? this.sportIcon.toJson() : null;
    return {
      'id': userid,
      'uhrZeit': time.toString(),
      'sportDuration': durationSport,
      'SportIcon': _sport,
      'dateDay': dateDay,
    };
  }
}
