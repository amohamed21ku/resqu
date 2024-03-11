import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components.dart';


class welcomeScreen extends StatefulWidget {
  welcomeScreen({super.key});


  @override
  State<welcomeScreen> createState() => _welcomeScreenState();
}

class _welcomeScreenState extends State<welcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  late Animation animation2;
  late Animation animation3;











  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    controller.forward();
    animation = ColorTween(begin: Colors.black45, end: Colors.black)
        .animate(controller);

    animation2 = ColorTween(begin: Colors.black45, end: Colors.redAccent)
        .animate(controller);

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Hero(
                    tag: 'logo',
                    child: Text(
                      'ResqU',
                      style: GoogleFonts.poppins(
                          color: Colors.redAccent,
                          textBaseline: TextBaseline.ideographic,
                          fontSize: 45.0,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: Image.asset(
                  'images/welcome.jpg',
                ),
                height: 173,
                width: 323,
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    flex : 1,
                    child: Text(
                      'Welcome to ResqU!',
                      style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      "Don't Panic! ResqU with U always safier",
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xffc1c1c1)),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    flex: 3,
                    child: RoundedButton(
                      title: 'Get Started',
                      colour: Colors.redAccent,
                      animation2: animation2,
                      animation: animation,
                      onPressed: () {
                        Navigator.pushNamed(context, 'loginscreen');
                      },
                      icon: Icons.arrow_forward,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
