import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:resqu/components.dart';

class signupScreen extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<signupScreen> {
  TextEditingController _idController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _disabilitiesController = TextEditingController();
  TextEditingController _apartmentController = TextEditingController();
  TextEditingController _floorController = TextEditingController();
  TextEditingController _fullNameController = TextEditingController();
  bool _hasDisability = false;
  XFile? pickedFile;

  Future<void> _registerUser() async {
    try {
      // Add user information to Firestore
      await FirebaseFirestore.instance.collection('residents').add({
        'email': _idController.text,
        'password': _passwordController.text,
        'full_name': _fullNameController.text,
        'apartment': _apartmentController.text,
        'floor': _floorController.text,
        'has_disability': _hasDisability,
        'disability': _hasDisability ? _disabilitiesController.text : 'None',
      });
      Navigator.pushNamed(context, 'loginscreen');


      // Navigate to next screen
    } catch (e) {
      // Handle registration errors
      print('Error registering user: $e');
      // Display error message to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Sign Up',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundImage: pickedFile != null ? FileImage(File(pickedFile!.path)) : AssetImage('assets/default_avatar.jpg') as ImageProvider,
            ),
            SizedBox(height: 20),
            RoundedButtonSmall(
              onPressed: () async {
                final ImagePicker _picker = ImagePicker();
                final XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);
                setState(() {
                  pickedFile = pickedImage;
                });
              },
              colour: Colors.red,
              title: 'Upload Profile Picture',
              width: 20,
              height: 20,
              icon: Icons.add,
              iconColor: Colors.black,
              textcolor: Colors.black,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _idController,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              style: TextStyle(color: Colors.black),
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _fullNameController,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _apartmentController,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: 'Apartment',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _floorController,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: 'Floor',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Checkbox(
                  value: _hasDisability,
                  onChanged: (value) {
                    setState(() {
                      _hasDisability = value!;
                    });
                  },
                ),
                Text(
                  'Do you have any disabilities?',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
            if (_hasDisability)
              TextField(
                controller: _disabilitiesController,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  labelText: 'Disabilities',
                  border: OutlineInputBorder(),
                ),
              ),
            SizedBox(height: 20),
            RoundedButtonSmall(
              onPressed: _registerUser,
              colour: Colors.red,
              title: 'Continue',
              width: 20,
              height: 20,
              icon: Icons.arrow_forward,
              iconColor: Colors.black,
              textcolor: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
