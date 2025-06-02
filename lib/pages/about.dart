import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

class AboutSection extends StatefulWidget {
  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class HoverIcon extends StatefulWidget {
  final String assetPath;
  final double width;
  final double height;

  const HoverIcon({
    super.key,
    required this.assetPath,
    this.width = 24,
    this.height = 24,
  });

  @override
  State<HoverIcon> createState() => _HoverIconState();
}

class _HoverIconState extends State<HoverIcon> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedScale(
        scale: _hovering ? 1.15 : 1.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        child: Image.asset(
          widget.assetPath,
          width: widget.width,
          height: widget.height,
        ),
      ),
    );
  }
}

class _AboutSectionState extends State<AboutSection> {
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

          SizedBox(
            width: 600,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Headline
                Text(
                  "About Me",
                  style: GoogleFonts.poppins(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 18),
                Column(
                  children: [
                    _AboutBullet(
                      icon: Icons.school,
                      text:
                          "Computer Engineering graduate from UC Merced focused on software systems, machine learning, and full-stack development.",
                    ),
                    _AboutBullet(
                      icon: Icons.devices,
                      text:
                          "Built and deployed cross-platform apps using Flutter, React, Flask, Firebase, and TensorFlow.",
                    ),
                    _AboutBullet(
                      icon: Icons.show_chart,
                      text:
                          "Experienced in financial strategy, with a background in professional algorithmic trading and technical analysis.",
                    ),
                    _AboutBullet(
                      icon: Icons.agriculture,
                      text:
                          "Developed a real-world ML app for agriculture, improving decisions with image-based predictions.",
                    ),
                    _AboutBullet(
                      icon: Icons.extension,
                      text:
                          "Passionate about building products at the intersection of data, design, and performance.",
                    ),
                    _AboutBullet(
                      icon: Icons.rocket_launch,
                      text:
                          "Continuously learning and contributing to open-source, with a focus on clean architecture and scalability.",
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),

          ElevatedButton.icon(
                onPressed: _launchURL,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 14,
                  ),
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: theme.colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 10,
                  shadowColor:
                      theme.brightness == Brightness.dark
                          ? Colors.white.withOpacity(0.2)
                          : Colors.black.withOpacity(0.3),
                ),
                icon: const Icon(Icons.picture_as_pdf),
                label: const Text(
                  "View Resume",
                  style: TextStyle(fontSize: 16),
                ),
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

          const SizedBox(height: 20),

          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const HoverIcon(
                    assetPath: 'assets/logos/gmail.png',
                    width: 40,
                    height: 35,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "hdosanjh209@gmail.com",
                    style: GoogleFonts.robotoMono(
                      color: textColor.withOpacity(1.0),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    tooltip: "Copy Email",
                    icon: const Icon(Icons.copy, size: 18),
                    color: theme.colorScheme.primary,
                    onPressed: () {
                      Clipboard.setData(
                        const ClipboardData(text: 'hdosanjh209@gmail.com'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Email copied to clipboard!'),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () async {
                    final url = Uri.parse(
                      'https://www.linkedin.com/in/harpreet-dosanjh209',
                    );
                    if (await canLaunchUrl(url)) {
                      await launchUrl(
                        url,
                        mode: LaunchMode.externalApplication,
                      );
                    }
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const HoverIcon(
                        assetPath: 'assets/logos/linkedin.png',
                        width: 60,
                        height: 60,
                      ),
                      const SizedBox(width: 8),
                      HoverLinkText(
                        text: "linkedin.com/in/harpreet-dosanjh209",
                        color: theme.colorScheme.primary,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () async {
                    final url = Uri.parse('https://github.com/c7harry');
                    if (await canLaunchUrl(url)) {
                      await launchUrl(
                        url,
                        mode: LaunchMode.externalApplication,
                      );
                    }
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder:
                            (child, animation) => FadeTransition(
                              opacity: animation,
                              child: child,
                            ),
                        child: HoverIcon(
                          key: ValueKey(theme.brightness),
                          assetPath:
                              theme.brightness == Brightness.dark
                                  ? 'assets/logos/github-inverted.png'
                                  : 'assets/logos/github.png',
                          width: 50,
                          height: 50,
                        ),
                      ),
                      const SizedBox(width: 8),
                      HoverLinkText(
                        text: "github.com/c7harry",
                        color: theme.colorScheme.primary,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.4),
        ],
      ),
    );
  }
}

class HoverLinkText extends StatefulWidget {
  final String text;
  final Color color;

  const HoverLinkText({required this.text, required this.color});

  @override
  _HoverLinkTextState createState() => _HoverLinkTextState();
}

class _HoverLinkTextState extends State<HoverLinkText> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: Text(
        widget.text,
        style: GoogleFonts.robotoMono(
          color: widget.color,
          decoration:
              _isHovering ? TextDecoration.underline : TextDecoration.none,
        ),
      ),
    );
  }
}

class _AboutBullet extends StatelessWidget {
  final IconData icon;
  final String text;

  const _AboutBullet({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: theme.primaryColor, size: 22),
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
