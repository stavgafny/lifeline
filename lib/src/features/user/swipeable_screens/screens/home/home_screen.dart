import 'package:flutter/material.dart';
import '../../../data/goal_trackers/views/goal_trackers_list_view/goal_trackers_list_view.dart';
import '../../../data/upcoming_events/views/upcoming_events_list_view/upcoming_events_list_view.dart';

class HomeScreen extends StatelessWidget {
  static const _gap = SizedBox(height: 10.0);

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        UpcomingEventsListView(),
        _gap,
        GoalTrackersListView(),
      ],
    );
  }
}
