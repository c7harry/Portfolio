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
                '🎓 Computer Engineering graduate from UC Merced with a focus on software systems, machine learning, and full-stack development.',
                '🛠️ Built and deployed cross-platform applications using Flutter, React, Flask, Firebase, and TensorFlow.',
                '📊 Experienced in financial strategy, having traded professionally using algorithmic systems and technical analysis.',
                '🌱 Developed a real-world ML app for agriculture that improves decision-making with image-based predictions.',
                '🧩 Passionate about building products at the intersection of data, design, and performance.',
                '🚀 Continuously learning and contributing to open-source, with a strong emphasis on clean architecture and scalability.',
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
                    style: GoogleFonts.robotoMono(color: textColor.withOpacity(1.0)),
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
                        const SnackBar(content: Text('Email copied to clipboard!')),
                      );
                    },
                  ),
                ],
              ),

              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () async {
                    final url = Uri.parse('https://www.linkedin.com/in/harpreet-dosanjh209');
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url, mode: LaunchMode.externalApplication);
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
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () async {
                    final url = Uri.parse('https://github.com/c7harry');
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url, mode: LaunchMode.externalApplication);
                    }
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (child, animation) => FadeTransition(
                          opacity: animation,
                          child: child,
                        ),
                        child: HoverIcon(
                          key: ValueKey(theme.brightness), // key triggers rebuild
                          assetPath: theme.brightness == Brightness.dark
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
          )
              .animate()
              .fadeIn(delay: 200.ms)
              .slideY(begin: 0.4),
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