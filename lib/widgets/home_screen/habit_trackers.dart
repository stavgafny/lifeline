import 'package:flutter/material.dart';
import './habit_tracker.dart';
import '../../controllers/habit_tracker_controller.dart';

final trackers = <HabitTrackerController>[
  HabitTrackerController(
    name: "Read this is a very long as text",
    duration: const Duration(hours: 3),
    progress: const Duration(hours: 2, minutes: 13),
    playing: false,
    deadline: Deadline(
      date: Deadline.getNextDate(DeadlineRoutine.daily),
      routine: DeadlineRoutine.daily,
    ),
  ),
  HabitTrackerController(
    name: "Code",
    duration: const Duration(hours: 2, minutes: 30),
    progress: const Duration(),
    playing: false,
    deadline: Deadline(
        date: Deadline.getNextDate(DeadlineRoutine.weekly),
        routine: DeadlineRoutine.weekly),
  ),
  HabitTrackerController(
    name: "Play",
    duration: const Duration(minutes: 30),
    progress: const Duration(),
    playing: true,
    deadline: Deadline(
      date: Deadline.getNextDate(DeadlineRoutine.monthly),
      routine: DeadlineRoutine.monthly,
    ),
  ),
];

class HabitTrackers extends StatefulWidget {
  const HabitTrackers({Key? key}) : super(key: key);

  @override
  State<HabitTrackers> createState() => _HabitTrackersState();
}

class _HabitTrackersState extends State<HabitTrackers> {
  void update() {
    print("UPDATE");
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: trackers.length,
        itemBuilder: (context, index) {
          return HabitTracker(
            tracker: trackers[index],
            onChange: update,
            onRemovePressed: () => setState(() => trackers.removeAt(index)),
          );
        },
      ),
    );
  }
}
