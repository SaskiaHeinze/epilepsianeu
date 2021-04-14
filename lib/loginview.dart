import 'package:epilepsia/config/router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  LoginView({
    Key key,
  }) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final auth = FirebaseAuth.instance;

  //Deklarieren von Variablen
  String email;
  String password;
  String message = "";
  bool loginFail = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(""),
        backgroundColor: Colors.grey[400],
      ),
      //Funktion ermöglich das Scrollen innerhalb der App
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 20),
              width: 400,
              height: 150,
              child: Image.asset('assets/image/logo.png'),
            ),
            Padding(
              //Email Textfeld zum Ausfüllen
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  hintText: 'Geben Sie eine gültige Email ein.',
                ),
                onChanged: (String value) {
                  email = value;
                },
              ),
            ),
            Padding(
              //Password Textfeld zum Ausfüllen
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Passwort',
                  hintText: 'Geben Sie ihr Passwort ein.',
                ),
                onChanged: (String value) {
                  password = value;
                },
              ),
            ),
            Container(
              //Login Button
              //Login-Prozess starten
              margin: EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(5)),
              child: TextButton(
                onPressed: () {
                  //Ausgefüllte Felder werden an login() gegeben
                  login(email, password);
                },
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.grey[800], fontSize: 20),
                ),
              ),
            ),
            Divider(
              thickness: 1,
            ),
            SizedBox(
              height: 50,
            ),
            TextButton(
              //Weiterleitung zur Neuanmeldung
              onPressed: () {
                Navigator.pushNamed(context, routeSignUp);
              },
              child: Text('Neuer Kunde? Erstellen Sie ein neues Konto',
                  style: TextStyle(color: Colors.grey[800], fontSize: 15)),
            ),
          ],
        ),
      ),
    );
  }

  ///Loginprozess mit Firebase
  void login(String email, String password) async {
    String errorMessage = '';
    try {
      //Funktion zur Registrierung durch das Plugin firebase_auth
      await auth.signInWithEmailAndPassword(email: email, password: password);
      //bei falscher Eingabe der Daten wird eine entsprechende Fehlermeldung als PopUp ausgegeben
    } on FirebaseAuthException catch (e) {
      errorMessage = e.message;
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text('Es ist was schief gelaufen'),
                content: Text(errorMessage),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Verstanden",
                      style: TextStyle(color: Colors.amberAccent[700]),
                    ),
                  ),
                ],
              ));
    }
    if (errorMessage == '') {
      Navigator.pushNamed(context, routePrimaryHome);
    }
  }
}
