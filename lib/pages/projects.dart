import 'dart:html' as html;
import 'dart:ui_web' as ui_web;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

class ProjectsSection extends StatelessWidget {
  final List<Map<String, dynamic>> projects = [
    {
      'title': 'TaskPilot',
      'subtitle': '🚀 Chrome Extension - Bay Valley Tech Challenge',
      'points': [
        'Built with React, Framer Motion, and TailwindCSS as a Chrome Extension in 15-hours.',
        'Helps users organize and track tasks for work and personal life, making daily planning easier.',
        'Supports task priorities, due dates, calendar integration, and dark mode.',
        'Uses Chrome Storage API for saving your data automatically.',
      ],
      'github':
          'https://github.com/c7harry/module-2-js-final-project-Harpreet-Dosanjh',
      'demo': 'https://module-2-js-final-project-harpreet.onrender.com',
      'accentColor': Color(0xFFe3f2fd),
      'accentIcon': Icons.check_circle_outline,
    },
    {
      'title': 'Portfolio',
      'subtitle': '🎯 Interactive Developer Showcase',
      'points': [
        'Created using Flutter, deployed with Firebase Hosting and GitHub Actions.',
        'A personal website that highlights my projects, skills, and resume for recruiters and collaborators.',
        'Features a responsive layout, project popups, and embedded videos.',
        'Includes links to live demos and source code for easy navigation.',
      ],
      'github': 'https://github.com/c7harry/my_portfolio',
      'demo': 'https://portfolio-874c2.web.app/',
      'accentColor': Color(0xFFf3e5f5),
      'accentIcon': Icons.person_outline,
    },
    {
      'title': 'Bobcat Buzz',
      'subtitle': '🔐 Student Portal',
      'points': [
        'Developed with Flask (Python) and SQLite for secure user authentication.',
        'Provides a safe online space for students to access protected content and resources.',
        'Includes custom form validation, secure routing, and role-based access.',
        'Deployed with HTTPS for privacy and reliability.',
      ],
      'github': 'https://github.com/c7harry/CSE-106-Final-Project',
      'demo': 'https://bobcat-buzz.onrender.com/',
      'accentColor': Color(0xFFe8f5e9),
      'accentIcon': Icons.lock_outline,
    },
    {
      'title': 'CraftMail',
      'subtitle': '📬 Responsive Email Client - Bay Valley Tech Challenge',
      'points': [
        'Built using HTML, CSS, and Bootstrap in 15-hours.',
        'Lets users read, filter, and organize emails in a familiar, Gmail-like interface.',
        'Supports message filtering, folder tabs, and composing new messages.',
        'Designed for mobile and desktop with smooth transitions and accessible navigation.',
      ],
      'github': 'https://github.com/c7harry/bootstrap-email-dosanjh',
      'demo': 'https://bootstrap-email-dosanjh.onrender.com',
      'accentColor': Color(0xFFfff3e0),
      'accentIcon': Icons.email_outlined,
    },
    {
      'title': 'Minecraft',
      'subtitle': '🧱 3D Voxel Engine',
      'points': [
        'Engineered in C++ using OpenGL and GLSL for real-time 3D graphics.',
        'A sandbox game engine that lets users build and explore blocky worlds, inspired by Minecraft.',
        'Features custom terrain generation, block placement, and destruction.',
        'Optimized for smooth performance with advanced graphics techniques.',
      ],
      'github': 'https://github.com/c7harry/Minecraft-OpenGL',
      'videoDemo': true,
      'accentColor': Color(0xFFede7f6),
      'accentIcon': Icons.videogame_asset_outlined,
    },
    {
      'title': 'Cilantro Estimating',
      'subtitle': '🌿 AI Yield Forecasting',
      'points': [
        'Web app built with Flutter (frontend), Flask (backend), and TensorFlow/Keras for AI.',
        'Helps farmers estimate crop yields from photos, making harvest planning more accurate and efficient.',
        'Includes field log tracking and an analytics dashboard for insights.',
        'Developed in partnership with SupHerb Farms and featured at UC Merced’s Innovate 2 Grow.',
      ],
      'cilantroDemo': true,
      'accentColor': Color(0xFFf1f8e9),
      'accentIcon': Icons.agriculture_outlined,
    },
  ];

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await canLaunchUrl(uri)) throw 'Could not launch $url';
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  void _showVideoDemo(BuildContext context) {
    final List<Map<String, String>> videoItems = [
      {
        'title': 'Moving Clouds & Tree Leafs',
        'videoPath': 'assets/videos/treecloud.mp4',
      },
      {
        'title': 'Environment & Lighting',
        'videoPath': 'assets/videos/lighting.mp4',
      },
      {'title': 'Terrain Generation', 'videoPath': 'assets/videos/terrain.mp4'},
      {
        'title': 'Block Selection',
        'videoPath': 'assets/videos/block_selection.mp4',
      },
      {
        'title': 'Block Placement & Destruction',
        'videoPath': 'assets/videos/place_destroy.mp4',
      },
    ];

    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            insetPadding: const EdgeInsets.all(16),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.9,
                maxWidth: MediaQuery.of(context).size.width * 0.95,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: Text(
                      'Minecraft OpenGL – Demo',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      itemCount: videoItems.length,
                      itemBuilder: (context, index) {
                        final item = videoItems[index];
                        return _VideoDemoItem(
                          title: item['title']!,
                          videoPath: item['videoPath']!,
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Close'),
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  void _showCilantroDemo(BuildContext context) {
    const videoViewerId = 'cilantroYoutube';

    ui_web.platformViewRegistry.registerViewFactory(videoViewerId, (
      int viewId,
    ) {
      final iframe =
          html.IFrameElement()
            ..src = 'https://www.youtube.com/embed/I8aS6tBc-qo'
            ..style.border = 'none'
            ..style.width = '100%'
            ..style.height = '100%'
            ..style.display = 'block';

      return iframe;
    });

    showDialog(
      context: context,
      builder: (context) {
        final screenWidth = MediaQuery.of(context).size.width;
        final bool isMobile = screenWidth < 600;
        final double slideHeight = isMobile ? screenWidth * 0.75 : 540;

        return Dialog(
          insetPadding: const EdgeInsets.all(16),
          child: StatefulBuilder(
            builder: (context, setState) {
              final pageController = PageController();
              int currentIndex = 0;

              return StatefulBuilder(
                builder: (context, setState) {
                  return ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.95,
                    ),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          Text(
                            'App Demo',
                            style: GoogleFonts.poppins(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            width: double.infinity,
                            constraints: BoxConstraints(
                              maxWidth: 720,
                              maxHeight: isMobile ? screenWidth * 9 / 16 : 405,
                            ),
                            child: AspectRatio(
                              aspectRatio: 16 / 9,
                              child: HtmlElementView(viewType: videoViewerId),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'Slide Deck Presentation',
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 1),
                          SizedBox(
                            width: double.infinity,
                            height: slideHeight,
                            child: PageView.builder(
                              controller: pageController,
                              itemCount: 11,
                              onPageChanged: (index) {
                                setState(() => currentIndex = index);
                              },
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                  ),
                                  child: Image.asset(
                                    'assets/cilantro/cilantro_slide_${index + 1}.jpg',
                                    fit: BoxFit.contain,
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 1),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.chevron_left),
                                onPressed: () {
                                  if (currentIndex > 0) {
                                    currentIndex--;
                                    pageController.animateToPage(
                                      currentIndex,
                                      duration: const Duration(
                                        milliseconds: 300,
                                      ),
                                      curve: Curves.easeInOut,
                                    );
                                    setState(() {});
                                  }
                                },
                              ),
                              Text(
                                '${currentIndex + 1}/11',
                                style: GoogleFonts.poppins(fontSize: 16),
                              ),
                              IconButton(
                                icon: const Icon(Icons.chevron_right),
                                onPressed: () {
                                  if (currentIndex < 10) {
                                    currentIndex++;
                                    pageController.animateToPage(
                                      currentIndex,
                                      duration: const Duration(
                                        milliseconds: 300,
                                      ),
                                      curve: Curves.easeInOut,
                                    );
                                    setState(() {});
                                  }
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Close'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
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
          Text(
            "Projects",
            style: GoogleFonts.poppins(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: titleColor,
            ),
          ),
          const SizedBox(height: 40),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children:
                projects
                    .map(
                      (project) => _ProjectCard(
                        project: project,
                        textColor: textColor,
                        titleColor: titleColor,
                        cardColor: cardColor,
                        borderColor: borderColor,
                        launchURL: _launchURL,
                        showVideoDemo: _showVideoDemo,
                        showCilantroDemo: _showCilantroDemo,
                      ),
                    )
                    .toList(),
          ),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final Map<String, dynamic> project;
  final Color textColor;
  final Color titleColor;
  final Color cardColor;
  final Color borderColor;
  final void Function(String url) launchURL;
  final void Function(BuildContext context) showVideoDemo;
  final void Function(BuildContext context) showCilantroDemo;

  const _ProjectCard({
    required this.project,
    required this.textColor,
    required this.titleColor,
    required this.cardColor,
    required this.borderColor,
    required this.launchURL,
    required this.showVideoDemo,
    required this.showCilantroDemo,
    Key? key,
  }) : super(key: key);

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
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
    final accentIcon = project['accentIcon'] as IconData? ?? Icons.apps;

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final headerTextColor = isDark ? Colors.black : Colors.black;
    final subtitleTextColor =
        isDark
            ? Colors.white.withOpacity(0.85)
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
                  child: Icon(
                    accentIcon,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    project['title'] ?? '',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: headerTextColor,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(isDark ? 0.08 : 0.12),
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                      ],
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
                if (project['videoDemo'] == true)
                  IconButton(
                    tooltip: "Video Demo",
                    icon: const Icon(Icons.play_circle_fill, size: 18),
                    onPressed: () => widget.showVideoDemo(context),
                  ),
                if (project['cilantroDemo'] == true)
                  IconButton(
                    tooltip: "View Project Content",
                    icon: const Icon(Icons.slideshow, size: 18),
                    onPressed: () => widget.showCilantroDemo(context),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _VideoDemoItem extends StatefulWidget {
  final String title;
  final String videoPath;

  const _VideoDemoItem({required this.title, required this.videoPath});

  @override
  State<_VideoDemoItem> createState() => _VideoDemoItemState();
}

class _VideoDemoItemState extends State<_VideoDemoItem>
    with AutomaticKeepAliveClientMixin {
  late final VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoPath)
      ..initialize().then((_) {
        if (mounted) {
          setState(() {});
          _controller.setLooping(true);
          _controller.setVolume(0.0);
          _controller.play();
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final isMobile = MediaQuery.of(context).size.width < 600;
    final double maxWidth =
        isMobile
            ? MediaQuery.of(context).size.width * 0.9
            : MediaQuery.of(context).size.width * 0.6;

    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              widget.title,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: maxWidth,
            height: maxWidth * 9 / 16,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.black,
            ),
            clipBehavior: Clip.antiAlias,
            child:
                _controller.value.isInitialized
                    ? VideoPlayer(_controller)
                    : const Center(child: CircularProgressIndicator()),
          ),
        ],
      ),
    );
  }
}
