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
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 9, 10, 9),
        elevation: 0,
        scrolledUnderElevation: 0, 
        shadowColor: Colors.transparent,
        title: Row(
          children: [
            Image.asset('assets/images/logo.png', height: 60),
            const SizedBox(width: 8),
            const Text("Harpreet Dosanjh"),
            const Spacer(),
            IconButton(
              icon: Icon(widget.isDarkMode ? Icons.light_mode : Icons.dark_mode),
              onPressed: widget.toggleTheme,
              tooltip: 'Toggle Theme',
            ),
            TextButton(onPressed: () => scrollTo(aboutKey), child: const Text("About")),
            TextButton(onPressed: () => scrollTo(skillsKey), child: const Text("Skills")),
            TextButton(onPressed: () => scrollTo(projectsKey), child: const Text("Projects")),
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
}