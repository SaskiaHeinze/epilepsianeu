import 'package:epilepsia/config/authenticationService.dart';
import 'package:epilepsia/config/router.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final auth = FirebaseAuth.instance;
AuthenticationService authenticationService =
    AuthenticationService(firebaseAuth: FirebaseAuth.instance);

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
          Container(
            //Logout Button
            margin: EdgeInsets.all(20),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(5)),
            child: TextButton(
              onPressed: () {
               _showLogoutDialog();
              },
              child: Text(
                'Abmelden',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Abmeldung"),
          content: new Text("Möchten Sie sich abmelden?"),
          actions: <Widget>[
            new TextButton(
                onPressed: () async {
                  var callReturn =
                      await AuthenticationService(firebaseAuth: auth).signOut();
                  if (callReturn == "Success") {
                    Navigator.pushReplacementNamed(context, routeLogin);
                  }
                },
                child: new Text(
                  "Abmelden",
                  style: TextStyle(color: Colors.black),
                )),
            new TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: new Text(
                  "Zurück",
                )),
          ],
        );
      },
    );
  }
}
