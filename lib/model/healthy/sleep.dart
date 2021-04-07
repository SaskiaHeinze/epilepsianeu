
import 'package:epilepsia/model/healthy/mood.dart';


class Sleep {
  String userid;
  DateTime date;
  String durationSleep;
  StatusIcons sleepicon;

  Sleep({this.userid, this.date, this.durationSleep, this.sleepicon});

  factory Sleep.fromJson(Map<String, dynamic> data) {
    DateTime _datumfirebase = data['date'].toDate();
    var date = data['date'].toDate();
    return Sleep(
      userid: data['id'],
      date: date,
      durationSleep: data['durationSleep'],
      sleepicon: StatusIcons.fromJson(data['sleep']),
    );
  }

  Map<String, dynamic> toJson() {
    Map _sleep = this.sleepicon != null ? this.sleepicon.toJson() : null;
    return {
      'id': userid,
      'datum': date,
      'durationSleep' : durationSleep,
      'sleep': _sleep,
    };
  }
}
