import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:study_app/screen/home_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          elevation: 2,
          titleTextStyle: TextStyle(
            fontFamily: GoogleFonts.sawarabiGothic().fontFamily,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
