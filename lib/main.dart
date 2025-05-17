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
      title: 'Harpreet\'s Portfolio',
      theme: isDarkMode
          ? ThemeData.dark().copyWith(
              useMaterial3: true,
              scaffoldBackgroundColor: const Color.fromARGB(255, 9, 10, 9),
              primaryColor: Colors.cyanAccent,
              colorScheme: const ColorScheme.dark(
                primary: Colors.cyanAccent,
                secondary: Colors.amberAccent,
              ),
              textTheme: GoogleFonts.poppinsTextTheme(
                ThemeData.dark().textTheme,
              ).apply(
                bodyColor: Colors.white,
                displayColor: Colors.white,
              ),
              appBarTheme: const AppBarTheme(
                backgroundColor: Color.fromARGB(255, 9, 10, 9),
                elevation: 0,
                scrolledUnderElevation: 0,
              ),
            )
          : ThemeData.light().copyWith(
              useMaterial3: true,
              scaffoldBackgroundColor: Colors.white,
              primaryColor: Colors.teal,
              colorScheme: const ColorScheme.light(
                primary: Colors.teal,
                secondary: Colors.amber,
              ),
              textTheme: GoogleFonts.poppinsTextTheme(
                ThemeData.light().textTheme,
              ).apply(
                bodyColor: Colors.black87,
                displayColor: Colors.black87,
              ),
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.white,
                elevation: 0,
                scrolledUnderElevation: 0,
              ),
            ),
      home: HomePage(toggleTheme: toggleTheme, isDarkMode: isDarkMode),
      debugShowCheckedModeBanner: false,
    );
  }
}