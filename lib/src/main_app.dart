import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import './constants/theme/app_theme.dart' as app_theme;
import './router/providers/router_provider.dart';
import './providers/theme_mode_provider.dart';

class MainApp extends ConsumerWidget {
  static const title = "Lifeline";

  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      title: title,
      theme: app_theme.lightTheme,
      darkTheme: app_theme.darkTheme,
      themeMode: themeMode,
      routerConfig: router,
    );
  }
}
