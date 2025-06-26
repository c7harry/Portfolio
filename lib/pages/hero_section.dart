import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback? onContactPressed;

  const HeroSection({super.key, this.onContactPressed});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  final String resumeUrl =
      'https://drive.google.com/file/d/1aR8lixMPw33Jjw5VeMzwcV2WVZh5e7Mq/view?usp=sharing';

  final List<String> titles = [
    'Software Engineer',
    'Full Stack Developer',
    'Cyber Security Engineer',
    'Flutter Engineer',
  ];

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
    if (!await launchUrl(
      Uri.parse(resumeUrl),
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $resumeUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyLarge?.color ?? Colors.black;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 24 : 48,
          vertical: isMobile ? 30 : 40,
        ),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.start, // Changed from center to start
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Add a small SizedBox for minimal top spacing
            const SizedBox(height: 8),
            // Animated Profile Picture
            Container(
                  width: isMobile ? 120 : 150,
                  height: isMobile ? 120 : 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: theme.colorScheme.primary.withOpacity(0.3),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: isMobile ? 60 : 75,
                    backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                    child: Icon(
                      Icons.person,
                      size: isMobile ? 60 : 75,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                )
                .animate()
                .scale(delay: 200.ms, duration: 800.ms)
                .fadeIn(duration: 600.ms),

            const SizedBox(height: 24),

            // Name
            Text(
                  "Harpreet Dosanjh",
                  style: GoogleFonts.poppins(
                    fontSize: isMobile ? 32 : 48,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                  textAlign: TextAlign.center,
                )
                .animate()
                .fadeIn(delay: 400.ms)
                .slideY(begin: 0.3, duration: 600.ms),

            const SizedBox(height: 12),

            // Animated Typing Effect
            Container(
                  height: isMobile ? 40 : 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "I am a ",
                        style: GoogleFonts.poppins(
                          fontSize: isMobile ? 18 : 24,
                          fontWeight: FontWeight.w500,
                          color: textColor,
                        ),
                      ),
                      Text(
                        displayedText,
                        style: GoogleFonts.poppins(
                          fontSize: isMobile ? 18 : 24,
                          fontWeight: FontWeight.w500,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      Text(
                        "_",
                        style: GoogleFonts.poppins(
                          fontSize: isMobile ? 18 : 24,
                          fontWeight: FontWeight.w500,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                )
                .animate()
                .fadeIn(delay: 600.ms)
                .slideY(begin: 0.2, duration: 600.ms),

            const SizedBox(height: 18),

            // Description
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: isMobile ? 350 : 600),
              child: Text(
                "Passionate about creating innovative solutions that bridge technology and real-world impact. I specialize in full-stack development and building scalable applications.",
                style: GoogleFonts.poppins(
                  fontSize: isMobile ? 14 : 18,
                  color: textColor.withOpacity(0.8),
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),
            ).animate().fadeIn(delay: 800.ms).slideY(begin: 0.2, duration: 600.ms),

            const SizedBox(height: 30),

            // Action Buttons
            Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  alignment: WrapAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _launchURL,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 20 : 32,
                          vertical: isMobile ? 12 : 16,
                        ),
                        backgroundColor: theme.colorScheme.primary,
                        foregroundColor: theme.colorScheme.onPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 8,
                        shadowColor: theme.colorScheme.primary.withOpacity(0.4),
                      ),
                      icon: const Icon(Icons.description),
                      label: Text(
                        "View Resume",
                        style: TextStyle(
                          fontSize: isMobile ? 14 : 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    OutlinedButton.icon(
                      onPressed:
                          widget.onContactPressed ??
                          () {
                            // Default scroll behavior if no callback provided
                          },
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 20 : 32,
                          vertical: isMobile ? 12 : 16,
                        ),
                        side: BorderSide(
                          color: theme.colorScheme.primary,
                          width: 2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      icon: Icon(Icons.email, color: theme.colorScheme.primary),
                      label: Text(
                        "Contact Me",
                        style: TextStyle(
                          fontSize: isMobile ? 14 : 16,
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                )
                .animate()
                .fadeIn(delay: 1000.ms)
                .slideY(begin: 0.3, duration: 600.ms),

            const SizedBox(height: 60),
            // Scroll down indicator
            Column(
                  children: [
                    Text(
                      "Scroll to explore",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: textColor.withOpacity(0.6),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: textColor.withOpacity(0.6),
                      size: 24,
                    ),
                  ],
                )
                .animate(onPlay: (controller) => controller.repeat())
                .fadeIn(delay: 1200.ms)
                .then()
                .moveY(begin: 0, end: 10, duration: 1500.ms)
                .then()
                .moveY(begin: 10, end: 0, duration: 1500.ms),
          ],
        ),
      ),
    );
  }
}
