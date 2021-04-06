import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epilepsia/login/loginview.dart';
import 'package:epilepsia/model/meeting.dart';
import 'package:epilepsia/model/test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'home.dart';

class Calendar extends StatefulWidget {
  Calendar({
    Key key,
  }) : super(key: key);
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  List<Meeting> meetings;
  CalendarDataSource querySnapshot;
  dynamic data;

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _getDataSource(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data != null) {
            List<Meeting> collection = snapshot.data;
            return SfCalendar(
              view: CalendarView.month,
              dataSource: MeetingDataSource(collection),
              monthViewSettings: MonthViewSettings(
                  showAgenda: true,
                  agendaViewHeight: 200,
                  appointmentDisplayMode:
                      MonthAppointmentDisplayMode.appointment),
              firstDayOfWeek: 1,
              todayHighlightColor: Colors.red.shade200,
              backgroundColor: Colors.blueGrey[50],
              showNavigationArrow: true,
              cellEndPadding: 5,
              selectionDecoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: Colors.blue.shade200, width: 2),
                borderRadius: const BorderRadius.all(Radius.circular(4)),
                shape: BoxShape.rectangle,
              ),
              onTap: calendarTapped,
            );
          } else {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }

  void calendarTapped(CalendarTapDetails calendarTapDetails) {
    if (calendarTapDetails.targetElement == CalendarElement.agenda ||
        calendarTapDetails.targetElement == CalendarElement.appointment) {
      final Meeting appointment = calendarTapDetails.appointments[0];
      print(appointment.toJson());
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text('Soll dieser Eintrag gelöscht werden?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => LoginView())),
                  child: Text('Ja'),
                ), // passing false
                TextButton(
                  onPressed: () =>
                      Navigator.pop(context, false), // passing true
                  child: Text('Nein'),
                ),
              ],
            );
          }).then((value) {
        if (value == null) return;

        if (value) {
          FirebaseFirestore firestore = FirebaseFirestore.instance;
          firestore.collection("termin").doc(appointment.id).delete();
          print("delete");
        } else {}
      });
    }
  }

  Future<List<Meeting>> _getDataSource() async {
    meetings = <Meeting>[];

    FirebaseFirestore firestore = FirebaseFirestore.instance;

    var result = await firestore
        .collection("termin")
        .where("userId", isEqualTo: FirebaseAuth.instance.currentUser.uid)
        .get();
    result.docs.forEach((result) {
      var data = result.data();
      var id = result.id;
      Meeting meeting = Meeting.fromJson(data);
      meeting.id = id;
      meetings.add(meeting);
    });
    return meetings;
  }
}
