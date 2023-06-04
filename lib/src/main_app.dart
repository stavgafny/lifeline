import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import './constants/theme/theme.dart' as app_theme;
import './router/routes.dart';

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
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}
