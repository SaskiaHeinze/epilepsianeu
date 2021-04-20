import 'package:epilepsia/model/healthy/IconModel.dart';

class Sleep {
  String userid;
  DateTime dateDay;
  String durationSleep;
  StatusIcons sleepicon;

  Sleep({this.userid, this.dateDay, this.durationSleep, this.sleepicon});

  ///Erhaltene Daten werden aus JSON extrahiert
  factory Sleep.fromJson(Map<String, dynamic> data) {
    var dateDay = data['dateDay'].toDate();
    return Sleep(
      userid: data['id'],
      dateDay: dateDay,
      durationSleep: data['durationSleep'],
      sleepicon: StatusIcons.fromJson(data['sleep']),
    );
  }

  ///Daten Werden in JSON geschrieben
  Map<String, dynamic> toJson() {
    Map _sleep = this.sleepicon != null ? this.sleepicon.toJson() : null;
    return {
      'id': userid,
      'dateDay': dateDay,
      'durationSleep': durationSleep,
      'sleep': _sleep,
    };
  }
}
