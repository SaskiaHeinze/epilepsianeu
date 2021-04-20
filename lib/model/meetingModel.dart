import 'package:flutter/widgets.dart';

/// Custom business object class which contains properties to hold the detailed
/// information about the event data which will be rendered in calendar.
class Meeting {
  /// Creates a meeting class with required details.
  Meeting(
      {this.eventName,
      this.from,
      this.to,
      this.isAllDay,
      this.background,
      this.userId,
      this.id});

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
  String userId;
  String id;

  ///Erhaltene Daten werden aus JSON extrahiert
  factory Meeting.fromJson(Map<String, dynamic> data) {
    DateTime dateTimeFrom = DateTime.parse(data['from']);
    DateTime dateTimeTo = DateTime.parse(data['to']);
    Color color = Color(data['background']);
    return Meeting(
      eventName: data['eventName'],
      from: dateTimeFrom,
      to: dateTimeTo,
      background: color,
      isAllDay: data['isAllDay'],
      userId: data['userId'],
    );
  }

  ///Daten Werden in JSON geschrieben
  Map<String, dynamic> toJson() {
    return {
      'eventName': eventName,
      'from': from.toIso8601String(),
      'to': to.toIso8601String(),
      'isAllDay': isAllDay,
      'background': background.value,
      'userId': userId,
    };
  }
}
