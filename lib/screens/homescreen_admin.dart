import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vibration/vibration.dart';
import 'package:camera/camera.dart';

class homeScreenAdmin extends StatefulWidget {
  @override
  State<homeScreenAdmin> createState() => _homeScreenAdminState();
}

class _homeScreenAdminState extends State<homeScreenAdmin> {
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

  final String userName = "Admin";
  // Example user name

  void startVibratingAndFlashing() async {
    // Start vibration
      Vibration.vibrate(duration: 999999, repeat: 1000000);


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
              colors: [Colors.blue, Colors.yellow],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // Building Information Box
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
                SizedBox(height: 20,),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Building Information',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Address: 123 Main St, City, Country',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Owner: Kenan Abbasov',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),

                // Huge Circle with Gesture Detector
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('alarm').snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      }

                      final isEmergency = snapshot.data?.docs.first['is_alarm_on'] ?? false;
                      _isAlarmOn = isEmergency;

                      return GestureDetector(
                        onTap: () async {
                          // Change the value from false to true
                          await FirebaseFirestore.instance.collection('alarm').doc('alarm_condition').update({
                            'is_alarm_on': true,
                          });
                          // Add functionality for emergency call
                        },
                        child: Container(
                          width: 300.0,
                          height: 300.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isEmergency ? Colors.red : Colors.blue, // Change color based on emergency
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
                              isEmergency ? 'Emergency' : 'Alarm',
                              style: GoogleFonts.poppins(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
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
