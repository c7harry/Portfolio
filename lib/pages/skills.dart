import 'package:flutter/material.dart';

class SkillsSection extends StatelessWidget {
  final List<Map<String, dynamic>> languages = [
    {'name': 'JavaScript', 'asset': 'assets/images/javascript.png'},
    {'name': 'Python', 'asset': 'assets/images/python.png'},
    {'name': 'C++', 'asset': 'assets/images/cpp.png'},
    {'name': 'HTML', 'asset': 'assets/images/html.png'},
    {'name': 'CSS', 'asset': 'assets/images/css.png'},
  ];

  final List<Map<String, dynamic>> technologies = [
    {'name': 'React', 'asset': 'assets/images/react.png'},
    {'name': 'Flutter', 'asset': 'assets/images/flutter.png'},
    {'name': 'Firebase', 'asset': 'assets/images/firebase.png'},
    {'name': 'Git', 'asset': 'assets/images/git.png'},
    {'name': 'Tailwind', 'asset': 'assets/images/tailwind.png'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Widget buildIconGrid(List<Map<String, dynamic>> items) {
      return Wrap(
        spacing: 24,
        runSpacing: 24,
        alignment: WrapAlignment.center,
        children: items.map((item) {
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
                    boxShadow: isDark
                        ? []
                        : [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                  ),
                  child: Image.asset(
                    item['asset'],
                    width: 40,
                    height: 40,
                  ),
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

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      color: isDark ? const Color.fromARGB(255, 9, 10, 9) : Colors.white,
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
          Text(
            'Languages',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white70 : Colors.black87,
            ),
          ),
          const SizedBox(height: 20),
          buildIconGrid(languages),
          const SizedBox(height: 40),
          Text(
            'Technologies & Frameworks',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white70 : Colors.black87,
            ),
          ),
          const SizedBox(height: 20),
          buildIconGrid(technologies),
        ],
      ),
    );
  }
}