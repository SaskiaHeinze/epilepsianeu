import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epilepsia/Home/calendar.dart';
import 'package:epilepsia/Home/diary.dart';
import 'package:epilepsia/Home/home.dart';
import 'package:epilepsia/Home/settings.dart';
import 'package:epilepsia/config/farben.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart' hide Router;
import '../config/farben.dart';
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
  // AuthenticationService authenticationService =
  //     AuthenticationService(firebaseAuth: FirebaseAuth.instance);
  // final GoogleSignIn googleSignIn = GoogleSignIn();
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
        backgroundColor: hellblau,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 20),
              width: 400,
              height: 200,
              child: Image.asset('assets/image/image.png'),
            ),
            Padding(
              //Email Textfield
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
              //Password Textfield
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
              //Password Textfield
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
              //Show Error Messages
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: Text(
                message,
                style: TextStyle(color: hellblau),
              ),
            ),
            Container(
              //Login Buttom
              //Starting the Login process
              margin: EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: hellblau, borderRadius: BorderRadius.circular(5)),
              child: TextButton(
                onPressed: () {
                  signUp(email, password, confirm);
                  //Navigator.pushNamed(context, routePrimaryHome);
                },
                child: Text(
                  'Neu Anmelden',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            Divider(
              thickness: 1,
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }

  void signUp(String email, String password, String password2) async {
    var errorMessage;
    if (password == password2) {
      try {
        await auth.createUserWithEmailAndPassword(
            email: email, password: password);
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
                        style: TextStyle(color: hellblau),
                      ),
                    ),
                  ],
                ));
      }
      if (message == '') {
        Navigator.pushNamed(context, routePrimaryHome);
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
                        style: TextStyle(color: hellblau),
                      ))
                ],
              ));
    }
  }
}
