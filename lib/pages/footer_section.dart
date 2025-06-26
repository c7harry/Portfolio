import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

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

class FooterSection extends StatelessWidget {
  final Map<String, VoidCallback>? navigationCallbacks;

  const FooterSection({super.key, this.navigationCallbacks});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyLarge?.color ?? Colors.black;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 24 : 32,
        horizontal: isMobile ? 24 : 48,
      ),
      child: Column(
        children: [
          // Contact Section
          Container(
            constraints: BoxConstraints(maxWidth: isMobile ? 400 : 600),
            padding: EdgeInsets.symmetric(
              vertical: isMobile ? 32 : 40,
              horizontal: isMobile ? 20 : 32,
            ),
            decoration: BoxDecoration(
              color:
                  theme.brightness == Brightness.dark
                      ? Colors.white.withOpacity(0.05)
                      : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: theme.dividerColor.withOpacity(0.1),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color:
                      theme.brightness == Brightness.dark
                          ? Colors.black.withOpacity(0.3)
                          : Colors.grey.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Let's Connect",
                  style: GoogleFonts.poppins(
                    fontSize: isMobile ? 24 : 28,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ).animate().fadeIn().slideY(begin: 0.2),

                const SizedBox(height: 12),

                Text(
                  "Feel free to reach out for collaborations, opportunities, or just a chat!",
                  style: GoogleFonts.poppins(
                    fontSize: isMobile ? 14 : 16,
                    color: textColor.withOpacity(0.8),
                  ),
                  textAlign: TextAlign.center,
                ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.2),

                const SizedBox(height: 32),

                // Email Section
                _ContactItem(
                  icon: 'assets/logos/gmail.png',
                  text: 'hdosanjh209@gmail.com',
                  onTap: () async {
                    final emailUri = Uri(
                      scheme: 'mailto',
                      path: 'hdosanjh209@gmail.com',
                    );
                    await launchUrl(emailUri);
                  },
                  onCopy: () {
                    Clipboard.setData(
                      const ClipboardData(text: 'hdosanjh209@gmail.com'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Email copied to clipboard!'),
                        backgroundColor: theme.colorScheme.primary,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    );
                  },
                  isMobile: isMobile,
                ),

                const SizedBox(height: 20),

                // LinkedIn Section
                _ContactItem(
                  icon: 'assets/logos/linkedin.png',
                  text: 'linkedin.com/in/harpreet-dosanjh209',
                  onTap: () async {
                    await launchUrl(
                      Uri.parse("https://linkedin.com/in/harpreet-dosanjh209"),
                      mode: LaunchMode.externalApplication,
                    );
                  },
                  isMobile: isMobile,
                ),

                const SizedBox(height: 20),

                // GitHub Section
                _ContactItem(
                  icon:
                      theme.brightness == Brightness.dark
                          ? 'assets/logos/github-inverted.png'
                          : 'assets/logos/github.png',
                  text: 'github.com/c7harry',
                  onTap: () async {
                    await launchUrl(
                      Uri.parse("https://github.com/c7harry"),
                      mode: LaunchMode.externalApplication,
                    );
                  },
                  isMobile: isMobile,
                  iconWidth: 32,
                  iconHeight: 32,
                ),
              ],
            ),
          ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.4),

          const SizedBox(height: 40),

          // Quick Links
          if (!isMobile) ...[
            Text(
              "Quick Links",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ).animate().fadeIn(delay: 300.ms),

            const SizedBox(height: 16),

            Wrap(
              spacing: 32,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: [
                _FooterLink(
                  text: "About",
                  onTap: navigationCallbacks?['about'] ?? () {},
                ),
                _FooterLink(
                  text: "Skills",
                  onTap: navigationCallbacks?['skills'] ?? () {},
                ),
                _FooterLink(
                  text: "Projects",
                  onTap: navigationCallbacks?['projects'] ?? () {},
                ),
                _FooterLink(
                  text: "Certificates",
                  onTap: navigationCallbacks?['certificates'] ?? () {},
                ),
                _FooterLink(
                  text: "Contact",
                  onTap: navigationCallbacks?['contact'] ?? () {},
                ),
              ],
            ).animate().fadeIn(delay: 400.ms),

            const SizedBox(height: 40),
          ],

          // Divider
          Container(
            height: 1,
            margin: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  theme.dividerColor.withOpacity(0.5),
                  Colors.transparent,
                ],
              ),
            ),
          ).animate().fadeIn(delay: 500.ms),

          // Bottom Section
          Column(
            children: [
              Text(
                "Built with Flutter",
                style: GoogleFonts.poppins(
                  fontSize: isMobile ? 12 : 14,
                  color: textColor.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "© ${DateTime.now().year} Harpreet Dosanjh. All rights reserved.",
                style: GoogleFonts.poppins(
                  fontSize: isMobile ? 10 : 12,
                  color: textColor.withOpacity(0.5),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ).animate().fadeIn(delay: 600.ms),
        ],
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  final String icon;
  final String text;
  final VoidCallback onTap;
  final VoidCallback? onCopy;
  final bool isMobile;
  final double iconWidth;
  final double iconHeight;

  const _ContactItem({
    required this.icon,
    required this.text,
    required this.onTap,
    this.onCopy,
    this.isMobile = false,
    this.iconWidth = 28,
    this.iconHeight = 28,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color:
              theme.brightness == Brightness.dark
                  ? Colors.white.withOpacity(0.05)
                  : Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: theme.dividerColor.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            HoverIcon(assetPath: icon, width: iconWidth, height: iconHeight),
            const SizedBox(width: 12),
            Flexible(
              child: Text(
                text,
                style: GoogleFonts.robotoMono(
                  color: theme.colorScheme.primary,
                  fontSize: isMobile ? 12 : 14,
                  decoration: TextDecoration.underline,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (onCopy != null) ...[
              const SizedBox(width: 8),
              IconButton(
                tooltip: "Copy",
                icon: const Icon(Icons.copy, size: 16),
                color: theme.colorScheme.primary.withOpacity(0.7),
                onPressed: onCopy,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _FooterLink extends StatefulWidget {
  final String text;
  final VoidCallback onTap;

  const _FooterLink({required this.text, required this.onTap});

  @override
  State<_FooterLink> createState() => _FooterLinkState();
}

class _FooterLinkState extends State<_FooterLink> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
            color:
                _isHovering
                    ? theme.colorScheme.primary.withOpacity(0.1)
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            widget.text,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color:
                  _isHovering
                      ? theme.colorScheme.primary
                      : theme.textTheme.bodyLarge?.color?.withOpacity(0.8),
              fontWeight: _isHovering ? FontWeight.w500 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
