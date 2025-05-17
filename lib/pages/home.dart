import 'package:flutter/material.dart';
import 'package:my_portfolio/pages/about.dart';
import 'package:my_portfolio/pages/contact.dart';
import 'package:my_portfolio/pages/header.dart';
import 'package:my_portfolio/pages/projects.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderSection(),
            AboutSection(),
            ProjectsSection(),
            ContactSection(),
          ],
        ),
      ),
    );
  }
}