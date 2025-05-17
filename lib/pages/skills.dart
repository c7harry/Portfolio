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
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      child: Column(
        children: [
          Text("Skills",
              style: GoogleFonts.poppins(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              )).animate().fadeIn().slideY(begin: 0.3),
          const SizedBox(height: 30),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: skills.map((skill) => Animate(
              effects: [FadeEffect(), ScaleEffect(begin: Offset(0.9, 0.9))],
              child: Chip(
                label: Text(skill, style: GoogleFonts.poppins()),
                backgroundColor: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                shape: StadiumBorder(),
                labelStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
              ),
            )).toList(),
          )
        ],
      ),
    );
  }
}