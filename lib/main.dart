import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:resqu/screens/NeighboorScreen.dart';
import 'package:resqu/screens/homeScreen.dart';
import 'package:resqu/screens/homescreen_admin.dart';
import 'package:resqu/screens/homescreen_resq.dart';
import 'package:resqu/screens/loginScreen.dart';
import 'package:resqu/screens/notifyListScreen.dart';
import 'package:resqu/screens/signupScreen.dart';
import 'screens/welcomeScreen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var cameras = await availableCameras();

  await Firebase.initializeApp(
    options: FirebaseOptions(apiKey: "AIzaSyB2tqlJL8hB3lMR6yMa4nt6QE0L8lhYHw0",
        appId: "1:305023965649:android:6eafb6dce318aa30a828f0",
        messagingSenderId: "305023965649",
        projectId: "resqu-e142f")
  );
  runApp(MyApp());
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
        "homescreen_resq": (context) =>homeScreenResq(),
        "homescreen_admin": (context) =>homeScreenAdmin(),
        "homescreen": (context) =>homeScreen(),
        "neighbor": (context) =>NeighborsScreen(),
        "noti": (context) =>NotifyListScreen(),




      },
      home: welcomeScreen(),
    );
  }
}
