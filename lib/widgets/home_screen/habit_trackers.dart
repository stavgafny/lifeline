import 'package:flutter/material.dart';
import 'package:lifeline/controllers/habit_tracker_controller.dart';
import 'package:lifeline/services/habit_tracker/storage.dart';
import 'package:lifeline/widgets/home_screen/habit_tracker.dart';

class HabitTrackers extends StatefulWidget {
  const HabitTrackers({Key? key}) : super(key: key);

  @override
  State<HabitTrackers> createState() => _HabitTrackersState();
}

class _HabitTrackersState extends State<HabitTrackers> {
  final _animatedListKey = GlobalKey<AnimatedListState>();

  void _removedHabit(HabitTrackerController tracker) {
    int index = HabitTrackerStorage.trackers.indexOf(tracker);
    tracker.dispose();
    _animatedListKey.currentState!.removeItem(
      index,
      (context, animation) => HabitTracker(
        tracker: tracker,
        onRemove: _removedHabit,
        animation: animation,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AnimatedList(
        key: _animatedListKey,
        initialItemCount: HabitTrackerStorage.trackers.length,
        itemBuilder: (context, index, animation) => HabitTracker(
          tracker: HabitTrackerStorage.trackers[index],
          onRemove: _removedHabit,
          animation: animation,
        ),
      ),
    );
  }
}
