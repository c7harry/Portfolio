import 'package:flutter/material.dart';
import 'package:my_portfolio/pages/about.dart';
import 'package:my_portfolio/pages/skills.dart';
import 'package:my_portfolio/pages/projects.dart';

class HomePage extends StatefulWidget {
  final VoidCallback toggleTheme;
  final bool isDarkMode;

  const HomePage({required this.toggleTheme, required this.isDarkMode});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey aboutKey = GlobalKey();
  final GlobalKey skillsKey = GlobalKey();
  final GlobalKey projectsKey = GlobalKey();

  void scrollTo(GlobalKey key) {
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor, // Dynamically adapt
        elevation: 0,
        scrolledUnderElevation: 0,
        shadowColor: Colors.transparent,
        title: Row(
          children: [
            Image.asset('assets/images/logo.png', height: 60),
            const SizedBox(width: 8),
            Text(
              "Harpreet Dosanjh",
              style: TextStyle(color: theme.colorScheme.onBackground),
            ),
            const Spacer(),
            IconButton(
              icon: Icon(
                widget.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                color: theme.iconTheme.color,
              ),
              onPressed: widget.toggleTheme,
              tooltip: 'Toggle Theme',
            ),
            _buildNavButton("About", () => scrollTo(aboutKey), theme),
            _buildNavButton("Skills", () => scrollTo(skillsKey), theme),
            _buildNavButton("Projects", () => scrollTo(projectsKey), theme),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(key: aboutKey, child: AboutSection()),
            Container(key: skillsKey, child: SkillsSection()),
            Container(key: projectsKey, child: ProjectsSection()),
          ],
        ),
      ),
    );
  }

  Widget _buildNavButton(String label, VoidCallback onPressed, ThemeData theme) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(color: theme.colorScheme.onBackground),
      ),
    );
  }
}