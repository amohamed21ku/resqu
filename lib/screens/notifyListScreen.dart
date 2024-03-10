import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/infocard.dart';

class NotifyListScreen extends StatefulWidget {
  @override
  _NotifyListScreenState createState() => _NotifyListScreenState();
}

class _NotifyListScreenState extends State<NotifyListScreen> {
  List<Person> notifyList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Notify List',style: GoogleFonts.poppins(fontWeight: FontWeight.w500),),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.red, Colors.blue],
          ),
        ),

        child: ListView.builder(
          itemCount: Person.allPersons.length,
          itemBuilder: (context, index) {
            final person = Person.allPersons[index];
            return infoCard(
              name: person.name,
              Date: person.number,
              onpress: () async {
                await FlutterPhoneDirectCaller.callNumber('${person.number}');
              },
              intial: '${person.name[0]}',
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddPersonDialog(context);
        },
        child: Icon(Icons.person_add),
      ),
    );
  }

  Future<void> _showAddPersonDialog(BuildContext context) async {
    String name = '';
    String number = '';

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Person'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Name'),
                onChanged: (value) {
                  name = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Number'),
                onChanged: (value) {
                  number = value;
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  Person(name: name, number: number);
                });
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}

class Person {
  final String name;
  final String number;
  static List<Person> allPersons = [];

  Person({required this.name, required this.number}) {
    allPersons.add(this);
  }
}
