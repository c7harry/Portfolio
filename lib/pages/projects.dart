import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectsSection extends StatelessWidget {
  final List<Map<String, String>> projects = [
    {
      'title': 'Portfolio Website',
      'description': 'A responsive portfolio built with Flutter and deployed on the web.',
      'github': 'https://github.com/c7harry/portfolio',
      'demo': 'https://harpreet.dev'
    },
    {
      'title': 'Bobcat Buzz (Secure User Portal)',
      'description': 'A secure full-stack web app featuring user login, registration, and session management. Built using Flask for the backend and SQLite for data persistence. This project highlights backend development, frontend integration, form validation, secure password hashing, and key cybersecurity practices including input sanitization and session control.',
      'github': 'https://github.com/c7harry/CSE-106-Final-Project',
      'demo': 'https://bobcat-buzz.onrender.com/'
    },
    {
      'title': 'Blog CMS',
      'description': 'Markdown blog platform using Firebase and Tailwind.',
      'github': 'https://github.com/c7harry/blog-cms',
      'demo': ''
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyLarge?.color ?? Colors.black;
    final titleColor = theme.textTheme.headlineSmall?.color ?? Colors.black;
    final cardColor = theme.cardColor.withOpacity(0.05);
    final borderColor = theme.dividerColor.withOpacity(0.1);

    return Container(
      color: theme.scaffoldBackgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      child: Column(
        children: [
          Text(
            "Projects",
            style: GoogleFonts.poppins(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: titleColor,
            ),
          ).animate().fadeIn().slideY(begin: 0.2),
          const SizedBox(height: 40),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children: projects.map((project) {
              return MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {},
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                    width: 320,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: borderColor),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 12,
                          offset: const Offset(4, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          project['title'] ?? '',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: titleColor,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          project['description'] ?? '',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: textColor.withOpacity(0.8),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            if (project['github'] != null && project['github']!.isNotEmpty)
                              TextButton.icon(
                                onPressed: () => _launchURL(project['github']!),
                                icon: const Icon(Icons.code, size: 18),
                                label: const Text("GitHub"),
                              ),
                            if (project['demo'] != null && project['demo']!.isNotEmpty)
                              TextButton.icon(
                                onPressed: () => _launchURL(project['demo']!),
                                icon: const Icon(Icons.launch, size: 18),
                                label: const Text("Live Demo"),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.4),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await canLaunchUrl(uri)) {
      throw 'Could not launch $url';
    }
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}