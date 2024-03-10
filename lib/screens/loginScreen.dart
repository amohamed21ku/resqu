import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../components.dart';
import '../constants.dart';

class loginScreen extends StatefulWidget {
  loginScreen({Key? key}) : super(key: key);

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen>
    with SingleTickerProviderStateMixin {
  bool showSpinner = false;
  String username = '';
  String pass = '';

  late AnimationController controller;
  late Animation<Color?> animation;
  late Animation<Color?> animation2;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    controller.forward();
    animation = ColorTween(begin: Colors.redAccent, end: Colors.black)
        .animate(controller);
    animation2 = ColorTween(begin: Colors.white, end: Colors.redAccent).animate(controller);


    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.red, Colors.white],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: ModalProgressHUD(
                  inAsyncCall: showSpinner,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: Column(
                      // The main Coloum
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Hero(
                                tag: 'logo',
                                child: Text(
                                  'ResqU',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    textBaseline: TextBaseline.ideographic,
                                    fontSize: 45.0,
                                    fontWeight: FontWeight.w900,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'Login',
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    'Access account',
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Column(
                            children: [
                              TextField(
                                style: GoogleFonts.poppins(color: Colors.black),
                                keyboardType: TextInputType.emailAddress,
                                onChanged: (value) {
                                  username = value;
                                  //Do something with the user input.
                                },
                                decoration: kTextfielDecoration.copyWith(
                                  hintText: "Enter your T.C number",
                                  prefixIcon: Icon(
                                    Icons.perm_identity,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              TextField(
                                style: GoogleFonts.poppins(color: Colors.black),
                                obscureText: true,
                                onChanged: (value) {
                                  //Do something with the user input.
                                  pass = value;
                                },
                                decoration: kTextfielDecoration.copyWith(
                                  hintText: "Enter your Password",
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              RoundedButton(
                                title: 'Login',
                                colour: Colors.redAccent,
                                animation2: animation2,
                                animation: animation,
                                onPressed: () {
                                  if(username == 'admin' && pass=='admin'){
                                    Navigator.pushNamed(context, "homescreen_admin");
                                  }
                                  else if(username == 'rescue' && pass == 'rescue'){
                                    Navigator.pushNamed(context, "homescreen_rescue");


                                  }else{
                                  Navigator.pushNamed(context, "homescreen");}
                                },
                                icon: Icons.arrow_forward,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, "signupscreen");
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Don't have an account?  ",
                                      style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      'Signup',
                                      style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.redAccent,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
