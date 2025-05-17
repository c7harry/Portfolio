import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        children: [
          Text("Hi, I'm Alice", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
          Text("A Frontend Developer", style: TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}
