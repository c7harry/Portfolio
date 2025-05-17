import 'package:flutter/material.dart';

class ProjectsSection extends StatelessWidget {
  final List<Map<String, String>> projects = [
    {
      'title': 'Project One',
      'description': 'This is a cool project I built with Flutter.',
    },
    {
      'title': 'Project Two',
      'description': 'Another fun project with API integration.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: projects.map((project) {
        return Card(
          margin: EdgeInsets.all(12),
          child: ListTile(
            title: Text(project['title']!),
            subtitle: Text(project['description']!),
          ),
        );
      }).toList(),
    );
  }
}