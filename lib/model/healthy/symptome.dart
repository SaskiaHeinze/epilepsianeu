import 'package:flutter/material.dart';

class Symptome {
  String id;
  String name;
  int iconData;
  Color color;

  Symptome({this.id, this.name, this.iconData, this.color});

  factory Symptome.fromJson(Map<String, dynamic> data) {
    return Symptome(
      id: data['id'],
      name: data['name'],
      iconData: data['iconData'],
      color: Color(data['symptome'] as int),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'iconData': iconData,
      'color': color.value,
    };
  }
}
