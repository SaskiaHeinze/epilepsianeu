import 'package:flutter/material.dart';

class Stress {
  String id;
  String name;
  int iconData;
  Color color;

  Stress({this.id, this.name, this.iconData, this.color});

  ///Erhaltene Daten werden aus JSON extrahiert
  factory Stress.fromJson(Map<String, dynamic> data) {
    return Stress(
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
