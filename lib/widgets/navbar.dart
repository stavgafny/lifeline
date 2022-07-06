import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      height: 50,
      color: Theme.of(context).navigationBarTheme.backgroundColor!,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      animationDuration: const Duration(milliseconds: 250),
      index: 1,
      onTap: (int index) {
        return;
      },
      items: [
        Icon(
          Icons.track_changes_rounded,
          color: Theme.of(context).navigationBarTheme.indicatorColor,
        ),
        Icon(
          Icons.home,
          color: Theme.of(context).navigationBarTheme.indicatorColor,
        ),
        Icon(
          Icons.timeline_rounded,
          color: Theme.of(context).navigationBarTheme.indicatorColor,
        ),
      ],
    );
  }
}
