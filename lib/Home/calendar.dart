//Importieren von Flutter-Pakete
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epilepsia/login/loginview.dart';
import 'package:epilepsia/model/meeting.dart';
import 'package:epilepsia/model/test.dart';
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
  //Erstellen einer Meeting-Liste
  List<Meeting> meetings;
  //Anlegen einer QuerySnapshot-Klasse --> Enthält die Ergebnisse einer Abfrage
  CalendarDataSource querySnapshot;
  //
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
            //Erstellen eines Kalenders
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

  //Funktion zum Löschen eines Kalendereintrags
  void calendarTapped(CalendarTapDetails calendarTapDetails) {
    if (calendarTapDetails.targetElement == CalendarElement.agenda ||
        calendarTapDetails.targetElement == CalendarElement.appointment) {
      final Meeting appointment = calendarTapDetails.appointments[0];
      
      //Dialogfenster wird geöffnet
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text('Soll dieser Eintrag gelöscht werden?'),
              actions: [
                TextButton(
                  //Patrick
                  onPressed: () => Navigator.push(
                      context,
                      //Benutzer wird zur Startseite weitergeleitet
                      MaterialPageRoute(
                          builder: (BuildContext context) => LoginView())),
                  child: Text('Ja'),
                ), 
                TextButton(
                  onPressed: () =>
                      Navigator.pop(context, false), 
                  child: Text('Nein'),
                ),
              ],
            );
          }).then((value) {
        if (value == null) return;
        //Termin wird aus der Datenbank gelöscht
        if (value) {
          FirebaseFirestore firestore = FirebaseFirestore.instance;
          firestore.collection("meeting").doc(appointment.id).delete();
          print("delete");
        } else {}
      });
    }
  }
  //Auslesen der Termindaten aus der Datenbank anhand der collection und der userId
  Future<List<Meeting>> _getDataSource() async {
    meetings = <Meeting>[];

    FirebaseFirestore firestore = FirebaseFirestore.instance;

    var result = await firestore
        .collection("meeting")
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
