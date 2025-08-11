import 'package:flutter/material.dart';
import 'package:growth/primary_pages/goals_page.dart';
import 'package:growth/secondary_pages/steps_page.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF9F9F9),
        primaryColor: const Color(0xFF5B5F97),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF5B5F97),
          secondary: const Color(0xFFA1C6EA),
          brightness: Brightness.light,
        ),
        textTheme: GoogleFonts.rubikTextTheme(
          Theme.of(context).textTheme,
        ).copyWith(
          headlineSmall: GoogleFonts.playfairDisplay(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          bodyMedium: GoogleFonts.rubik(fontSize: 16),
        ),
        useMaterial3: true,
      ),
      home: StepsPage(
        goalTitle: 'My Business Goal',
        description: 'Steps to achieve my business goal',
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
