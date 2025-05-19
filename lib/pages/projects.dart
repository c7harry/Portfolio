import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

class ProjectsSection extends StatelessWidget {
  final List<Map<String, dynamic>> projects = [
    {
      'title': 'Portfolio Website',
      'subtitle': 'Flutter Web App + Firebase Hosting',
      'points': [
        'Built using Flutter for a fast, cross-platform UI.',
        'Deployed with Firebase Hosting and integrated CI/CD.',
        'Features dynamic animations and custom UI design.',
        'Responsive layout for all screen sizes and devices.',
        'Automated GitHub Actions pipeline for instant deploys on push.',
        'Uses Dart, Flutter Animate, and custom component libraries.',
      ],
      'github': 'https://github.com/c7harry/my_portfolio',
      'demo': 'https://portfolio-874c2.web.app/',
    },
    {
      'title': 'Bobcat Buzz',
      'subtitle': 'Secure User Portal',
      'points': [
        'Secure login, registration, and session management.',
        'Built with Flask backend and SQLite database.',
        'Form validation and password hashing.',
        'Implements key cybersecurity techniques.',
      ],
      'github': 'https://github.com/c7harry/CSE-106-Final-Project',
      'demo': 'https://bobcat-buzz.onrender.com/',
    },
    {
      'title': 'Minecraft',
      'subtitle': 'C++ Game Engine using OpenGL and GLSL',
      'points': [
        'Built a 3D voxel world engine in C++ inspired by Minecraft.',
        'Used OpenGL for graphics rendering and GLSL for custom shaders.',
        'Implemented modular shader programs for vertex, fragment, and geometry stages.',
        'Managed GPU resources manually using buffer objects and shader uniforms.',
        'Applied object-oriented programming and real-time rendering techniques.',
      ],
      'github': 'https://github.com/c7harry/Minecraft-OpenGL',
      'demo': '',
      'videoDemo': true,
    },
  ];

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await canLaunchUrl(uri)) throw 'Could not launch $url';
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  void _showVideoDemo(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      insetPadding: const EdgeInsets.all(16),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.9,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Minecraft OpenGL – Demo',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              _VideoDemoItem(
                title: 'Moving Clouds & Tree Leafs',
                videoPath: 'assets/videos/treecloud.mp4',
              ),
              _VideoDemoItem(
                title: 'Environment & Lighting',
                videoPath: 'assets/videos/lighting.mp4',
              ),
              _VideoDemoItem(
                title: 'Terrain Generation',
                videoPath: 'assets/videos/terrain.mp4',
              ),
              _VideoDemoItem(
                title: 'Block Selection',
                videoPath: 'assets/videos/block_selection.mp4',
              ),
              _VideoDemoItem(
                title: 'Block Placement & Destruction',
                videoPath: 'assets/videos/place_destroy.mp4',
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ],
          ),
        ),
      ),
    ),
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
            style: GoogleFonts.poppins(fontSize: 36, fontWeight: FontWeight.bold, color: titleColor),
          ).animate().fadeIn().slideY(begin: 0.2),
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
                          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600, color: titleColor),
                        ),
                        if (project['subtitle'] != null)
                          Text(
                            project['subtitle'],
                            style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: textColor.withOpacity(0.8)),
                          ),
                        const SizedBox(height: 12),
                        if (project['points'] != null)
                          ...List<Widget>.from((project['points'] as List).map((point) => Padding(
                                padding: const EdgeInsets.symmetric(vertical: 2.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("• ", style: TextStyle(fontSize: 16)),
                                    Expanded(
                                      child: Text(point, style: GoogleFonts.poppins(fontSize: 15, color: textColor.withOpacity(0.8))),
                                    ),
                                  ],
                                ),
                              ))),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            if (project['github'] != null && project['github'].toString().isNotEmpty)
                              TextButton.icon(
                                onPressed: () => _launchURL(project['github']),
                                icon: const Icon(Icons.code, size: 18),
                                label: const Text("GitHub"),
                              ),
                            if (project['demo'] != null && project['demo'].toString().isNotEmpty)
                              TextButton.icon(
                                onPressed: () => _launchURL(project['demo']),
                                icon: const Icon(Icons.launch, size: 18),
                                label: const Text("Live Demo"),
                              ),
                            if (project['videoDemo'] == true)
                              TextButton.icon(
                                onPressed: () => _showVideoDemo(context),
                                icon: const Icon(Icons.play_circle_fill, size: 18),
                                label: const Text("Video Demo"),
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

class _VideoDemoItemState extends State<_VideoDemoItem> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoPath)
      ..initialize().then((_) {
        setState(() {});
        _controller.setLooping(true);
        _controller.setVolume(0.0);
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          widget.title,
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        if (_controller.value.isInitialized)
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: 600,
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
              ),
            ),
          ),
        const SizedBox(height: 24),
      ],
    );
  }
}