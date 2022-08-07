import 'package:flutter/material.dart';
import './habit_tracker.dart';
import '../../services/habit_tracker/storage.dart';
import '../../controllers/habit_tracker_controller.dart';

class HabitTrackers extends StatefulWidget {
  const HabitTrackers({Key? key}) : super(key: key);

  @override
  State<HabitTrackers> createState() => _HabitTrackersState();
}

class _HabitTrackersState extends State<HabitTrackers> {
  List<HabitTracker> habitTrackers = [];

  @override
  void initState() {
    habitTrackers = HabitTrackerStorage.trackers
        .map((tracker) => HabitTracker(
            key: ValueKey(tracker.id.toString()),
            tracker: tracker,
            onUpdate: update))
        .toList();

    super.initState();
  }

  void update(HabitTrackerController tracker, HabitTrackerEvent event) {
    if (event == HabitTrackerEvent.remove) {
      habitTrackers.removeAt(HabitTrackerStorage.trackers.indexOf(tracker));
      habitTrackers = [...habitTrackers];
      setState(() {});
    }
    HabitTrackerStorage.handleChange(tracker, event);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(children: habitTrackers),
    );
  }
}
