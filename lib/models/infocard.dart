import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class infoCard extends StatelessWidget {
  VoidCallback onpress;
  String name;
  IconData icon;
  String Date;
  late var Prof_icon;
  String intial;

  infoCard({
    this.icon = Icons.person,
    required this.name,
    required this.Date,
    required this.onpress,
    required this.intial,


  });
  @override
  Widget build(BuildContext context) {
    if (this.name == "") {
      Prof_icon = Icon(Icons.person);
    } else {
      Prof_icon = Text(
        '$intial',
        style: GoogleFonts.poppins(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
      );
    }

    return GestureDetector(
      onTap:onpress,
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(bottom: 5),
        height: 100,
        decoration: BoxDecoration(
            color: Colors.white10, borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  child: Prof_icon,
                  // backgroundColor: Color(0xffC95149),
                  backgroundColor: Colors.white,
                ),
                SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${this.name}',
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      '${this.Date}',
                      style: GoogleFonts.poppins(
                          fontSize: 15, fontWeight: FontWeight.w300),
                    )
                  ],
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 15,
            )
          ],
        ),
      ),
    );
  }
}
