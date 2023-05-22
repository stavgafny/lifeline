import 'package:flutter/material.dart';
import '../../../widgets/home_screen/upcoming_events.dart';
import '../../../widgets/home_screen/goal_trackers.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        UpcomingEvents(),
        GoalTrackers(),
      ],
    );
  }
}
