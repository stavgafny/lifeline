import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import '../../../../router/routes/app_routes.dart';

const _screenChangeAnimationDuration = Duration(milliseconds: 250);

class ShellScreen extends StatelessWidget {
  final Widget body;
  final String location;
  const ShellScreen({super.key, required this.body, required this.location});

  @override
  Widget build(BuildContext context) {
    final screenIndex = location == AppRoutes.dashboard
        ? 0
        : location == AppRoutes.timeline
            ? 2
            : 1;

    return Scaffold(
      body: body,
      bottomNavigationBar: CurvedNavigationBar(
        height: 65.0,
        index: screenIndex,
        letIndexChange: (index) {
          if (index != screenIndex) {
            context.go(
              index == 0
                  ? AppRoutes.dashboard
                  : index == 2
                      ? AppRoutes.timeline
                      : AppRoutes.home,
            );
            return true;
          }
          return false;
        },
        items: const [
          Icon(Icons.dashboard),
          Icon(Icons.home),
          Icon(Icons.timeline),
        ],
        color: Theme.of(context).navigationBarTheme.backgroundColor!,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        animationDuration: _screenChangeAnimationDuration,
        animationCurve: Curves.easeOutSine,
      ),
    );
  }
}
