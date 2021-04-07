import 'package:epilepsia/model/healthy/mood.dart';

class Medication {
  String userid;
  String name;
  String dose;
  StatusIcons icon;
  StatusIcons color;
  String repeat;
  DateTime begin;
  DateTime end;

  Medication({
    this.userid,
    this.name,
    this.dose,
    this.icon,
    this.color,
    this.repeat,
    this.end,
    this.begin,
  });

  factory Medication.fromJson(Map<String, dynamic> data) {

    DateTime end;
    if (data['end'] == null) {
      end = null;
    } else {
      end = DateTime.parse(data['end']);
    }
    DateTime begin;
    if (data['begin'] == null) {
      begin = null;
    } else {
      begin = DateTime.parse(data['begin']);
    }

    return Medication(
      userid: data['id'],
      name: data['name'],
      dose: data['dose'],
      icon: StatusIcons.fromJson(data['icon']),
      color: StatusIcons.fromJson(data['color']),
      repeat: data['repeat'],
      begin: begin,
      end: end,
    );
  }

  Map<String, dynamic> toJson() {
    Map _icon = this.icon != null ? this.icon.toJson() : null;
    Map _color = this.color != null ? this.color.toJson() : null;
    var _begin;
    var _end;
    if (begin != null) {
      _begin = begin.toIso8601String();
    } else {
      _begin = null;
    }
    if (end != null) {
      _end = end.toIso8601String();
    } else {
      _end = null;
    }
    return {
      'id': userid,
      'name': name,
      'dosis': dose,
      'icon': _icon,
      'color': _color,
      'repeat': repeat,
      'begin': _begin,
      'end': _end,
    };
  }
}
