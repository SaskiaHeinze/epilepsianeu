import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  Settings({
    Key key,
  }) : super(key: key);
  @override
  _SettingsState createState() => _SettingsState();
}

///Diese Seite ist noch in Bearbeitung bei besserer Bezahlung können wir uns einig werden :)
class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(30.0),
      child: Column(
        children: <Widget>[
          const ListTile(
            leading: Icon(Icons.room_preferences_sharp, size: 45),
            title: Text('Diese Seite ist in Bearbeitung'),
            subtitle: Text('Bitte haben Sie Geduld'),
          ),
          Image.asset(
            'assets/image/logo.png',
            width: 140,
            height: 90,
          ),
        ],
      ),
    );
  }
}
