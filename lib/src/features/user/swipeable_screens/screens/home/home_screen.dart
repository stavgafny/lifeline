import 'package:flutter/material.dart';
import 'package:lifeline/src/features/user/data/upcoming_events/models/upcoming_event_model.dart';
import 'package:lifeline/src/features/user/data/upcoming_events/models/upcoming_event_type.dart';
import '../../../data/upcoming_events/views/upcoming_event_blob/upcoming_event_blob.dart';
import '../../../data/goal_trackers/views/goal_trackers_list_view/goal_trackers_list_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UpcomingEventBlob(
          model: UpcomingEventModel(
            name: "name",
            type: UpcomingEventType.celebration,
            date: DateTime.now(),
            details: "",
          ),
        ),
        const GoalTrackersListView(),
      ],
    );
  }
}
