import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../router/routes/app_routes.dart';

class ShellScreen extends StatelessWidget {
  final Widget body;
  final String location;
  const ShellScreen({super.key, required this.body, required this.location});

  @override
  Widget build(BuildContext context) {
    final selected = location == AppRoutes.dashboard
        ? 0
        : location == AppRoutes.timeline
            ? 2
            : 1;

    return Scaffold(
      body: body,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selected,
        destinations: [
          NavigationDestination(
            label: 'Dashboard',
            icon: IconButton(
              icon: const Icon(Icons.dashboard),
              onPressed: () {
                context.go(AppRoutes.dashboard);
              },
            ),
          ),
          NavigationDestination(
            label: 'Home',
            icon: IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                context.go(AppRoutes.home);
              },
            ),
          ),
          NavigationDestination(
            label: 'Timeline',
            icon: IconButton(
              icon: const Icon(Icons.timeline),
              onPressed: () {
                context.go(AppRoutes.timeline);
              },
            ),
          ),
        ],
      ),
    );
  }
}
