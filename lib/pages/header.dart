import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 24),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color.fromARGB(255, 9, 10, 9), const Color.fromARGB(255, 9, 10, 9)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Hi, I'm Harpreet Dosanjh",
            style: GoogleFonts.poppins(
              fontSize: 42,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          )
              .animate()
              .fadeIn(duration: 800.ms)
              .slideY(begin: -0.2)
              .scale(delay: 300.ms),
          const SizedBox(height: 20),
          Animate(
            effects: [FadeEffect(duration: 800.ms), SlideEffect(begin: Offset(0, 0.3))],
            child: Text(
              "Frontend Developer | Flutter Enthusiast",
              style: GoogleFonts.robotoMono(fontSize: 20, color: Colors.cyanAccent),
            ),
          ),
        ],
      ),
    );
  }
}