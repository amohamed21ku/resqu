import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class homeScreenResq extends StatelessWidget {
  final String userName = "Rescue"; // Example user name

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
                SizedBox(height: 20),
                Expanded(
                  child: ResidentList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ResidentList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('residents').where('has_disability', isEqualTo: true).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final residents = snapshot.data!.docs;

        return ListView.builder(
          itemCount: residents.length,
          itemBuilder: (BuildContext context, int index) {
            final resident = residents[index];
            final floor = resident['floor'].toString(); // Convert to string
            final apartment = resident['apartment'].toString(); // Convert to string
            final fullName = resident['full_name'];
            final disability = resident['disability'];

            return InfoCard(
              floor: floor,
              apartment: apartment,
              fullName: fullName,
              disability: disability,
            );
          },
        );
      },
    );
  }
}

class InfoCard extends StatelessWidget {
  final String floor;
  final String apartment;
  final String fullName;
  final String disability;

  InfoCard({
    required this.floor,
    required this.apartment,
    required this.fullName,
    required this.disability,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      elevation: 5.0,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Floor: $floor, Apartment: $apartment',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5.0),
            Text(
              'Full Name: $fullName',
              style: TextStyle(fontSize: 14.0),
            ),
            SizedBox(height: 5.0),
            Text(
              'Disability: $disability',
              style: TextStyle(fontSize: 14.0),
            ),
          ],
        ),
      ),
    );
  }
}
