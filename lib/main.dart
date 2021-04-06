import 'package:epilepsia/config/farben.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart' hide Router;

import 'config/router.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'epilepsia',
        theme: ThemeData(
         fontFamily: "Nunito",
          primarySwatch: background,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(),
        onGenerateRoute: Router.generateRoute,
        initialRoute: routeLogin);
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final auth = FirebaseAuth.instance;


  //Deklaireren von Variablen
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
                  hintText: 'Geben Sie ihr Passwort ein.',
                ),
                onChanged: (String value) {
                  password = value;
                },
              ),
            ),
            Container(
              //Show Error Messages
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: Text(
                message,
                style: TextStyle(color: Colors.grey[400]),
              ),
            ),
            Container(
              //Login Buttom
              //Starting the Login process
              margin: EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.grey[400], borderRadius: BorderRadius.circular(5)),
              child: TextButton(
                onPressed: () {
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
              //Buttom to navigate -> SignUpView
              onPressed: () {
                Navigator.pushNamed(context, routeSignUp);
              },
              child: Text('Neuer Kunde? Erstellen Sie ein neues Konto',style: TextStyle(color: Colors.grey[800], fontSize: 15) ),
            ),
          ],
        ),
      ),
    );
  }

  void signUp(String email, String password) {
    showDialog(context: context, builder: (_) => AlertDialog());
    auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  void login(String email, String password) async {
    String errorMessage = '';
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
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
      //print('success');
    }
  }
}
// var authReturn =
//     await authenticationService.signIn(email: email, password: password);
// if (authReturn == "Success") {
//   //Check if login was successfull
//   if (authenticationService.firebaseAuth.currentUser.emailVerified) {
//     //Check if account is Verified
//     Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(builder: (context) => Home()),
//       (Route<dynamic> route) => false,
//     );
//   } else {
//     //Send a verification Email
//     await authenticationService.firebaseAuth.currentUser
//         .sendEmailVerification();
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: Text('Account bestätigen!'),
//         content: Text(
//             'Überprüfen Sie Ihr Postfach und bestätigen Sie Ihr neues Konto!'),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: Text(
//               "Verstanden",
//               style: TextStyle(color: hellblau),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// } else {
//   setState(() {
//     message = authReturn;
//   });
// }
