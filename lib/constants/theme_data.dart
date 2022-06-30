import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFFC2A8F7),
    onPrimary: Color(0xFF34304B),
    secondary: Color(0xFFD6CCE3),
    onSecondary: Colors.black,
    error: Colors.red,
    onError: Colors.red,
    background: Color(0xFF6B6496),
    onBackground: Colors.black,
    surface: Color(0xFF574A67),
    onSurface: Color(0xFF3B343D),
  ),
  textTheme: GoogleFonts.montserratTextTheme().apply(
    bodyColor: const Color(0xFF3B343D),
  ),
  scaffoldBackgroundColor: const Color(0xFFDDD8EB),
);

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFA27EEC),
    onPrimary: Colors.black,
    secondary: Color(0xFF151219),
    onSecondary: Colors.black,
    error: Colors.red,
    onError: Colors.red,
    background: Color(0xFF332D47),
    onBackground: Colors.black,
    surface: Color(0xFF211D26),
    onSurface: Color(0xFFDDCDEE),
  ),
  textTheme: GoogleFonts.montserratTextTheme().apply(
    bodyColor: const Color(0xFFDDCDEE),
  ),
  scaffoldBackgroundColor: const Color(0xFF1F1920),
);
