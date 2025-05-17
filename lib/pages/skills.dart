import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SkillsSection extends StatelessWidget {
  final List<String> skills = [
    'Flutter',
    'Dart',
    'React',
    'JavaScript',
    'Firebase',
    'Git & GitHub',
    'Responsive Design',
    'REST APIs',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      color: theme.scaffoldBackgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      child: Column(
        children: [
          Text(
            "Skills",
            style: GoogleFonts.poppins(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: theme.textTheme.titleLarge?.color, // dynamic
            ),
          ).animate().fadeIn().slideY(begin: 0.3),
          const SizedBox(height: 30),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: skills.map((skill) {
              return Animate(
                effects: [FadeEffect(), ScaleEffect(begin: Offset(0.9, 0.9))],
                child: Chip(
                  label: Text(
                    skill,
                    style: GoogleFonts.poppins(
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  backgroundColor: isDark
                      ? Colors.white.withOpacity(0.1)
                      : Colors.black.withOpacity(0.05),
                  shape: const StadiumBorder(),
                  side: BorderSide(
                    color: isDark ? Colors.white24 : Colors.black26,
                  ),
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}