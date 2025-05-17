import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AboutSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 9, 10, 9),
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      child: Column(
        children: [
          Text("Hi, I am Harpreet.",
              style: GoogleFonts.poppins(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )).animate().fadeIn().slideY(begin: 0.2),
          const SizedBox(height: 20),
          Center(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white24),
              ),
              width: 600,
              child: Text(
                "I'm a developer passionate about creating beautiful, high-performance web and mobile applications using modern technologies like Flutter, React, and Firebase.",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(fontSize: 18, color: Colors.white70),
              )
                  .animate()
                  .fadeIn()
                  .scaleXY(begin: 0.9, duration: Duration(milliseconds: 600))
                  .slideY(begin: 0.2),
            ),
          ),
          const SizedBox(height: 60),
          Text("Contact Info",
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )).animate().fadeIn().slideY(begin: 0.2),
          const SizedBox(height: 20),
          Column(
            children: [
              Text("📧 hdosanjh209@gmail.com", style: GoogleFonts.robotoMono(color: Colors.white70)),
              Text("🔗 linkedin.com/in/harpreet-dosanjh209", style: GoogleFonts.robotoMono(color: Colors.white70)),
              Text("🐙 github.com/c7harry", style: GoogleFonts.robotoMono(color: Colors.white70)),
            ],
          )
              .animate()
              .fadeIn(delay: Duration(milliseconds: 200))
              .slideY(begin: 0.4),
        ],
      ),
    );
  }
}