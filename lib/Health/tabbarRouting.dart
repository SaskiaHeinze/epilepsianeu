import 'package:epilepsia/Health/attack.dart';
import 'package:epilepsia/Health/sleep.dart';
import 'package:epilepsia/Health/stateOfHealth.dart';
import 'package:flutter/material.dart';

class Routing extends StatefulWidget {
   Routing({Key key,}) : super(key: key);
  @override
  _RoutingState createState() => _RoutingState();
}

class _RoutingState extends State<Routing> {
  @override
   Widget build(BuildContext context) {


    return DefaultTabController(
  length: 3,
  child: Scaffold(
    //Anzeige der oberen Leiste (Appbar) bei Gesundheit
    appBar: AppBar(
      backgroundColor: Colors.teal[300],
      bottom: TabBar(
        indicatorColor: Colors.black,
        indicatorSize: TabBarIndicatorSize.label,
        labelColor: Colors.black,
        tabs: [
          Tab(icon: Icon(Icons.spa), text: 'Befinden',),
          Tab(icon: Icon(Icons.warning), text: 'Anfall',),
          Tab(icon: Icon(Icons.hotel), text: 'Schlaf'),
        ],
      ),
    ),
  //Zuordnung der Klassen bei der Appbar
  body: TabBarView(
           children:[
             StateOfHealth(),
             Attackwidget(),
             SleepWidget(), ]
 
  ),
),
          );
   }
}

