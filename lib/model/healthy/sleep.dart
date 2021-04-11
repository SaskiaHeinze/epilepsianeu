
import 'package:epilepsia/model/healthy/mood.dart';


class Sleep {
  String userid;
  DateTime datum;
  String durationSleep;
  StatusIcons sleepicon;

  Sleep({this.userid, this.datum, this.durationSleep, this.sleepicon});

  factory Sleep.fromJson(Map<String, dynamic> data) {
    DateTime _datumfirebase = data['datum'].toDate();
    var datum = data['datum'].toDate();
    return Sleep(
      userid: data['id'],
      datum: datum,
      durationSleep: data['durationSleep'],
      sleepicon: StatusIcons.fromJson(data['sleep']),
    );
  }

  Map<String, dynamic> toJson() {
    Map _sleep = this.sleepicon != null ? this.sleepicon.toJson() : null;
    return {
      'id': userid,
      'datum': datum,
      'durationSleep' : durationSleep,
      'sleep': _sleep,
    };
  }
}
