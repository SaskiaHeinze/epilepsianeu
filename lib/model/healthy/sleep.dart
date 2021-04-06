
import 'package:epilepsia/model/healthy/stimmung.dart';


class Sleep {
  String userid;
  DateTime datum;
  String dauerSchlaf;
  StatusIcons sleepicon;

  Sleep({this.userid, this.datum, this.dauerSchlaf, this.sleepicon});

  factory Sleep.fromJson(Map<String, dynamic> data) {
    DateTime _datumfirebase = data['datum'].toDate();
    var datum = data['datum'].toDate();
    return Sleep(
      userid: data['id'],
      datum: datum,
      dauerSchlaf: data['dauerSchlaf'],
      sleepicon: StatusIcons.fromJson(data['sleep']),
    );
  }

  Map<String, dynamic> toJson() {
    Map _sleep = this.sleepicon != null ? this.sleepicon.toJson() : null;
    return {
      'id': userid,
      'datum': datum,
      'dauerSchlaf' : dauerSchlaf,
      'sleep': _sleep,
    };
  }
}
