import 'package:flutter/material.dart';
import './constants/theme/theme.dart' as app_theme;

class MainApp extends StatelessWidget {
  static const title = "Lifeline";

  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: app_theme.lightTheme,
      darkTheme: app_theme.darkTheme,
      themeMode: ThemeMode.system,
      home: const Scaffold(),
    );
  }
}
