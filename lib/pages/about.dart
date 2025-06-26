import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AboutSection extends StatefulWidget {
  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleColor = theme.textTheme.headlineSmall?.color ?? Colors.black;

    return Container(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "About Me",
              style: GoogleFonts.poppins(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: titleColor,
              ),
            ).animate().fadeIn().slideY(begin: 0.2),
            const SizedBox(height: 10),
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Container(
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).brightness == Brightness.dark
                            ? Colors.grey[900]
                            : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color:
                            Theme.of(context).brightness == Brightness.dark
                                ? Colors.black.withOpacity(0.18)
                                : Colors.grey.withOpacity(0.12),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 24,
                    horizontal: 28,
                  ),
                  child: Column(
                    children: [
                      _AboutBullet(
                        icon: Icons.school,
                        iconColor: Colors.blue[400],
                        text:
                            "Computer Engineering graduate from UC Merced focused on software systems, machine learning, and full-stack development.",
                      ),
                      _AboutBullet(
                        icon: Icons.devices,
                        iconColor: Colors.purple[400],
                        text:
                            "Built and deployed cross-platform apps using Flutter, React, Flask, Firebase, and TensorFlow.",
                      ),
                      _AboutBullet(
                        icon: Icons.show_chart,
                        iconColor: Colors.green[400],
                        text:
                            "Experienced in financial strategy, with a background in professional algorithmic trading and technical analysis.",
                      ),
                      _AboutBullet(
                        icon: Icons.agriculture,
                        iconColor: Colors.teal[400],
                        text:
                            "Developed a real-world ML app for agriculture, improving decisions with image-based predictions.",
                      ),
                      _AboutBullet(
                        icon: Icons.extension,
                        iconColor: Colors.orange[400],
                        text:
                            "Passionate about building products at the intersection of data, design, and performance.",
                      ),
                      _AboutBullet(
                        icon: Icons.rocket_launch,
                        iconColor: Colors.redAccent[200],
                        text:
                            "Continuously learning and contributing to open-source, with a focus on clean architecture and scalability.",
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AboutBullet extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color? iconColor;

  const _AboutBullet({required this.icon, required this.text, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: iconColor ?? Theme.of(context).primaryColor,
            size: 22,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(fontSize: 15, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}
