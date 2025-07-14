import 'dart:html' as html;
import 'dart:ui_web' as ui_web;
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

class ProjectsSection extends StatefulWidget {
  @override
  _ProjectsSectionState createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection>
    with TickerProviderStateMixin {
  late AnimationController _staggerController;
  late AnimationController _floatingController;

  @override
  void initState() {
    super.initState();
    _staggerController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _floatingController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _staggerController.forward();
    _floatingController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _staggerController.dispose();
    _floatingController.dispose();
    super.dispose();
  }

  final List<Map<String, dynamic>> projects = [
    {
      'title': 'BayForm',
      'subtitle': 'AI-Powered Resume Builder & Career Tool',
      'description':
          'Next.js 14 with TypeScript, real-time editing, and intelligent PDF export',
      'category': 'Featured',
      'featured': true,
      'techStack': ['Next.js', 'TypeScript', 'Tailwind', 'React'],
      'metrics': {
        'users': '500+',
        'satisfaction': '92%',
        'time_saved': '40min',
      },
      'points': [
        'Advanced PDF export using html2canvas and jsPDF with print-optimized styling',
        'Real-time preview with in-line editing capabilities',
        'Local storage management with form validation and progress tracking',
        'QR code integration and skill categorization system',
      ],
      'github': 'https://github.com/c7harry/Resume-Builder',
      'demo': 'https://bayform.netlify.app/',
      'primaryColor': Color(0xFF10B981),
      'secondaryColor': Color(0xFF34D399),
      'icon': Icons.description_outlined,
      'gradient': [Color(0xFF10B981), Color(0xFF059669)],
    },
    {
      'title': 'Cilantro Estimating',
      'subtitle': 'AI Yield Forecasting for Agriculture',
      'description':
          'Flutter + Flask + TensorFlow stack for precision agriculture',
      'category': 'Featured',
      'featured': true,
      'techStack': ['Flutter', 'Flask', 'TensorFlow', 'Computer Vision'],
      'metrics': {
        'accuracy': '94%',
        'farms': '15+',
        'yield_improvement': '23%',
      },
      'points': [
        'Partnership with SupHerb Farms and featured at UC Merced Innovate 2 Grow',
        'Computer vision model for crop yield estimation from photos',
        'Field log tracking with comprehensive analytics dashboard',
        'Real-time AI processing with 94% accuracy in yield predictions',
      ],
      'cilantroDemo': true,
      'primaryColor': Color(0xFF84CC16),
      'secondaryColor': Color(0xFF65A30D),
      'icon': Icons.agriculture_outlined,
      'gradient': [Color(0xFF84CC16), Color(0xFF65A30D)],
    },
    {
      'title': 'TaskPilot',
      'subtitle': 'Chrome Extension - Task Management',
      'description': 'React-based productivity tool built in 15 hours',
      'category': 'Development',
      'featured': false,
      'techStack': ['React', 'Chrome API', 'Framer Motion', 'TailwindCSS'],
      'metrics': {'build_time': '15h', 'features': '12+', 'performance': '99%'},
      'points': [
        'Built with React, Framer Motion, and TailwindCSS as Chrome Extension',
        'Task priorities, due dates, and calendar integration',
        'Chrome Storage API for automatic data persistence',
        'Dark mode support with smooth animations',
      ],
      'github':
          'https://github.com/c7harry/module-2-js-final-project-Harpreet-Dosanjh',
      'demo': 'https://module-2-js-final-project-harpreet.onrender.com',
      'primaryColor': Color(0xFF3B82F6),
      'secondaryColor': Color(0xFF2563EB),
      'icon': Icons.task_outlined,
      'gradient': [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
    },
    {
      'title': 'Minecraft Engine',
      'subtitle': '3D Voxel Engine in C++ & OpenGL',
      'description': 'Real-time 3D graphics with advanced terrain generation',
      'category': 'Graphics',
      'featured': false,
      'techStack': ['C++', 'OpenGL', 'GLSL', '3D Graphics'],
      'metrics': {'fps': '60+', 'blocks': '∞', 'optimization': 'Advanced'},
      'points': [
        'Engineered in C++ using OpenGL and GLSL for real-time 3D graphics',
        'Custom terrain generation with procedural algorithms',
        'Block placement and destruction with physics simulation',
        'Optimized rendering with advanced graphics techniques',
      ],
      'github': 'https://github.com/c7harry/Minecraft-OpenGL',
      'videoDemo': true,
      'primaryColor': Color(0xFFEC4899),
      'secondaryColor': Color(0xFFDB2777),
      'icon': Icons.view_in_ar_outlined,
      'gradient': [Color(0xFFEC4899), Color(0xFFBE185D)],
    },
    {
      'title': 'Portfolio Website',
      'subtitle': 'Flutter with Firebase',
      'description': 'Responsive showcase with CI/CD pipeline',
      'category': 'Development',
      'featured': false,
      'techStack': ['Flutter', 'Firebase', 'GitHub Actions', 'CI/CD'],
      'metrics': {
        'performance': '98%',
        'uptime': '99.9%',
        'responsive': '100%',
      },
      'points': [
        'Flutter web application with Firebase Hosting',
        'GitHub Actions CI/CD pipeline for automated deployment',
        'Responsive design with project showcase and embedded videos',
        'Interactive animations and smooth navigation',
      ],
      'github': 'https://github.com/c7harry/my_portfolio',
      'demo': 'https://portfolio-874c2.web.app/',
      'primaryColor': Color(0xFF8B5CF6),
      'secondaryColor': Color(0xFF7C3AED),
      'icon': Icons.web_outlined,
      'gradient': [Color(0xFF8B5CF6), Color(0xFF6D28D9)],
    },
    {
      'title': 'Bobcat Buzz',
      'subtitle': 'Secure Student Portal',
      'description': 'Flask-based authentication system with role management',
      'category': 'Backend',
      'featured': false,
      'techStack': ['Flask', 'Python', 'SQLite', 'Authentication'],
      'metrics': {'security': 'A+', 'users': '500+', 'uptime': '99.8%'},
      'points': [
        'Secure user authentication with Flask and SQLite',
        'Role-based access control for student resources',
        'Custom form validation and secure routing',
        'HTTPS deployment for enhanced security',
      ],
      'github': 'https://github.com/c7harry/CSE-106-Final-Project',
      'demo': 'https://bobcat-buzz.onrender.com/',
      'primaryColor': Color(0xFFF59E42), // orange
      'secondaryColor': Color(0xFFF97316),
      'icon': Icons.security_outlined,
      'gradient': [Color(0xFFF59E42), Color(0xFFF97316)],
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
                      style: GoogleFonts.inter(
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
                            style: GoogleFonts.inter(
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
                            style: GoogleFonts.inter(
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
                                style: GoogleFonts.inter(fontSize: 16),
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
    final isDark = theme.brightness == Brightness.dark;

    // Separate featured and regular projects
    final featuredProjects =
        projects.where((p) => p['featured'] == true).toList();
    final regularProjects =
        projects.where((p) => p['featured'] != true).toList();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      child: Column(
        children: [
          _buildHeader(isDark),
          const SizedBox(height: 30),

          // Featured Projects Section
          _buildFeaturedSection(featuredProjects, isDark),
          const SizedBox(height: 80),

          // Regular Projects Grid
          _buildRegularProjectsGrid(regularProjects, isDark),
        ],
      ),
    );
  }

  Widget _buildHeader(bool isDark) {
    return Column(
      children: [
        Text(
          "Projects",
          style: GoogleFonts.inter(
            fontSize: 48,
            fontWeight: FontWeight.w700,
            color: isDark ? Colors.white : Colors.black,
            letterSpacing: -1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedSection(
    List<Map<String, dynamic>> featuredProjects,
    bool isDark,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Featured",
          style: GoogleFonts.inter(
            fontSize: 32,
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : Colors.black,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 32),

        // Featured projects in a grid layout like regular projects
        LayoutBuilder(
          builder: (context, constraints) {
            final crossAxisCount =
                constraints.maxWidth > 1200
                    ? 3
                    : constraints.maxWidth > 800
                    ? 2
                    : 1;

            return Wrap(
              spacing: 24,
              runSpacing: 24,
              children:
                  featuredProjects.asMap().entries.map((entry) {
                    final index = entry.key;
                    final project = entry.value;

                    return AnimatedBuilder(
                      animation: _staggerController,
                      builder: (context, child) {
                        final double start = index * 0.1;
                        final double end = (0.6 + (index * 0.1)).clamp(
                          0.0,
                          1.0,
                        );
                        final staggerAnimation = Tween<double>(
                          begin: 0.0,
                          end: 1.0,
                        ).animate(
                          CurvedAnimation(
                            parent: _staggerController,
                            curve: Interval(
                              start,
                              end,
                              curve: Curves.easeOutCubic,
                            ),
                          ),
                        );

                        return Transform.translate(
                          offset: Offset(0, 50 * (1 - staggerAnimation.value)),
                          child: Opacity(
                            opacity: staggerAnimation.value,
                            child: SizedBox(
                              width:
                                  (constraints.maxWidth -
                                      (24 * (crossAxisCount - 1))) /
                                  crossAxisCount,
                              child: _FeaturedProjectCard(
                                project: project,
                                isDark: isDark,
                                launchURL: _launchURL,
                                showVideoDemo: _showVideoDemo,
                                showCilantroDemo: _showCilantroDemo,
                                floatingAnimation: _floatingController,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
            );
          },
        ),
      ],
    );
  }

  Widget _buildRegularProjectsGrid(
    List<Map<String, dynamic>> regularProjects,
    bool isDark,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "More",
          style: GoogleFonts.inter(
            fontSize: 32,
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : Colors.black,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 32),

        // Responsive grid
        LayoutBuilder(
          builder: (context, constraints) {
            final crossAxisCount =
                constraints.maxWidth > 1200
                    ? 3
                    : constraints.maxWidth > 800
                    ? 2
                    : 1;

            return Wrap(
              spacing: 24,
              runSpacing: 24,
              children:
                  regularProjects.asMap().entries.map((entry) {
                    final index = entry.key;
                    final project = entry.value;

                    return AnimatedBuilder(
                      animation: _staggerController,
                      builder: (context, child) {
                        final double start = 0.2 + (index * 0.1);
                        final double end = (0.8 + (index * 0.1)).clamp(
                          0.0,
                          1.0,
                        );
                        final staggerAnimation = Tween<double>(
                          begin: 0.0,
                          end: 1.0,
                        ).animate(
                          CurvedAnimation(
                            parent: _staggerController,
                            curve: Interval(
                              start,
                              end,
                              curve: Curves.easeOutCubic,
                            ),
                          ),
                        );

                        return Transform.translate(
                          offset: Offset(0, 30 * (1 - staggerAnimation.value)),
                          child: Opacity(
                            opacity: staggerAnimation.value,
                            child: SizedBox(
                              width:
                                  (constraints.maxWidth -
                                      (24 * (crossAxisCount - 1))) /
                                  crossAxisCount,
                              child: _RegularProjectCard(
                                project: project,
                                isDark: isDark,
                                launchURL: _launchURL,
                                showVideoDemo: _showVideoDemo,
                                showCilantroDemo: _showCilantroDemo,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
            );
          },
        ),
      ],
    );
  }
}

class _FeaturedProjectCard extends StatefulWidget {
  final Map<String, dynamic> project;
  final bool isDark;
  final void Function(String url) launchURL;
  final void Function(BuildContext context) showVideoDemo;
  final void Function(BuildContext context) showCilantroDemo;
  final AnimationController floatingAnimation;

  const _FeaturedProjectCard({
    required this.project,
    required this.isDark,
    required this.launchURL,
    required this.showVideoDemo,
    required this.showCilantroDemo,
    required this.floatingAnimation,
  });

  @override
  State<_FeaturedProjectCard> createState() => _FeaturedProjectCardState();
}

class _FeaturedProjectCardState extends State<_FeaturedProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final project = widget.project;
    final gradient = project['gradient'] as List<Color>;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedBuilder(
        animation: widget.floatingAnimation,
        builder: (context, child) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            transform:
                Matrix4.identity()
                  ..translate(0.0, _isHovered ? -8.0 : 0.0)
                  ..translate(
                    0.0,
                    math.sin(widget.floatingAnimation.value * 2 * math.pi) * 2,
                  ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: LinearGradient(
                  colors: gradient,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: gradient[0].withOpacity(0.3),
                    blurRadius: _isHovered ? 30 : 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Stack(
                  children: [
                    // Background pattern
                    Positioned.fill(
                      child: CustomPaint(
                        painter: _PatternPainter(
                          color: Colors.white.withOpacity(0.1),
                        ),
                      ),
                    ),

                    // Content
                    Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  project['icon'],
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      project['title'],
                                      style: GoogleFonts.inter(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                        letterSpacing: -0.5,
                                      ),
                                    ),
                                    Text(
                                      project['subtitle'],
                                      style: GoogleFonts.inter(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white.withOpacity(0.9),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          // Content area (no scroll, grows with content)
                          // Description
                          Text(
                            project['description'],
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              color: Colors.white.withOpacity(0.9),
                              height: 1.5,
                            ),
                          ),
                          if (project['points'] != null &&
                              (project['points'] as List).isNotEmpty) ...[
                            const SizedBox(height: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:
                                  (project['points'] as List)
                                      .map<Widget>(
                                        (point) => Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "• ",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                point,
                                                style: GoogleFonts.inter(
                                                  fontSize: 14,
                                                  color: Colors.white
                                                      .withOpacity(0.92),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                      .toList(),
                            ),
                          ],
                          const SizedBox(height: 24),
                          // Tech stack
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children:
                                (project['techStack'] as List<String>).map((
                                  tech,
                                ) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                        color: Colors.white.withOpacity(0.3),
                                      ),
                                    ),
                                    child: Text(
                                      tech,
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  );
                                }).toList(),
                          ),
                          // Metrics and actions
                          Row(
                            children: [
                              // Metrics
                              ...((project['metrics'] as Map<String, String>)
                                  .entries
                                  .take(2)).map((entry) {
                                return Container(
                                  margin: const EdgeInsets.only(right: 16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        entry.value,
                                        style: GoogleFonts.inter(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        entry.key.replaceAll('_', ' '),
                                        style: GoogleFonts.inter(
                                          fontSize: 12,
                                          color: Colors.white.withOpacity(0.7),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                              const Spacer(),
                              // Action buttons
                              Row(
                                children: [
                                  if (project['github'] != null)
                                    _ActionButton(
                                      icon: Icons.code,
                                      onPressed:
                                          () => widget.launchURL(
                                            project['github'],
                                          ),
                                      tooltip: "View Code",
                                    ),
                                  if (project['demo'] != null)
                                    _ActionButton(
                                      icon: Icons.launch,
                                      onPressed:
                                          () =>
                                              widget.launchURL(project['demo']),
                                      tooltip: "Live Demo",
                                    ),
                                  if (project['videoDemo'] == true)
                                    _ActionButton(
                                      icon: Icons.play_circle_fill,
                                      onPressed:
                                          () => widget.showVideoDemo(context),
                                      tooltip: "Video Demo",
                                    ),
                                  if (project['cilantroDemo'] == true)
                                    _ActionButton(
                                      icon: Icons.slideshow,
                                      onPressed:
                                          project['demo'] != null
                                              ? () => widget.launchURL(
                                                project['demo'],
                                              )
                                              : () => widget.showCilantroDemo(
                                                context,
                                              ),
                                      tooltip: "View Project",
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _RegularProjectCard extends StatefulWidget {
  final Map<String, dynamic> project;
  final bool isDark;
  final void Function(String url) launchURL;
  final void Function(BuildContext context) showVideoDemo;
  final void Function(BuildContext context) showCilantroDemo;

  const _RegularProjectCard({
    required this.project,
    required this.isDark,
    required this.launchURL,
    required this.showVideoDemo,
    required this.showCilantroDemo,
  });

  @override
  State<_RegularProjectCard> createState() => _RegularProjectCardState();
}

class _RegularProjectCardState extends State<_RegularProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final project = widget.project;
    final primaryColor = project['primaryColor'] as Color;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        transform: Matrix4.identity()..translate(0.0, _isHovered ? -4.0 : 0.0),
        child: Container(
          decoration: BoxDecoration(
            color: widget.isDark ? Colors.grey[900] : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color:
                  _isHovered
                      ? primaryColor.withOpacity(0.3)
                      : (widget.isDark ? Colors.grey[800]! : Colors.grey[200]!),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color:
                    _isHovered
                        ? primaryColor.withOpacity(0.2)
                        : Colors.black.withOpacity(0.05),
                blurRadius: _isHovered ? 20 : 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.1),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        project['icon'],
                        color: primaryColor,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            project['title'],
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color:
                                  widget.isDark ? Colors.white : Colors.black,
                            ),
                          ),
                          Text(
                            project['subtitle'],
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color:
                                  widget.isDark
                                      ? Colors.white60
                                      : Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Content
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Description
                    Text(
                      project['description'],
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: widget.isDark ? Colors.white70 : Colors.black87,
                        height: 1.4,
                      ),
                    ),
                    if (project['points'] != null &&
                        (project['points'] as List).isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                            (project['points'] as List)
                                .map<Widget>(
                                  (point) => Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "• ",
                                        style: TextStyle(
                                          color: primaryColor,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          point,
                                          style: GoogleFonts.inter(
                                            fontSize: 13,
                                            color:
                                                widget.isDark
                                                    ? Colors.white.withOpacity(
                                                      0.92,
                                                    )
                                                    : Colors.black.withOpacity(
                                                      0.92,
                                                    ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                                .toList(),
                      ),
                    ],
                    const SizedBox(height: 16),
                    // Tech stack
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children:
                          (project['techStack'] as List<String>).take(3).map((
                            tech,
                          ) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                tech,
                                style: GoogleFonts.inter(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  color: primaryColor,
                                ),
                              ),
                            );
                          }).toList(),
                    ),
                    const SizedBox(height: 8),
                    // Actions
                    Row(
                      children: [
                        if (project['github'] != null)
                          _ActionButton(
                            icon: Icons.code,
                            onPressed:
                                () => widget.launchURL(project['github']),
                            tooltip: "Code",
                            compact: true,
                          ),
                        if (project['demo'] != null)
                          _ActionButton(
                            icon: Icons.launch,
                            onPressed: () => widget.launchURL(project['demo']),
                            tooltip: "Demo",
                            compact: true,
                          ),
                        if (project['videoDemo'] == true)
                          _ActionButton(
                            icon: Icons.play_circle_fill,
                            onPressed: () => widget.showVideoDemo(context),
                            tooltip: "Video",
                            compact: true,
                          ),
                        if (project['cilantroDemo'] == true)
                          _ActionButton(
                            icon: Icons.slideshow,
                            onPressed: () => widget.showCilantroDemo(context),
                            tooltip: "View",
                            compact: true,
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final String tooltip;
  final bool compact;

  const _ActionButton({
    required this.icon,
    required this.onPressed,
    required this.tooltip,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(compact ? 8 : 12),
            child: Container(
              padding: EdgeInsets.all(compact ? 8 : 12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(compact ? 8 : 12),
                border: Border.all(color: Colors.white.withOpacity(0.2)),
              ),
              child: Icon(icon, color: Colors.white, size: compact ? 16 : 18),
            ),
          ),
        ),
      ),
    );
  }
}

class _PatternPainter extends CustomPainter {
  final Color color;

  _PatternPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..strokeWidth = 1.0
          ..style = PaintingStyle.stroke;

    // Draw a subtle grid pattern
    const spacing = 30.0;

    // Vertical lines
    for (double x = 0; x <= size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    // Horizontal lines
    for (double y = 0; y <= size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }

    // Draw some decorative circles
    final circlePaint =
        Paint()
          ..color = color
          ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(size.width * 0.8, size.height * 0.2),
      3,
      circlePaint,
    );

    canvas.drawCircle(
      Offset(size.width * 0.9, size.height * 0.7),
      2,
      circlePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
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
              style: GoogleFonts.inter(
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
