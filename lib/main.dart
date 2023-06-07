import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:study_app/screen/home_screen.dart';

void main() {
  runApp(const ProviderScope(child: App()));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
