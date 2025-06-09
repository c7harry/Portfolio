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

    return Container(
      color: theme.scaffoldBackgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 0,
            ), // Remove extra padding
            child: LayoutBuilder(
              builder: (context, constraints) {
                return ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 700,
                  ), // Increase maxWidth if possible
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      // Remove mainAxisAlignment to left-align
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
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

          const SizedBox(height: 30),

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
                icon: const Icon(Icons.open_in_new),
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

          const SizedBox(height: 20),

          Text(
            "Contact Info",
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: titleColor,
            ),
          ).animate().fadeIn().slideY(begin: 0.2),

          const SizedBox(height: 10),
          Text(
            "Feel free to reach out for collaborations, opportunities, or just a chat!",
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: textColor.withOpacity(0.8),
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.2),
          Container(
            margin: const EdgeInsets.only(top: 24),
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            decoration: BoxDecoration(
              color:
                  theme.brightness == Brightness.dark
                      ? Colors.white10
                      : Colors.grey[50],
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: theme.dividerColor.withOpacity(0.18),
                width: 1.2,
              ),
            ),
            child: Column(
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
                    Flexible(
                      child: Text(
                        "hdosanjh209@gmail.com",
                        style: GoogleFonts.robotoMono(
                          color: textColor.withOpacity(1.0),
                        ),
                        overflow: TextOverflow.ellipsis,
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
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const HoverIcon(
                        assetPath: 'assets/logos/linkedin.png',
                        width: 36,
                        height: 36,
                      ),
                      const SizedBox(width: 6),
                      Flexible(
                        child: HoverLinkText(
                          text: "linkedin.com/in/harpreet-dosanjh209",
                          color: theme.colorScheme.primary,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
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
              ],
            ),
          ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.4),
        ],
      ),
    );
  }
}

class HoverLinkText extends StatefulWidget {
  final String text;
  final Color color;
  final double fontSize;

  const HoverLinkText({
    required this.text,
    required this.color,
    this.fontSize = 15,
  });

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
          fontSize: widget.fontSize,
          decoration:
              _isHovering ? TextDecoration.underline : TextDecoration.none,
        ),
        softWrap: true,
        overflow: TextOverflow.visible,
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
