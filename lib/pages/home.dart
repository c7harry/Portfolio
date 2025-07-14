import 'package:flutter/material.dart';
import 'package:my_portfolio/pages/hero_section.dart';
import 'package:my_portfolio/pages/about.dart';
import 'package:my_portfolio/pages/skills.dart';
import 'package:my_portfolio/pages/projects.dart';
import 'package:my_portfolio/pages/certificates.dart';
import 'package:my_portfolio/pages/beta_projects.dart';
import 'package:my_portfolio/pages/footer_section.dart';
import '../widgets/continuous_background.dart';

class HomePage extends StatefulWidget {
  final VoidCallback toggleTheme;
  final bool isDarkMode;

  const HomePage({required this.toggleTheme, required this.isDarkMode});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey heroKey = GlobalKey();
  final GlobalKey aboutKey = GlobalKey();
  final GlobalKey skillsKey = GlobalKey();
  final GlobalKey projectsKey = GlobalKey();
  final GlobalKey certificatesKey = GlobalKey();
  final GlobalKey betaProjectsKey = GlobalKey();
  final GlobalKey footerKey = GlobalKey();

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
    final isMobile = MediaQuery.of(context).size.width < 900;
    final isVerySmallScreen = MediaQuery.of(context).size.width <= 320;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: isMobile ? 8 : 16,
        title: Row(
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: Image.asset(
                widget.isDarkMode
                    ? 'assets/images/logo.png'
                    : 'assets/images/logo-inverted.png',
                key: ValueKey<bool>(widget.isDarkMode),
                height: isMobile ? 50 : 50,
              ),
            ),
            SizedBox(width: isMobile ? 4 : 8),
            Text(isVerySmallScreen ? "Harpreet" : "Harpreet Dosanjh"),
            const Spacer(),
            IconButton(
              icon: Icon(
                widget.isDarkMode ? Icons.light_mode : Icons.dark_mode,
              ),
              onPressed: widget.toggleTheme,
              tooltip: 'Toggle Theme',
            ),
            if (!isMobile) ...[
              TextButton(
                onPressed: () => scrollTo(heroKey),
                child: const Text("Home"),
              ),
              TextButton(
                onPressed: () => scrollTo(aboutKey),
                child: const Text("About"),
              ),
              TextButton(
                onPressed: () => scrollTo(skillsKey),
                child: const Text("Skills"),
              ),
              TextButton(
                onPressed: () => scrollTo(betaProjectsKey),
                child: const Text("Beta Lab"),
              ),
              TextButton(
                onPressed: () => scrollTo(projectsKey),
                child: const Text("Projects"),
              ),
              TextButton(
                onPressed: () => scrollTo(certificatesKey),
                child: const Text("Certificates"),
              ),
              TextButton(
                onPressed: () => scrollTo(footerKey),
                child: const Text("Contact"),
              ),
            ],
          ],
        ),
      ),
      drawer:
          isMobile
              ? Drawer(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(16, 40, 16, 12),
                      decoration: BoxDecoration(
                        color: theme.primaryColor.withOpacity(0.1),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                widget.isDarkMode
                                    ? 'assets/images/logo.png'
                                    : 'assets/images/logo-inverted.png',
                                height: 40,
                              ),
                              SizedBox(width: isMobile ? 4 : 8),
                              Text(
                                isVerySmallScreen
                                    ? "Harpreet"
                                    : "Harpreet Dosanjh",
                              ),
                            ],
                          ),
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      title: const Text("Home"),
                      onTap: () {
                        Navigator.pop(context);
                        scrollTo(heroKey);
                      },
                    ),
                    ListTile(
                      title: const Text("About"),
                      onTap: () {
                        Navigator.pop(context);
                        scrollTo(aboutKey);
                      },
                    ),
                    ListTile(
                      title: const Text("Skills"),
                      onTap: () {
                        Navigator.pop(context);
                        scrollTo(skillsKey);
                      },
                    ),
                    ListTile(
                      title: const Text("Beta Lab"),
                      onTap: () {
                        Navigator.pop(context);
                        scrollTo(betaProjectsKey);
                      },
                    ),
                    ListTile(
                      title: const Text("Projects"),
                      onTap: () {
                        Navigator.pop(context);
                        scrollTo(projectsKey);
                      },
                    ),

                    ListTile(
                      title: const Text("Certificates"),
                      onTap: () {
                        Navigator.pop(context);
                        scrollTo(certificatesKey);
                      },
                    ),
                    ListTile(
                      title: const Text("Contact"),
                      onTap: () {
                        Navigator.pop(context);
                        scrollTo(footerKey);
                      },
                    ),
                  ],
                ),
              )
              : null,
      body: ContinuousBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                key: heroKey,
                child: HeroSection(onContactPressed: () => scrollTo(footerKey)),
              ),
              Container(key: aboutKey, child: AboutSection()),
              Container(key: skillsKey, child: SkillsSection()),
              Container(key: betaProjectsKey, child: BetaProjectsSection()),
              Container(key: projectsKey, child: ProjectsSection()),
              Container(key: certificatesKey, child: CertificatesSection()),
              Container(
                key: footerKey,
                child: FooterSection(
                  navigationCallbacks: {
                    'about': () => scrollTo(aboutKey),
                    'skills': () => scrollTo(skillsKey),
                    'projects': () => scrollTo(projectsKey),
                    'certificates': () => scrollTo(certificatesKey),
                    'contact': () => scrollTo(footerKey),
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
