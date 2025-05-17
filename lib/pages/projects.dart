import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class ProjectsSection extends StatelessWidget {
  final List<Map<String, String>> projects = [
    {
      'title': 'Portfolio Website',
      'description': 'A responsive portfolio built with Flutter and deployed on the web.',
    },
    {
      'title': 'Task Manager App',
      'description': 'Cross-platform app with API integration, offline mode, and notifications.',
    },
    {
      'title': 'Blog CMS',
      'description': 'Markdown blog platform using Firebase and Tailwind.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade900,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Projects",
              style: GoogleFonts.poppins(
                  fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white))
              .animate()
              .fadeIn()
              .slideY(begin: 0.2),
          const SizedBox(height: 30),
          Column(
            children: projects.asMap().entries.map((entry) {
              int i = entry.key;
              var project = entry.value;

              return Card(
                elevation: 8,
                color: Colors.white.withOpacity(0.05),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                margin: const EdgeInsets.symmetric(vertical: 12),
                child: ListTile(
                  title: Text(project['title']!, style: GoogleFonts.poppins(color: Colors.white)),
                  subtitle: Text(project['description']!, style: GoogleFonts.poppins(color: Colors.white70)),
                ),
              ).animate().fadeIn(delay: (i * 200).ms).slideX(begin: 0.2);
            }).toList(),
          ),
        ],
      ),
    );
  }
}