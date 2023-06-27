import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import '../utils/bottom_navbar_items.dart';

const _screenChangeAnimationDuration = Duration(milliseconds: 250);
const _navHeight = 72.0;

class BottomNavbar extends StatelessWidget {
  final int navIndex;
  BottomNavbar({super.key, required String initialRoute})
      : navIndex = BottomNavbarItems.getRouteIndex(initialRoute);

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      height: _navHeight,
      index: navIndex,
      letIndexChange: (index) {
        if (index != navIndex) {
          context.go(BottomNavbarItems.at(index));
          return true;
        }
        return false;
      },
      items: BottomNavbarItems.icons,
      color: Theme.of(context).navigationBarTheme.backgroundColor!,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      animationDuration: _screenChangeAnimationDuration,
      animationCurve: Curves.easeOutSine,
    );
  }
}
