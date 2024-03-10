import 'package:flutter/material.dart';
import 'package:resqu/screens/NeighboorScreen.dart';
import 'package:resqu/screens/homeScreen.dart';
import 'package:resqu/screens/homescreen_admin.dart';
import 'package:resqu/screens/loginScreen.dart';
import 'package:resqu/screens/notifyListScreen.dart';
import 'package:resqu/screens/signupScreen.dart';
import 'screens/welcomeScreen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.white),
        ),
      ), initialRoute: 'welcomescreen',
      routes: {
        "welcomescreen": (context) => welcomeScreen(),
        "loginscreen": (context) => loginScreen(),
        "signupscreen": (context) => signupScreen(),
        "homescreen": (context) =>homeScreen(),
        "homescreen_admin": (context) =>homeScreenAdmin(),
        "homescreen": (context) =>homeScreen(),
        "neighbor": (context) =>NeighborsScreen(),
        "noti": (context) =>NotifyListScreen(),




      },
      home: welcomeScreen(),
    );
  }
}
