import 'package:flutter/material.dart';

class ContactSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        children: [
          Text("Contact Me", style: TextStyle(fontSize: 24)),
          SizedBox(height: 10),
          Text("Email: your.email@example.com"),
          Text("LinkedIn: linkedin.com/in/yourprofile"),
          Text("GitHub: github.com/yourusername"),
        ],
      ),
    );
  }
}
