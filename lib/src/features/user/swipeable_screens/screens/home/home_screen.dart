import 'package:flutter/material.dart';
import '../../../data/goal_tracker/controllers/goal_tracker_controller.dart';
import '../../../data/goal_tracker/views/goal_tracker_card/goal_tracker_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 300),
        GoalTrackerCard(provider: goalTrackerProvider),
      ],
    );
  }
}
