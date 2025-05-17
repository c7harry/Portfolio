import 'package:flutter/material.dart';
import 'package:my_portfolio/pages/home.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MyPortfolioApp());

class MyPortfolioApp extends StatefulWidget {
  @override
  State<MyPortfolioApp> createState() => _MyPortfolioAppState();
}

class _MyPortfolioAppState extends State<MyPortfolioApp> {
  bool isDarkMode = true;

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Portfolio',
      theme: isDarkMode
          ? ThemeData.dark().copyWith(
              scaffoldBackgroundColor: Colors.black,
              primaryColor: Colors.tealAccent,
              colorScheme: ColorScheme.dark(
                primary: Colors.tealAccent,
                secondary: Colors.amberAccent,
              ),
              textTheme: GoogleFonts.poppinsTextTheme(
                ThemeData.dark().textTheme,
              ).apply(
                bodyColor: Colors.white,
                displayColor: Colors.white,
              ),
            )
          : ThemeData.light().copyWith(
              scaffoldBackgroundColor: Colors.white,
              primaryColor: Colors.teal,
              colorScheme: ColorScheme.light(
                primary: Colors.teal,
                secondary: Colors.amber,
              ),
              textTheme: GoogleFonts.poppinsTextTheme(
                ThemeData.light().textTheme,
              ).apply(
                bodyColor: Colors.black,
                displayColor: Colors.black,
              ),
            ),
      home: HomePage(toggleTheme: toggleTheme, isDarkMode: isDarkMode),
      debugShowCheckedModeBanner: false,
    );
  }
}