import 'package:flutter/material.dart';
import '../../services/habit_tracker/storage.dart';
import './habit_tracker.dart';

class HabitTrackers extends StatefulWidget {
  const HabitTrackers({Key? key}) : super(key: key);

  @override
  State<HabitTrackers> createState() => _HabitTrackersState();
}

class _HabitTrackersState extends State<HabitTrackers> {
  void removedHabit() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: HabitTrackerStorage.trackers.length,
        itemBuilder: (context, index) {
          return HabitTracker(
            tracker: HabitTrackerStorage.trackers[index],
            onRemove: removedHabit,
          );
        },
      ),
    );
  }
}
