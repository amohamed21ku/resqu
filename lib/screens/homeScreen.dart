import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:resqu/components.dart';
import 'package:vibration/vibration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:camera/camera.dart';

class homeScreen extends StatefulWidget {
  final String userName = "Abdelrahman Mohamed"; // Example user name

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<homeScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool _isAlarmOn = false;
  late Timer _flashTimer;
  bool _flashOn = false;

  @override
  void initState() {
    super.initState();
    // Get the list of available cameras.
    availableCameras().then((cameras) {
      if (cameras.isNotEmpty) {
        // Initialize the first camera
        _controller = CameraController(cameras[0], ResolutionPreset.medium);
        _initializeControllerFuture = _controller.initialize();
      }
    });
    // Start listening to alarm changes
    FirebaseFirestore.instance
        .collection('alarm')
        .doc('alarm_condition')
        .snapshots()
        .listen((snapshot) {
      if (snapshot.exists) {
        final isEmergency = snapshot.data()?['is_alarm_on'] ?? false;
        setState(() {
          _isAlarmOn = isEmergency;
        });
        if (isEmergency) {
          // If alarm is on, start vibrating and flashing
          startVibratingAndFlashing();
        } else {
          // If alarm is off, stop vibrating and flashing
          stopVibratingAndFlashing();
        }
      }
    });
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    _flashTimer.cancel(); // Cancel the flashing timer
    super.dispose();
  }

  void startVibratingAndFlashing() async {
    // Start vibration
    Vibration.vibrate(duration: 99999999, repeat: 20000);


    // Start flashing
    _flashTimer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      if (_controller != null && _controller.value.isInitialized) {
        toggleFlash();
      }
    });
  }

  void stopVibratingAndFlashing() {
    // Stop vibration
    Vibration.cancel();


    // Stop flashing
    _flashTimer.cancel();
    if (_controller != null && _controller.value.isInitialized) {
      _controller.setFlashMode(FlashMode.off);
    }
    _flashOn = false;
  }

  void toggleFlash() async {
    _flashOn = !_flashOn;
    await _controller.setFlashMode(
        _flashOn ? FlashMode.torch : FlashMode.off);
  }

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
                          widget.userName,
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
                RoundedButtonSmall_Sharb(
                  colour: Colors.red,
                  title: 'Emergency Call',
                  onPressed: () async {
                    await FlutterPhoneDirectCaller.callNumber('112');
                  },
                  width: 0,
                  height: 60,
                  icon: Icons.call,
                  iconColor: Colors.white,
                  textcolor: Colors.white,
                ),
                SizedBox(height: 20),
                // Flashing and Vibrating Widget
                Expanded(
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        _isAlarmOn ? 'Emergency' : 'Safe',
                        style: GoogleFonts.poppins(
                          fontSize: 35,
                          color: _isAlarmOn ? Colors.red : Colors.green,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
