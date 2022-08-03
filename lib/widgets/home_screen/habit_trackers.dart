import 'package:flutter/material.dart';
import './habit_tracker.dart';
import '../../controllers/habit_tracker_controller.dart';

final trackers = <HabitTrackerController>[
  HabitTrackerController(
    name: "Read this is a very long as text",
    duration: const Duration(hours: 3),
    progress: const Duration(hours: 2, minutes: 13),
    playing: false,
  ),
  HabitTrackerController(
    name: "Code",
    duration: const Duration(days: 1, hours: 3),
    progress: const Duration(),
    playing: false,
  ),
  HabitTrackerController(
    name: "Play",
    duration: const Duration(minutes: 30),
    progress: const Duration(),
    playing: true,
  ),
];

class HabitTrackers extends StatelessWidget {
  const HabitTrackers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: trackers.length,
        itemBuilder: (context, index) {
          return HabitTracker(
            tracker: trackers[index],
          );
        },
      ),
    );
  }
}
