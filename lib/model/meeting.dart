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
      this.userId, this.id});

  /// Event name which is equivalent to subject property of [Appointment].
  String eventName;

  /// From which is equivalent to start time property of [Appointment].
  DateTime from;

  /// To which is equivalent to end time property of [Appointment].
  DateTime to;

  // /// Background which is equivalent to color property of [Appointment].
  Color background;

  /// IsAllDay which is equivalent to isAllDay property of [Appointment].
  bool isAllDay;
  String userId;
  String id;

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

  Map<String, dynamic> toJson() {
    // Map _farbe = this.farbe != null ? this.farbe.toJson() : null;
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
