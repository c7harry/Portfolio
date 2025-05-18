import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark
        ? const Color.fromARGB(255, 9, 10, 9)
        : Colors.white;
    final textColor = isDark ? Colors.white : const Color.fromARGB(255, 9, 10, 9);
    final subtitleColor = isDark ? Colors.cyanAccent : Colors.teal;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 24),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [backgroundColor, backgroundColor],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Hi, I'm Harpreet",
            style: GoogleFonts.poppins(
              fontSize: 42,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          )
              .animate()
              .fadeIn(duration: 800.ms)
              .slideY(begin: -0.2)
              .scale(delay: 300.ms),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}