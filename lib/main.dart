import 'package:epilepsia/config/color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'config/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Firebase wird initialisiert bevor die App gestartet wird
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//Initalisierung der App
    return MaterialApp(
        title: 'epilepsia',
        theme: ThemeData(
          fontFamily: "Nunito",
          primarySwatch: background,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(),
        onGenerateRoute: Router.generateRoute,
        //Bei Start der App wird der Login Screen angezeigt
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
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(width: 0.0, height: 0.0);
  }
}

///Initialisierung der Notificationfunktion und Verbindung zu OneSignal
Future<void> initPlatformState() async {
  //benötigt für die Registrierung bei OneSignal
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  OneSignal.shared
      .setNotificationReceivedHandler((OSNotification notification) {});

  OneSignal.shared
      .setNotificationOpenedHandler((OSNotificationOpenedResult result) {});

  OneSignal.shared
      .setSubscriptionObserver((OSSubscriptionStateChanges changes) {});

  OneSignal.shared.setEmailSubscriptionObserver(
      (OSEmailSubscriptionStateChanges emailChanges) {});

//Die App wird bei OneSignal initialisiert
  OneSignal.shared.init("b2398587-9bd3-4215-a54c-36cd18191eb2");

  OneSignal.shared
      .setInFocusDisplayType(OSNotificationDisplayType.notification);
}
