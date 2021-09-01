import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yoga_posture_detection/screens/authentication/register_email.dart';
import 'package:yoga_posture_detection/screens/authentication/login.dart';
// import 'package:yoga_posture_detection/screens/authentication/login.dart';
// import 'package:yoga_posture_detection/screens/authentication/register.dart';
import 'package:yoga_posture_detection/screens/authentication/register1.dart';
import 'package:yoga_posture_detection/screens/homeView.dart';
// import 'package:yoga_posture_detection/screens/authentication/phone.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return MaterialApp(
        title: 'Yoga Posture Detection',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Roboto',
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) => snapshot.hasData
              ? HomeView()
              // : Login(),
              :Regsiter1(),
              // : RegsiterEmail(email: 'sanjithjadhav@gmail.com'),
        ));
  }
}
