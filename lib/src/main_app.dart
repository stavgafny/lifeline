import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import './constants/theme/theme.dart' as app_theme;
import './router/providers/router_provider.dart';

class MainApp extends ConsumerWidget {
  static const title = "Lifeline";

  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: title,
      theme: app_theme.lightTheme,
      darkTheme: app_theme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: router,
    );
  }
}
