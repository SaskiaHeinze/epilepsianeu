import 'package:epilepsia/model/healthy/stimmung.dart';
import 'package:flutter/material.dart';

class Sport {
  String userid;
  TimeOfDay uhrzeit;
  String sportdauer;
  StatusIcons sportart;
  DateTime datum;

  Sport({this.userid, this.uhrzeit, this.sportdauer,this.sportart,this.datum,});

  factory Sport.fromJson(Map<String, dynamic> data) {
    DateTime _datumfirebase = data['datum'].toDate();
    var datum = data['datum'].toDate();
    var uhrZeit = data["uhrZeit"];
    return Sport(
      userid: data['id'],
      sportdauer: data['sportdauer'],
      sportart: StatusIcons.fromJson(data['sportart']),
      datum: datum,
    );
  }

  Map<String, dynamic> toJson() {
    Map _sportart = this.sportart != null ? this.sportart.toJson() : null;
    return {
      'id': userid,
      'uhrZeit': uhrzeit.toString(),
      'sportdauer' : sportdauer,
      'sportart': _sportart,
       'datum': datum,
    };
  }
}


