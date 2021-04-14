import 'package:flutter/material.dart';

class Symptom {
  String id;
  String name;
  int iconData;
  Color color;

  Symptom({this.id, this.name, this.iconData, this.color});

  ///Erhaltene Daten werden aus JSON extrahiert
  factory Symptom.fromJson(Map<String, dynamic> data) {
    return Symptom(
      id: data['id'],
      name: data['name'],
      iconData: data['iconData'],
      color: Color(data['symptom'] as int),
    );
  }

  ///Daten Werden in JSON geschrieben
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'iconData': iconData,
      'color': color.value,
    };
  }
}
