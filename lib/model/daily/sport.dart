import 'package:epilepsia/model/healthy/mood.dart';
import 'package:flutter/material.dart';

class Sport {
  String userid;
  TimeOfDay time;
  String durationSport;
  StatusIcons sportIcon;
  DateTime date;

  Sport({this.userid, this.time, this.durationSport,this.sportIcon,this.date,});

  factory Sport.fromJson(Map<String, dynamic> data) {
    DateTime _datumfirebase = data['datum'].toDate();
    var date = data['date'].toDate();
    var uhrZeit = data["uhrZeit"];
    return Sport(
      userid: data['id'],
      durationSport: data['sportDuration'],
      sportIcon: StatusIcons.fromJson(data['SportIcon']),
      date: date,
    );
  }

  Map<String, dynamic> toJson() {
    Map _sport = this.sportIcon != null ? this.sportIcon.toJson() : null;
    return {
      'id': userid,
      'uhrZeit': time.toString(),
      'sportDuration' : durationSport,
      'SportIcon': _sport,
       'datum': date,
    };
  }
}


