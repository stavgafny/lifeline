import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './extensions/upcoming_event_edit_page_colors.dart';

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFFD396CC),
    onPrimary: Color(0xFF34304B),
    secondary: Color(0xFFD1C6DE),
    onSecondary: Color(0xFF726C7B),
    error: Colors.red,
    onError: Colors.red,
    background: Color(0xFF7F5C76),
    onBackground: Colors.black,
    surface: Color(0xFFEDD8FB),
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
    backgroundColor: Color(0xFF8C6583),
    indicatorColor: Color(0xFFE9DDF7),
  ),
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: Color(0xFF36323B),
    contentTextStyle: TextStyle(color: Color(0xFFD3C4E2)),
    actionTextColor: Color(0xFFB895FF),
  ),
  extensions: extensions.light,
);

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFFDB2E8),
    onPrimary: Color(0xFF33242F),
    secondary: Color(0xFF221B23),
    onSecondary: Color(0xFF655E6A),
    error: Colors.red,
    onError: Colors.red,
    background: Color(0xFF472D3D),
    onBackground: Colors.black,
    surface: Color(0xFF362932),
    onSurface: Color(0xFFDDCDEE),
  ),
  textTheme: GoogleFonts.montserratTextTheme().apply(
    bodyColor: const Color(0xFFDDCDEE),
  ),
  scaffoldBackgroundColor: const Color(0xFF1C171D),
  appBarTheme: const AppBarTheme(
    foregroundColor: Color(0xFFE9DDF7),
    backgroundColor: Color(0xFF553B54),
  ),
  navigationBarTheme: const NavigationBarThemeData(
    backgroundColor: Color(0xFF6B4765),
    indicatorColor: Color(0xFFE9DDF7),
  ),
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: Color(0xFF25212A),
    contentTextStyle: TextStyle(color: Color(0xFFD3C4E2)),
    actionTextColor: Color(0xFFFFA7E6),
  ),
  extensions: extensions.dark,
);

const extensions = _Extensions(
  light: [
    UpcomingEventEditPageColors(
      date: Color(0xFFDBAEE9),
      days: Color(0xFFE8AAF5),
      time: Color(0xFFF49AF5),
    ),
  ],
  dark: [
    UpcomingEventEditPageColors(
      date: Color(0xFF3C2B37),
      days: Color(0xFF523547),
      time: Color(0xFF9B608A),
    ),
  ],
);

class _Extensions {
  final List<ThemeExtension<dynamic>> light;
  final List<ThemeExtension<dynamic>> dark;
  const _Extensions({required this.light, required this.dark});
}
