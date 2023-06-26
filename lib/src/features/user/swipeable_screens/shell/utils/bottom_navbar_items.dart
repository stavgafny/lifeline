import 'package:flutter/material.dart';
import '../../../../../router/routes/app_routes.dart';

class BottomNavbarItem {
  final String route;
  final Icon icon;
  const BottomNavbarItem({required this.route, required this.icon});
}

class BottomNavbarItems {
  static const _items = <BottomNavbarItem>[
    BottomNavbarItem(route: AppRoutes.dashboard, icon: Icon(Icons.dashboard)),
    BottomNavbarItem(route: AppRoutes.home, icon: Icon(Icons.home)),
    BottomNavbarItem(route: AppRoutes.timeline, icon: Icon(Icons.timeline)),
  ];

  static List<Icon> get icons => _items.map((item) => item.icon).toList();

  static String at(int index) => _items[index].route;

  static int getRouteIndex(String route) {
    return _items.map((route) => route.route).toList().indexOf(route);
  }
}
