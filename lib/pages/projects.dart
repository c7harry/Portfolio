import 'dart:html' as html;
import 'dart:ui_web' as ui_web;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

class ProjectsSection extends StatelessWidget {
  final List<Map<String, dynamic>> projects = [
    {
      'title': 'Portfolio',
      'subtitle': '🎯 Interactive Showcase + Hosting',
      'points': [
        'Designed and built with Flutter to demonstrate UI, animation, and state management expertise.',
        'Deployed using Firebase Hosting and automated with GitHub Actions CI/CD pipeline.',
        'Features responsive layout, project modals, and embedded media for a dynamic user experience.',
        'Includes self-hosted project demos, source code, and resume for recruiter-friendly navigation.',
      ],
      'github': 'https://github.com/c7harry/my_portfolio',
      'demo': 'https://portfolio-874c2.web.app/',
    },
    {
      'title': 'Bobcat Buzz',
      'subtitle': '🔐 Secure User Portal + Hosting',
      'points': [
        'Developed a user authentication system with hashed passwords and session tracking using Flask and SQLite.',
        'Implemented custom form validation, secure routing, and basic RBAC logic.',
        'Responsive UI and portal structure designed for student access to protected content.',
        'Deployed to Render with HTTPS and minimal latency for real-world usability testing.',
      ],
      'github': 'https://github.com/c7harry/CSE-106-Final-Project',
      'demo': 'https://bobcat-buzz.onrender.com/',
    },
    {
      'title': 'CraftMail',
      'subtitle': '📬 Responsive Email UI – Bay Valley Tech Challenge',
      'points': [
        'Designed and built a Gmail-inspired email client using HTML, CSS, and Bootstrap in under 24 hours.',
        'Implemented message filtering by user and folder tabs (Primary, Promotions, Social) with dynamic interactivity.',
        'Integrated a responsive layout with mobile-first design, smooth transitions, and accessible navigation.',
        'Included features such as composing messages, inbox interactivity, and animations to enhance UX.',
      ],
      'github': 'https://github.com/c7harry/bootstrap-email-dosanjh',
      'demo': 'https://bootstrap-email-dosanjh.onrender.com',
    },
    {
      'title': 'Minecraft',
      'subtitle': '🧱 3D Voxel Engine in C++',
      'points': [
        'Engineered a Minecraft-inspired voxel renderer using OpenGL and GLSL for real-time 3D graphics.',
        'Built custom terrain generation logic with dynamic chunk management.',
        'Implemented block selection, placement, and destruction with efficient memory handling.',
        'Optimized performance through shader manipulation and depth buffering techniques.',
      ],
      'github': 'https://github.com/c7harry/Minecraft-OpenGL',
      'videoDemo': true,
    },
    {
      'title': 'Cilantro Estimating',
      'subtitle': '🌿 AI-Powered Yield Forecasting App',
      'points': [
        'Led development of a computer vision web app using TensorFlow and Keras for crop yield estimation.',
        'Integrated image-based inference with a Flutter frontend and Flask API backend.',
        'Enabled field log tracking and harvesting insights through intuitive UI and analytics dashboard.',
        'Designed under NDA in collaboration with SupHerb Farms; featured at UC Merced’s Innovate 2 Grow.',
      ],
      'cilantroDemo': true,
    },
  ];

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await canLaunchUrl(uri)) throw 'Could not launch $url';
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  void _showVideoDemo(BuildContext context) {
  final List<Map<String, String>> videoItems = [
    {'title': 'Moving Clouds & Tree Leafs', 'videoPath': 'assets/videos/treecloud.mp4'},
    {'title': 'Environment & Lighting', 'videoPath': 'assets/videos/lighting.mp4'},
    {'title': 'Terrain Generation', 'videoPath': 'assets/videos/terrain.mp4'},
    {'title': 'Block Selection', 'videoPath': 'assets/videos/block_selection.mp4'},
    {'title': 'Block Placement & Destruction', 'videoPath': 'assets/videos/place_destroy.mp4'},
  ];

  showDialog(
    context: context,
    builder: (context) => Dialog(
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
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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

  ui_web.platformViewRegistry.registerViewFactory(
    videoViewerId,
    (int viewId) {
      final iframe = html.IFrameElement()
        ..src = 'https://www.youtube.com/embed/I8aS6tBc-qo'
        ..style.border = 'none'
        ..style.width = '100%'
        ..style.height = '100%'
        ..style.display = 'block';

      return iframe;
    },
  );

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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
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
                                    duration: const Duration(milliseconds: 300),
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
                                    duration: const Duration(milliseconds: 300),
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
            children: projects.map((project) {
              return MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {},
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                    width: 320,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: borderColor),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 12,
                          offset: const Offset(4, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          project['title'] ?? '',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: titleColor,
                          ),
                        ),
                        if (project['subtitle'] != null)
                          Text(
                            project['subtitle'],
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: textColor.withOpacity(0.8),
                            ),
                          ),
                        const SizedBox(height: 12),
                        if (project['points'] != null)
                          ...List<Widget>.from(
                            (project['points'] as List).map(
                              (point) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 2.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("• ",
                                        style: TextStyle(fontSize: 16)),
                                    Expanded(
                                      child: Text(
                                        point,
                                        style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          color: textColor.withOpacity(0.8),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            if (project['github'] != null)
                              TextButton.icon(
                                onPressed: () =>
                                    _launchURL(project['github']),
                                icon: const Icon(Icons.code, size: 18),
                                label: const Text("GitHub"),
                              ),
                            if (project['demo'] != null)
                              TextButton.icon(
                                onPressed: () =>
                                    _launchURL(project['demo']),
                                icon: const Icon(Icons.launch, size: 18),
                                label: const Text("Live Demo"),
                              ),
                            if (project['videoDemo'] == true)
                              TextButton.icon(
                                onPressed: () => _showVideoDemo(context),
                                icon: const Icon(Icons.play_circle_fill,
                                    size: 18),
                                label: const Text("Video Demo"),
                              ),
                            if (project['cilantroDemo'] == true)
                              TextButton.icon(
                                onPressed: () => _showCilantroDemo(context),
                                icon: const Icon(Icons.slideshow, size: 18),
                                label: const Text("View Project Content"),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.4),
                ),
              );
            }).toList(),
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

class _VideoDemoItemState extends State<_VideoDemoItem> with AutomaticKeepAliveClientMixin {
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
  bool get wantKeepAlive => true; // Keeps widget alive during scroll

  @override
Widget build(BuildContext context) {
  super.build(context); // Needed when using AutomaticKeepAliveClientMixin

  final isMobile = MediaQuery.of(context).size.width < 600;
  final double maxWidth = isMobile
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
          child: _controller.value.isInitialized
              ? VideoPlayer(_controller)
              : const Center(child: CircularProgressIndicator()),
        ),
      ],
    ),
  );
}
}