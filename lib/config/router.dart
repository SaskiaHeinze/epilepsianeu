import 'package:epilepsia/Sport/sport.dart';
import 'package:epilepsia/Home/home.dart';
import 'package:epilepsia/Medication/medication.dart';
import 'package:epilepsia/Health/routing.dart';
import 'package:epilepsia/login/loginview.dart';
import 'package:epilepsia/login/signup.dart';
import 'package:flutter/material.dart';

const String routeHome = '/home';
const String routeHealth = '/routing';
const String routeDaily = '/daily';
const String routeMedication = '/medication';
const String routeLogin = '/';
const String routePrimaryHome = '/loginview';
const String routeSignUp = '/signup';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case routeHome:
        return MaterialPageRoute(builder: (_) => Home());
      case routeMedication:
        return MaterialPageRoute(builder: (_) => MedicationWidget());
      case routeDaily:
        return MaterialPageRoute(builder: (_) => Daily());
      case routeHealth:
        return MaterialPageRoute(builder: (_) => Routing());
      case routeLogin:
        return MaterialPageRoute(builder: (_) => Home());
      case routePrimaryHome:
        return MaterialPageRoute(builder: (_) => LoginView());
      case routeSignUp:
        return MaterialPageRoute(builder: (_) => SignUp());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
