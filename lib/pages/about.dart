import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutSection extends StatefulWidget {
  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> {
  final String resumeUrl = 'https://drive.google.com/file/d/1aR8lixMPw33Jjw5VeMzwcV2WVZh5e7Mq/view?usp=sharing';
  final List<String> titles = ['Software Engineer', 'Full Stack Developer', 'Cyber Security Engineer', 'Flutter Engineer'];

  String displayedText = '';
  int currentTitleIndex = 0;
  int charIndex = 0;
  bool isDeleting = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    _startTyping();
  }

  void _startTyping() {
    timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        final currentText = titles[currentTitleIndex];
        if (!isDeleting) {
          if (charIndex < currentText.length) {
            displayedText = currentText.substring(0, ++charIndex);
          } else {
            Future.delayed(const Duration(milliseconds: 1000), () {
              isDeleting = true;
            });
          }
        } else {
          if (charIndex > 0) {
            displayedText = currentText.substring(0, --charIndex);
          } else {
            isDeleting = false;
            currentTitleIndex = (currentTitleIndex + 1) % titles.length;
          }
        }
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void _launchURL() async {
    if (!await launchUrl(Uri.parse(resumeUrl), mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $resumeUrl';
    }
  }

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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "I am a ",
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
              ),
              Text(
                displayedText,
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: theme.colorScheme.primary,
                ),
              ),
              Text(
                "_",
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: theme.colorScheme.primary,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Container(
            width: 900,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: borderColor),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Who am I?",
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 20),
                ...[
                  '🎓 Computer Engineering graduate from UC Merced with strong foundations in software development and systems engineering.',
                  '👨‍💻 Full-stack engineer experienced with Flutter, React, Firebase, Flask, and SQLite.',
                  '📈 Financial analyst background with MyForexFunds and Funding Pips, specializing in technical analysis and disciplined risk management.',
                  '🤖 Built ML-powered applications using TensorFlow and Keras, including a predictive agriculture tool deployed with Flutter for SupHerb Farms.',
                  '🚀 Proficient in Git, JS, CI/CD, C++, and cross-platform mobile/web development.',
                  '🧠 Passionate about solving complex, real-world problems by combining data, design, and engineering best practices.',
                ].asMap().entries.map((entry) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("• ", style: TextStyle(fontSize: 18)),
                      Expanded(
                        child: Text(
                          entry.value,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            height: 1.8,
                            letterSpacing: 0.4,
                            color: textColor.withOpacity(0.9),
                          ),
                        ).animate().fadeIn(delay: (entry.key * 100).ms),
                      ),
                    ],
                  ),
                )),
              ],
            )
                .animate()
                .fadeIn()
                .scaleXY(begin: 0.9)
                .slideY(begin: 0.2),
          ),

          const SizedBox(height: 40),

          ElevatedButton.icon(
            onPressed: _launchURL,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: theme.colorScheme.onPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 10,
              shadowColor: theme.brightness == Brightness.dark
                  ? Colors.white.withOpacity(0.2)
                  : Colors.black.withOpacity(0.3),
            ),
            icon: const Icon(Icons.picture_as_pdf),
            label: const Text("View Resume", style: TextStyle(fontSize: 16)),
          )
              .animate()
              .fadeIn(delay: 200.ms)
              .slideY(begin: 0.3)
              .then()
              .shakeY(delay: 400.ms, duration: 800.ms),

          const SizedBox(height: 40),

          Text(
            "Contact Info",
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: titleColor,
            ),
          ).animate().fadeIn().slideY(begin: 0.2),

          const SizedBox(height: 16),

          Column(
            children: [
              Text(
                "📧 hdosanjh209@gmail.com",
                style: GoogleFonts.robotoMono(color: textColor.withOpacity(1.0)),
              ),
              Text(
                "🔗 linkedin.com/in/harpreet-dosanjh209",
                style: GoogleFonts.robotoMono(color: textColor.withOpacity(1.0)),
              ),
              Text(
                "🐙 github.com/c7harry",
                style: GoogleFonts.robotoMono(color: textColor.withOpacity(1.0)),
              ),
            ],
          )
              .animate()
              .fadeIn(delay: 200.ms)
              .slideY(begin: 0.4),
        ],
      ),
    );
  }
}