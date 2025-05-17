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
      title: 'Harpreets Portfolio',
      theme: isDarkMode
          ? ThemeData.dark().copyWith(
              scaffoldBackgroundColor: const Color.fromARGB(255, 9, 10, 9),
              primaryColor: const Color.fromARGB(255, 255, 255, 255),
              colorScheme: ColorScheme.dark(
                primary: const Color.fromARGB(255, 255, 255, 255),
                secondary: const Color.fromARGB(255, 255, 255, 255),
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
              primaryColor: const Color.fromARGB(255, 0, 0, 0),
              colorScheme: ColorScheme.light(
                primary: const Color.fromARGB(255, 0, 0, 0),
                secondary: const Color.fromARGB(255, 255, 255, 255),
              ),
              textTheme: GoogleFonts.poppinsTextTheme(
                ThemeData.light().textTheme,
              ).apply(
                bodyColor: const Color.fromARGB(255, 9, 10, 9),
                displayColor: const Color.fromARGB(255, 9, 10, 9),
              ),
            ),
      home: HomePage(toggleTheme: toggleTheme, isDarkMode: isDarkMode),
      debugShowCheckedModeBanner: false,
    );
  }
}