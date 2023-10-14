import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Theme data for light Theme
ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    bodyLarge: TextStyle(fontSize: 18, color: Colors.black87),
  ),
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(
      fontFamily: GoogleFonts.fasthand(
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.italic,
      ).fontFamily,
      fontSize: 36,
      color: const Color.fromARGB(237, 254, 254, 254),
    ),
    color: const Color.fromARGB(255, 73, 159, 229),
    iconTheme: const IconThemeData(color: Colors.white),
  ),
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
);
