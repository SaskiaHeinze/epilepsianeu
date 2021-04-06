import 'package:flutter/material.dart';

class Stress {
  String id;
  String name;
  int iconData;
  Color color;

  Stress({this.id,this.name, this.iconData, this.color});

  factory Stress.fromJson(Map<String, dynamic> data) {
    return Stress(
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
