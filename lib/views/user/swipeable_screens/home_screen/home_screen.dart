import 'package:flutter/material.dart';
import './widgets/upcoming_events.dart';
import './widgets/goal_trackers.dart';

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
