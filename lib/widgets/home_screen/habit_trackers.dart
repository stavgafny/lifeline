import 'package:flutter/material.dart';
import '../habit_tracker.dart';
import '../../controllers/habit_trackers_controller.dart';

class HabitTrackers extends StatelessWidget {
  const HabitTrackers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = HabitTrackersController();

    List habits = [
      [
        "Exercise",
        const Duration(
          minutes: 30,
        ),
        const Duration(),
      ],
      [
        "Code",
        const Duration(
          days: 3,
        ),
        const Duration(
          hours: 10,
        ),
      ],
      [
        "Read",
        const Duration(
          minutes: 60,
        ),
        const Duration(minutes: 59, seconds: 0),
      ],
    ];

    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: habits.length,
        itemBuilder: (context, index) {
          return HabitTracker(
            name: habits[index][0],
            tracker: controller.createTracker(
              index,
              duration: habits[index][1],
              progress: habits[index][2],
              playing: false,
            ),
          );
        },
      ),
    );
  }
}
