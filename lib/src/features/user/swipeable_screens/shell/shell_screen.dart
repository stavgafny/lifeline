import 'package:flutter/material.dart';
import '../../data/goal_tracker/services/goal_trackers_foreground_task.dart';
import './widgets/top_appbar.dart';
import './widgets/bottom_navbar.dart';
import 'widgets/menu_drawer.dart';

class ShellScreen extends StatelessWidget {
  final Widget body;
  final String location;
  const ShellScreen({super.key, required this.body, required this.location});

  @override
  Widget build(BuildContext context) {
    return GoalTrackersForegroundTaskWrapper(
      scaffold: Scaffold(
        appBar: const TopAppbar(),
        endDrawer: const MenuDrawer(),
        body: body,
        bottomNavigationBar: BottomNavbar(initialRoute: location),
        endDrawerEnableOpenDragGesture: false,
      ),
    );
  }
}
