import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ContactSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(32),
      child: Column(
        children: [
          Text("Contact Me",
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )).animate().fadeIn().slideY(begin: 0.2),
          SizedBox(height: 10),
          Text("Email: your.email@example.com", style: GoogleFonts.poppins(color: Colors.white70)),
          Text("LinkedIn: linkedin.com/in/yourprofile", style: GoogleFonts.poppins(color: Colors.white70)),
          Text("GitHub: github.com/yourusername", style: GoogleFonts.poppins(color: Colors.white70)),
        ],
      ),
    );
  }
}