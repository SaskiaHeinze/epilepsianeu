import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' hide Router;
import '../config/router.dart';

class SignUp extends StatefulWidget {
  SignUp({
    Key key,
  }) : super(key: key);

  @override
  _SignUp createState() => _SignUp();
}

class _SignUp extends State<SignUp> {
  final auth = FirebaseAuth.instance;

  String email;
  String password;
  String confirm;
  String message = "";
  bool loginFail = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Neuanmeldung"),
        backgroundColor: Colors.grey[400],
      ),
      //Funktion ermöglich das Scrollen innerhalb der App
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 20),
              width: 400,
              height: 200,
              child: Image.asset('assets/image/logo.png'),
            ),
            Padding(
              //Email Textfeld zum Eingeben der Emailadresse
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
              //Password Textfeld zum Eingeben des Passworts
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Passwort',
                  hintText: 'Geben Sie ein sicheres Passwort ein.',
                ),
                onChanged: (String value) {
                  password = value;
                },
              ),
            ),
            Padding(
              //Passwordbestätigungs Textfeld
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Passwort',
                  hintText: 'Wiederholen Sie das Passwort.',
                ),
                onChanged: (String value) {
                  confirm = value;
                },
              ),
            ),
            Container(
              //Login Button
              //Start des Login-Prozesses
              margin: EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.grey[400], borderRadius: BorderRadius.circular(5)),
              child: TextButton(
                onPressed: () {
                  //eingegebene Daten werden der Funktion signUp() übergeben
                 signUp(email, password, confirm);
                  
                },
                child: Text(
                  'Neuanmeldung',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
//Registrierungsprozess mit Firebase
  void signUp(String email, String password, String password2) async {
    var errorMessage;
    //Überprüfung ob Passwort und Bestätigung übereinstimmen
    if (password == password2) {
      try {
        //Funktion zur Registrierung durch das Plugin firebase_auth
        await auth.createUserWithEmailAndPassword(
            email: email, password: password);
      } on FirebaseAuthException catch (e) {
        //bei falscher Eingabe der Daten wird eine entsprechende Fehlermeldung als PopUp ausgegeben
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
                        style: TextStyle(color: Colors.grey[400]),
                      ),
                    ),
                  ],
                ));
      }
      if (message == '') {
        Navigator.pushNamed(context, routePrimaryHome);
        //debug
        print('success');
      }
    } else {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text('Fehler'),
                content: Text('Die Passwörter müssen übereinstimmen'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Verstanden',
                        style: TextStyle(color: Colors.grey[400]),
                      ))
                ],
              ));
    }
  }
}
