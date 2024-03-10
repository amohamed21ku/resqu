import 'package:flutter/material.dart';

class signupScreen extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<signupScreen> {
  String? _selectedRole;
  TextEditingController _idController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add functionality to upload profile picture
              },
              child: Text('Upload Profile Picture'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _idController,
              decoration: InputDecoration(
                labelText: 'ID Number',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              title: Text('Role'),
              subtitle: Column(
                children: [
                  RadioListTile<String>(
                    title: Text('Rescuer'),
                    value: 'Rescuer',
                    groupValue: _selectedRole,
                    onChanged: (value) {
                      setState(() {
                        _selectedRole = value;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: Text('Admin'),
                    value: 'Admin',
                    groupValue: _selectedRole,
                    onChanged: (value) {
                      setState(() {
                        _selectedRole = value;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: Text('Resident'),
                    value: 'Resident',
                    groupValue: _selectedRole,
                    onChanged: (value) {
                      setState(() {
                        _selectedRole = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add functionality to continue to another page
              },
              child: Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}


