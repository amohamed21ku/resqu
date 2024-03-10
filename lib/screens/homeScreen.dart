import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components.dart';

class homeScreen extends StatelessWidget {
  final String userName = "John Doe"; // Example user name

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.red, Colors.blue],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome back,',
                          style: GoogleFonts.poppins(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          userName,
                          style: GoogleFonts.poppins(
                            fontSize: 20.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/profile');
                      },
                      child: Container(
                        alignment: Alignment.topRight,
                        child: CircleAvatar(
                          radius: 30.0,
                          backgroundImage: AssetImage('images/profile.jpg'),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: RoundedButtonSmall(
                        colour: Colors.white,
                        title: 'Notify List',
                        onPressed: () {
                          Navigator.pushNamed(context, 'noti');

                        },
                        width: 10,
                        height: 100,
                        icon: Icons.list_alt,
                        iconColor: Colors.red,
                        textcolor: Colors.black,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: RoundedButtonSmall(
                        colour: Colors.white,
                        title: 'Neighbors',
                        onPressed: () {
                          Navigator.pushNamed(context, 'neighbor');
                        },
                        width: 0,
                        height: 100,
                        icon: Icons.door_back_door_outlined,
                        iconColor: Colors.red,
                        textcolor: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20), // Add space below existing buttons
                // Emergency Button

                RoundedButtonSmall_Sharb(colour: Colors.red, title: 'Emergency Call', onPressed: () async {await FlutterPhoneDirectCaller.callNumber('+905528957541');
                }, width: 0, height: 60,icon: Icons.call, iconColor: Colors.white, textcolor: Colors.white,),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
