import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class SkillsSection extends StatelessWidget {
  final List<Map<String, dynamic>> languages = [
    {'name': 'JavaScript', 'asset': 'assets/images/javascript.png'},
    {'name': 'Python', 'asset': 'assets/images/python.png'},
    {'name': 'C++', 'asset': 'assets/images/cpp.png'},
    {'name': 'Dart', 'asset': 'assets/images/dart.png'},
    {'name': 'HTML', 'asset': 'assets/images/html.png'},
    {'name': 'CSS', 'asset': 'assets/images/css.png'},
    {'name': 'C', 'asset': 'assets/logos/c.png'},
  ];

  final List<Map<String, dynamic>> technologies = [
    {'name': 'React', 'asset': 'assets/images/react.png'},
    {'name': 'Flutter', 'asset': 'assets/images/flutter.png'},
    {'name': 'Firebase', 'asset': 'assets/images/firebase.png'},
    {'name': 'Git', 'asset': 'assets/images/git.png'},
    {'name': 'TensorFlow', 'asset': 'assets/images/tensorflow.png'},
    {'name': 'Keras', 'asset': 'assets/images/keras.png'},
    {'name': 'Flask', 'asset': 'assets/images/flask.png'},
    {'name': 'OpenGL', 'asset': 'assets/images/openGL.png'},
    {'name': 'Framer Motion', 'asset': 'assets/logos/framer_motion.png'},
    {'name': 'TailwindCSS', 'asset': 'assets/logos/tailwindcss.png'},
    {'name': 'SQLite', 'asset': 'assets/logos/sqlite.png'},
    {'name': 'GitHub Actions', 'asset': 'assets/logos/github_actions.png'},
    {'name': 'Chrome Extensions', 'asset': 'assets/logos/chrome.png'},
  ];

  final List<Map<String, dynamic>> tools = [
    {'name': 'AWS', 'asset': 'assets/images/aws.png'},
    {'name': 'Android Studio', 'asset': 'assets/images/android_studio.png'},
    {'name': 'Google Colab', 'asset': 'assets/images/colab.png'},
    {'name': 'TradingView', 'asset': 'assets/images/tradingview.png'},
    {'name': 'CI/CD', 'asset': 'assets/logos/cicd.png'},
    {'name': 'Google Cloud', 'asset': 'assets/logos/google_cloud.png'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Widget buildIconGrid(List<Map<String, dynamic>> items) {
      return Wrap(
        spacing: 24,
        runSpacing: 24,
        alignment: WrapAlignment.center,
        children:
            items.map((item) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(40),
                    child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: isDark ? Colors.white12 : Colors.grey[100],
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color:
                                    isDark
                                        ? Colors.white.withOpacity(0.25)
                                        : Colors.black.withOpacity(0.4),
                                spreadRadius: isDark ? 2 : 4,
                                blurRadius: isDark ? 8 : 16,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Image.asset(
                            item['asset'],
                            width: 40,
                            height: 40,
                          ),
                        )
                        .animate(onPlay: (controller) => controller.repeat())
                        .scaleXY(
                          begin: 1.0,
                          end: 1.1,
                          duration: 800.ms,
                          curve: Curves.easeInOut,
                        )
                        .then()
                        .scaleXY(
                          begin: 1.1,
                          end: 1.0,
                          duration: 800.ms,
                          curve: Curves.easeInOut,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item['name'],
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                ],
              );
            }).toList(),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Skills',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 40),
          // Languages
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6366F1).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFF6366F1).withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.code,
                            color: const Color(0xFF6366F1),
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Languages',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF6366F1),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    buildIconGrid(languages),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 50),
          // Technologies & Frameworks
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFF10B981).withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.engineering,
                            color: const Color(0xFF10B981),
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              'Technologies & Frameworks',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF10B981),
                              ),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    buildIconGrid(technologies),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 50),
          // Tools & Platforms
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEF4444).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFFEF4444).withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.build,
                            color: const Color(0xFFEF4444),
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              'Tools & Platforms',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFFEF4444),
                              ),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    buildIconGrid(tools),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
