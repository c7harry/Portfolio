import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class BetaProjectsSection extends StatelessWidget {
  final List<Map<String, dynamic>> betaProjects = [
    {
      'title': 'Bayclock',
      'subtitle': '⏰ Modern Timesheet & Work Hours Web App for Bay Valley Tech',
      'points': [
        'Full-stack time tracking platform built with React and JSX, featuring Supabase backend with SQL database, user authentication, and role-based access control (admin/user roles).',
        'Weekly timesheet grid with project-based time entry, duration calculations, and real-time totals with visual progress indicators.',
        'Dashboard with analytics charts, achievements system, project breakdowns, and activity tracking using Chart.js and Framer Motion.',
        'Admin panel with user management, workspace administration, entry oversight, and detailed analytics with export capabilities.',
        'Calendar view with project filtering, weekly/monthly views, and color-coded project visualization.',
        'Material-UI design with dark/light theme support, and smooth animations throughout.',
      ],
      'github': 'https://github.com/c7harry/BayClock',
      'demo': 'https://bayclock.netlify.app/',
      'accentColor': Color(0xFF80cbc4),
      'accentIcon': Icons.access_time_outlined,
      'todo': [
        'Add approval workflows and automated notifications',
        'Integrate with Google Calendar and third-party APIs',
        'Add mobile UI with native features',
        'Implement comprehensive audit trail system',
        'Add data recovery options for deleted records (soft deletes)',
        'Enable timesheet editing functionality',
      ],
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
  @override
  Widget build(BuildContext context) {
    final project = widget.project;
    final points = (project['points'] as List?) ?? [];

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

    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final cardWidth = isMobile ? screenWidth - 32 : 960.0;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      width: cardWidth,
      constraints: BoxConstraints(
        minHeight: 0,
        maxHeight: isMobile ? double.infinity : 900,
      ),
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
      child: SingleChildScrollView(
        padding: EdgeInsets.zero,
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
            Divider(height: 18, color: widget.borderColor),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 0, 18, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Features
                  Text(
                    "Features",
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.amber[900],
                    ),
                  ),
                  const SizedBox(height: 4),
                  ...points.map(
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
                  // To Do (always below features)
                  if (project['todo'] != null &&
                      (project['todo'] as List).isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 18.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.amber[50],
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.amber[300]!,
                            width: 1.2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.amber.withOpacity(0.08),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 14,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.rocket_launch,
                                  color: Colors.amber,
                                  size: 20,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  "To Do",
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.amber[900],
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.amber[200],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    "Coming Soon!",
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.amber[900],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            ...((project['todo'] as List).map(
                              (todo) => Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 3.0,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "– ",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.amber,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        todo,
                                        style: GoogleFonts.poppins(
                                          fontSize: 13,
                                          color: Colors.amber[900],
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
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
      ),
    );
  }
}
