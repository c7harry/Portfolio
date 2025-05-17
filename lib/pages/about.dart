import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AboutSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyLarge?.color ?? Colors.black;
    final titleColor = theme.textTheme.headlineSmall?.color ?? Colors.black;
    final cardColor = theme.cardColor.withOpacity(0.05);
    final borderColor = theme.dividerColor.withOpacity(0.4);

    return Container(
      color: theme.scaffoldBackgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      child: Column(
        children: [
          Text(
            "Hi, I am Harpreet.",
            style: GoogleFonts.poppins(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: titleColor,
            ),
          ).animate().fadeIn().slideY(begin: 0.2),

          const SizedBox(height: 20),

          Center(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: borderColor),
              ),
              width: 600,
              child: Text(
                "I'm a developer passionate about creating beautiful, high-performance web and mobile applications using modern technologies like Flutter, React, and Firebase.",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  color: textColor.withOpacity(0.85),
                ),
              )
                  .animate()
                  .fadeIn()
                  .scaleXY(begin: 0.9, duration: Duration(milliseconds: 600))
                  .slideY(begin: 0.2),
            ),
          ),

          const SizedBox(height: 60),

          Text(
            "Contact Info",
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: titleColor,
            ),
          ).animate().fadeIn().slideY(begin: 0.2),

          const SizedBox(height: 20),

          Column(
            children: [
              Text(
                "📧 hdosanjh209@gmail.com",
                style: GoogleFonts.robotoMono(color: textColor.withOpacity(0.75)),
              ),
              Text(
                "🔗 linkedin.com/in/harpreet-dosanjh209",
                style: GoogleFonts.robotoMono(color: textColor.withOpacity(0.75)),
              ),
              Text(
                "🐙 github.com/c7harry",
                style: GoogleFonts.robotoMono(color: textColor.withOpacity(0.75)),
              ),
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