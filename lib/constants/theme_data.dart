import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFFC2A8F7),
    onPrimary: Color(0xFF34304B),
    secondary: Color(0xFFD6CCE3),
    onSecondary: Color(0xFF726C7B),
    error: Colors.red,
    onError: Colors.red,
    background: Color(0xFF6B6496),
    onBackground: Colors.black,
    surface: Color(0xFF726187),
    onSurface: Color(0xFF3B343D),
  ),
  textTheme: GoogleFonts.montserratTextTheme().apply(
    bodyColor: const Color(0xFF3B343D),
  ),
  scaffoldBackgroundColor: const Color(0xFFDDD8EB),
  appBarTheme: const AppBarTheme(
    foregroundColor: Color(0xFF1E1924),
    backgroundColor: Color(0xFF8E74AB),
  ),
  navigationBarTheme: const NavigationBarThemeData(
    backgroundColor: Color(0xFF78658C),
    indicatorColor: Color(0xFFE9DDF7),
  ),
);

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF9B79E1),
    onPrimary: Colors.black,
    secondary: Color(0xFF151219),
    onSecondary: Color(0xFF655E6A),
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
  appBarTheme: const AppBarTheme(
    foregroundColor: Color(0xFFE9DDF7),
    backgroundColor: Color(0xFF47374B),
  ),
  navigationBarTheme: const NavigationBarThemeData(
    backgroundColor: Color(0xFF56405B),
    indicatorColor: Color(0xFFE9DDF7),
  ),
);
