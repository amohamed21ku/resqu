import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/infocard.dart';

class NeighborsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Neighbors',style: GoogleFonts.poppins(fontWeight: FontWeight.w500),),
      ),
      body: Container(  decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.red, Colors.blue],
        ),
      ),
        child: ListView.builder(
          itemCount: neighborsList.length, // Assuming neighborsList is a list of neighbor objects
          itemBuilder: (context, index) {
            final neighbor = neighborsList[index];
            return infoCard(
              name: neighbor.name,
              icon: neighbor.icon,
              Date: neighbor.date,
              intial: neighbor.initial,
              onpress: () {
                // Handle tapping on neighbor card
              },
            );
          },
        ),
      ),
    );
  }
}

// Define a neighbor class to hold the information
class Neighbor {
  String name;
  IconData icon;
  String date;
  String initial;

  Neighbor({
    required this.name,
    required this.icon,
    required this.date,
    required this.initial,
  });
}

// Example list of neighbors
List<Neighbor> neighborsList = [
  Neighbor(
    name: 'John Doe',
    icon: Icons.person,
    date: 'Floor 5, Door 10',
    initial: 'JD',
  ),
  Neighbor(
    name: 'Jane Smith',
    icon: Icons.person,
    date: 'Floor 3, Door 7',
    initial: 'JS',
  ),
  Neighbor(
    name: 'Jane Smith',
    icon: Icons.person,
    date: 'Floor 3, Door 7',
    initial: 'JS',
  ),
  Neighbor(
    name: 'Jane Smith',
    icon: Icons.person,
    date: 'Floor 3, Door 7',
    initial: 'JS',
  ),
  Neighbor(
    name: 'Jane Smith',
    icon: Icons.person,
    date: 'Floor 3, Door 7',
    initial: 'JS',
  ),
  Neighbor(
    name: 'Jane Smith',
    icon: Icons.person,
    date: 'Floor 3, Door 7',
    initial: 'JS',
  ),

  // Add more neighbors as needed
];
