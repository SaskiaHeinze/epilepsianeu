import 'package:epilepsia/Health/tabbarRouting.dart';
import 'package:epilepsia/Home/calendar.dart';
import 'package:epilepsia/Sport/sport.dart';
import 'package:epilepsia/Home/home.dart';
import 'package:epilepsia/Medication/medication.dart';

import 'package:epilepsia/login/bottomNavigationBar.dart';
import 'package:epilepsia/login/signup.dart';
import 'package:epilepsia/loginview.dart';
import 'package:flutter/material.dart';

//Wert für Routenpfad wird gesetzt
///Startseite
const String routeHome = '/home';

///Gesundheit
const String routeHealth = '/routing';

///Sport
const String routeDaily = '/daily';

///Medikation
const String routeMedication = '/medication';

///Login
const String routeLogin = '/loginview';

///Untere Navigationsleiste
const String routePrimaryHome = '/bottomNavigationBar';

///Neuanmeldung
const String routeSignUp = '/signup';

///Kalender
const String routeCalendar = '/calendar';

///Routennamen werden zugehörigen Klassen zugeordnet
class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case routeHome:
        return MaterialPageRoute(builder: (_) => Home());
      case routeCalendar:
        return MaterialPageRoute(builder: (_) => Calendar());
      case routeMedication:
        return MaterialPageRoute(builder: (_) => MedicationWidget());
      case routeDaily:
        return MaterialPageRoute(builder: (_) => Daily());
      case routeHealth:
        return MaterialPageRoute(builder: (_) => Routing());
      case routeLogin:
        return MaterialPageRoute(builder: (_) => LoginView());
      case routePrimaryHome:
        return MaterialPageRoute(builder: (_) => BottomNavigation());
      case routeSignUp:
        return MaterialPageRoute(builder: (_) => SignUp());

      //Bei undefinierter Route
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('Keine Route gefunden für ${settings.name}')),
                ));
    }
  }
}
