import 'package:flutter/material.dart';

class StatusIcons {
  String id;
  String name;
  int iconData;
  Color color;

  StatusIcons({
    this.id,
    this.name,
    this.iconData,
    this.color,
  });

  ///Erhaltene Daten werden aus JSON extrahiert
  factory StatusIcons.fromJson(Map<String, dynamic> data) {
    return StatusIcons(
      id: data['id'],
      name: data['name'],
      iconData: data['iconData'],
      color: Color(data['color'] as int),
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
