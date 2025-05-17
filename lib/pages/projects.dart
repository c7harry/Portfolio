import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class ProjectsSection extends StatelessWidget {
  final List<Map<String, String>> projects = [
    {
      'title': 'Portfolio Website',
      'description': 'A responsive portfolio built with Flutter and deployed on web.',
    },
    {
      'title': 'Task Manager App',
      'description': 'Cross-platform todo app with API and offline sync.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: projects.asMap().entries.map((entry) {
        int i = entry.key;
        var project = entry.value;

        return Card(
          color: Colors.grey[900],
          margin: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          child: ListTile(
            title: Text(project['title']!, style: GoogleFonts.poppins(color: Colors.white)),
            subtitle: Text(project['description']!, style: GoogleFonts.poppins(color: Colors.white70)),
          ),
        ).animate().fadeIn(delay: (i * 300).ms).slideX(begin: 0.3);
      }).toList(),
    );
  }
}