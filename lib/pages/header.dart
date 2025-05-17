import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      child: Column(
        children: [
          Text(
            "Hi, I'm Harpreet Dosanjh",
            style: GoogleFonts.poppins(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ).animate().fadeIn(duration: 800.ms).slideY(begin: -0.2),
          SizedBox(height: 16),
          Text(
            "Software Engineer",
            style: GoogleFonts.poppins(
              fontSize: 20,
              color: Colors.white70,
            ),
          ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.2),
        ],
      ),
    );
  }
}