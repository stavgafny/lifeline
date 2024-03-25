import 'package:flutter/material.dart';
import '../../../../../router/routes/app_routes.dart';

class BottomNavbarItem {
  final String route;
  final Icon icon;
  const BottomNavbarItem({required this.route, required this.icon});
}

class BottomNavbarItems {
  static const _items = <BottomNavbarItem>[
    BottomNavbarItem(
      route: AppRoutes.dashboard,
      icon: Icon(Icons.dashboard, color: Colors.white),
    ),
    BottomNavbarItem(
      route: AppRoutes.home,
      icon: Icon(Icons.home, color: Colors.white),
    ),
    BottomNavbarItem(
      route: AppRoutes.timelines,
      icon: Icon(Icons.timeline, color: Colors.white),
    ),
  ];

  static List<Icon> get icons => _items.map((item) => item.icon).toList();

  static String at(int index) => _items[index].route;

  static int getRouteIndex(String route) {
    return _items.map((route) => route.route).toList().indexOf(route);
  }
}
