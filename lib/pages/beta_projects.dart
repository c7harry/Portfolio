import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class BetaProjectsSection extends StatelessWidget {
  final List<Map<String, dynamic>> betaProjects = [
    {
      'title': 'BetaApp',
      'subtitle': '🧪 Experimental Mobile App',
      'points': [
        'Built with Flutter and Firebase.',
        'Features real-time collaboration and AI-powered suggestions.',
        'Currently in closed beta for select users.',
        'Feedback is highly appreciated to improve the product.',
      ],
      'github': 'https://github.com/yourusername/betaapp',
      'demo': 'https://betaapp-demo.web.app/',
      'accentColor': Color(0xFFffe082),
      'accentIcon': Icons.science_outlined,
    },
  ];

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await canLaunchUrl(uri)) throw 'Could not launch $url';
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.science, color: Colors.amber[800], size: 36),
              const SizedBox(width: 12),
              Text(
                "Beta Lab",
                style: GoogleFonts.poppins(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber[900],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            "These projects are experimental and may change or break at any time. Your feedback is welcome!",
            style: GoogleFonts.poppins(fontSize: 16, color: Colors.amber[900]),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children:
                betaProjects
                    .map(
                      (project) => _BetaProjectCard(
                        project: project,
                        textColor: textColor,
                        titleColor: titleColor,
                        cardColor: cardColor,
                        borderColor: borderColor,
                        launchURL: _launchURL,
                      ),
                    )
                    .toList(),
          ),
        ],
      ),
    );
  }
}

class _BetaProjectCard extends StatefulWidget {
  final Map<String, dynamic> project;
  final Color textColor;
  final Color titleColor;
  final Color cardColor;
  final Color borderColor;
  final void Function(String url) launchURL;

  const _BetaProjectCard({
    required this.project,
    required this.textColor,
    required this.titleColor,
    required this.cardColor,
    required this.borderColor,
    required this.launchURL,
    Key? key,
  }) : super(key: key);

  @override
  State<_BetaProjectCard> createState() => _BetaProjectCardState();
}

class _BetaProjectCardState extends State<_BetaProjectCard> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    final project = widget.project;
    final points = (project['points'] as List?) ?? [];
    final showExpand = points.length > 1;
    final visiblePoints = expanded ? points : points.take(1);

    final accentColor =
        project['accentColor'] as Color? ??
        Theme.of(context).colorScheme.secondary.withOpacity(0.15);
    final accentIcon = project['accentIcon'] as IconData? ?? Icons.science;

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final headerTextColor = isDark ? Colors.black : Colors.black;
    final subtitleTextColor =
        isDark
            ? Colors.amber[900]!.withOpacity(0.85)
            : widget.textColor.withOpacity(0.7);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      width: 320,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: widget.cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: widget.borderColor),
        boxShadow: [
          BoxShadow(
            color: accentColor.withOpacity(0.25),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Accent header
          Container(
            decoration: BoxDecoration(
              color: accentColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(18),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: isDark ? Colors.grey[900] : Colors.white,
                  child: Icon(accentIcon, color: Colors.amber[800]),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    project['title'] ?? '',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: headerTextColor,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.amber[800],
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    "BETA",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (project['subtitle'] != null)
            Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
                left: 20,
                right: 20,
                bottom: 8.0,
              ),
              child: Text(
                project['subtitle'],
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: subtitleTextColor,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          if (points.isNotEmpty) ...[
            Divider(height: 18, color: widget.borderColor),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  ...visiblePoints.map(
                    (point) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("• ", style: TextStyle(fontSize: 15)),
                          Expanded(
                            child: Text(
                              point,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: widget.textColor.withOpacity(0.85),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (showExpand)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(0, 0),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () => setState(() => expanded = !expanded),
                        child: Text(
                          expanded ? "Show less" : "Show more",
                          style: GoogleFonts.poppins(fontSize: 13),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
          Divider(height: 18, color: widget.borderColor),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: Row(
              children: [
                if (project['github'] != null)
                  IconButton(
                    tooltip: "GitHub",
                    icon: const Icon(Icons.code, size: 18),
                    onPressed: () => widget.launchURL(project['github']),
                  ),
                if (project['demo'] != null)
                  IconButton(
                    tooltip: "Live Demo",
                    icon: const Icon(Icons.launch, size: 18),
                    onPressed: () => widget.launchURL(project['demo']),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
