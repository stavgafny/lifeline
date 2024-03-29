import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './extensions/upcoming_event_edit_page_colors.dart';

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  pageTransitionsTheme: _pageTransitionsTheme,
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFFD396CC),
    onPrimary: Color(0xFF34304B),
    secondary: Color(0xFFD1C6DE),
    onSecondary: Color(0xFF726C7B),
    error: Colors.red,
    onError: Colors.red,
    background: Color(0xFFD195C2),
    onBackground: Colors.black,
    surface: Color(0xFFEDD8FB),
    onSurface: Color(0xFF3B343D),
  ),
  textTheme: GoogleFonts.montserratTextTheme().apply(
    bodyColor: const Color(0xFF3B343D),
  ),
  iconTheme: ThemeData.light().iconTheme.copyWith(
        color: const Color(0xFF3B343D),
      ),
  disabledColor: const Color(0xFFB8A4B4),
  scaffoldBackgroundColor: const Color(0xFFDDD8EB),
  appBarTheme: const AppBarTheme(
    foregroundColor: Color(0xFF462D3E),
    backgroundColor: Color(0xFFD4A1D4),
  ),
  navigationBarTheme: const NavigationBarThemeData(
    backgroundColor: Color(0xFF926E95),
    indicatorColor: Color(0xFFE9DDF7),
  ),
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: Color(0xFF36323B),
    contentTextStyle: TextStyle(color: Color(0xFFD3C4E2)),
    actionTextColor: Color(0xFFED91D3),
  ),
  dividerTheme: const DividerThemeData(color: Color(0xFF3B343D)),
  extensions: _extensions.light,
);

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  pageTransitionsTheme: _pageTransitionsTheme,
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFECAFDB),
    onPrimary: Color(0xFF33242F),
    secondary: Color(0xFF221B23),
    onSecondary: Color(0xFF655E6A),
    error: Colors.red,
    onError: Colors.red,
    background: Color(0xFF6F4B64),
    onBackground: Colors.black,
    surface: Color(0xFF362932),
    onSurface: Color(0xFFDDCDEE),
  ),
  textTheme: GoogleFonts.montserratTextTheme().apply(
    bodyColor: const Color(0xFFDDCDEE),
  ),
  iconTheme: ThemeData.dark().iconTheme.copyWith(
        color: const Color(0xFFDDCDEE),
      ),
  disabledColor: const Color(0xFF3B2D37),
  scaffoldBackgroundColor: const Color(0xFF1C171D),
  appBarTheme: const AppBarTheme(
    foregroundColor: Color(0xFFF0D4F0),
    backgroundColor: Color(0xFF2D212A),
  ),
  navigationBarTheme: const NavigationBarThemeData(
    backgroundColor: Color(0xFF704C68),
    indicatorColor: Color(0xFFE9DDF7),
  ),
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: Color(0xFF25212A),
    contentTextStyle: TextStyle(color: Color(0xFFD3C4E2)),
    actionTextColor: Color(0xFFFFA7E6),
  ),
  dividerTheme: const DividerThemeData(color: Color(0xFFDDCDEE)),
  extensions: _extensions.dark,
);

final _pageTransitionsTheme = PageTransitionsTheme(
  builders: Map<TargetPlatform, PageTransitionsBuilder>.fromIterable(
    TargetPlatform.values,
    value: (dynamic _) => const FadeUpwardsPageTransitionsBuilder(),
  ),
);

const _extensions = _Extensions(
  light: [
    UpcomingEventEditPageColors(
      date: Color(0xFFDBAEE9),
      days: Color(0xFFE8AAF5),
      time: Color(0xFFEEAAEF),
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
