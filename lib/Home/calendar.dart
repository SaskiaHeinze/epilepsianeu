import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epilepsia/login/bottomNavigationBar.dart';
import 'package:epilepsia/model/meetingModel.dart';
import 'package:epilepsia/model/meetingdataSource.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Calendar extends StatefulWidget {
  Calendar({
    Key key,
  }) : super(key: key);
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  List<Meeting> meetings;

  ///Anlegen einer QuerySnapshot-Klasse --> Enthält die Ergebnisse einer Abfrage
  CalendarDataSource querySnapshot;
  dynamic data;

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _getDataSource(meetings),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data != null) {
            List<Meeting> collection = snapshot.data;
            //Erstellen eines Kalenders aus dem Plugin sysfunktion_flutter_calendar
            return SfCalendar(
              //Monatsansicht
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
              //Termin wird ausgewählt und Funktion calendarTapped wird ausgeführt
              onTap: calendarTapped,
            );
          } else {
            //Anzeige eines Ladekreis, wenn Daten gezogen werden
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

  ///Wenn ein Termin ausgewählt wird kann dieser gelöscht werden
  void calendarTapped(CalendarTapDetails calendarTapDetails) {
    if (calendarTapDetails.targetElement == CalendarElement.agenda ||
        calendarTapDetails.targetElement == CalendarElement.appointment) {
      final Meeting appointment = calendarTapDetails.appointments[0];
      //Debug
      print(appointment.toJson());
      print(appointment.id);
      showDialog(
          context: context,
          builder: (_) {
            //Popup, welcher die Möglichkeit gibt den Termin zu löschen
            return AlertDialog(
              title: Text('Soll dieser Eintrag gelöscht werden?'),
              actions: [
                TextButton(
                  onPressed: () {
                    deleteMeeting(appointment);
                  },
                  child: Text('Ja'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text('Nein'),
                ),
              ],
            );
          });
    }
  }

  ///Wenn Ja ausgewählt wurde wird der Termin in Firestore anhand der id gelöscht
  void deleteMeeting(Meeting appointment) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore.collection('meeting').doc(appointment.id).delete();
    //Debug
    print("delete");
    //Der User wird wieder auf die Startseite zurückgeleitet
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => BottomNavigation()));
  }
}

///Auslesen der Termindaten aus der Datenbank anhand der Sammlung und der userId
Future<List<Meeting>> _getDataSource(List meetings) async {
  meetings = <Meeting>[];

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  //Termindaten werden aus Firestore geholt, bei Übereinstimmung von User-ID mit aktuellem User
  var result = await firestore
      .collection("meeting")
      .where("userId", isEqualTo: FirebaseAuth.instance.currentUser.uid)
      .get();
  //gefundene Daten werden ausgegeben
  result.docs.forEach((result) {
    var data = result.data();
    var id = result.id;
    Meeting meeting = Meeting.fromJson(data);
    meeting.id = id;
    meetings.add(meeting);
  });
  return meetings;
}
