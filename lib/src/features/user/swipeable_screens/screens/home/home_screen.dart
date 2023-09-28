import 'package:flutter/material.dart';
import '../../../data/goal_tracker/models/goal_tracker_model.dart';
import '../../../data/goal_tracker/views/goal_tracker_card/goal_tracker_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        GoalTrackerCard(
          model: GoalTrackerModel(
            name: "Goal Tracker",
            duration: Duration(hours: 1, minutes: 5),
            progress: Duration(seconds: 4),
          ),
        ),
      ],
    );
  }
}
