import 'package:epilepsia/model/healthy/stimmung.dart';

class Medication {
  String userid;
  String name;
  String dosis;
  StatusIcons icon;
  StatusIcons farbe;
  String wiederholungen;
  DateTime startdatum;
  DateTime enddatum;

  Medication({
    this.userid,
    this.name,
    this.dosis,
    this.icon,
    this.farbe,
    this.wiederholungen,
    this.enddatum,
    this.startdatum,
  });

  factory Medication.fromJson(Map<String, dynamic> data) {
    print(data);
    DateTime enddatum;
    if (data['enddatum'] == null) {
      enddatum = null;
    } else {
      enddatum = DateTime.parse(data['enddatum']);
    }
    DateTime startdatum;
    if (data['startdatum'] == null) {
      startdatum = null;
    } else {
      startdatum = DateTime.parse(data['startdatum']);
    }

    return Medication(
      userid: data['userid'],
      name: data['name'],
      dosis: data['dosis'],
      icon: StatusIcons.fromJson(data['icon']),
      farbe: StatusIcons.fromJson(data['farbe']),
      wiederholungen: data['wiederholungen'],
      startdatum: startdatum,
      enddatum: enddatum,
    );
  }

  Map<String, dynamic> toJson() {
    Map _icon = this.icon != null ? this.icon.toJson() : null;
    Map _farbe = this.farbe != null ? this.farbe.toJson() : null;
    var _startdatum;
    var _enddatum;
    if (startdatum != null) {
      _startdatum = startdatum.toIso8601String();
    } else {
      _startdatum = null;
    }
    if (enddatum != null) {
      _enddatum = enddatum.toIso8601String();
    } else {
      _enddatum = null;
    }
    return {
      'userid': userid,
      'name': name,
      'dosis': dosis,
      'icon': _icon,
      'farbe': _farbe,
      'wiederholungen': wiederholungen,
      'startdatum': _startdatum,
      'enddatum': _enddatum,
    };
  }
}
