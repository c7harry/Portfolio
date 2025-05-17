import 'package:flutter/material.dart';
import 'package:my_portfolio/pages/home.dart';

void main() => runApp(MyPortfolioApp());

class MyPortfolioApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Portfolio',
      theme: ThemeData.dark(),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}