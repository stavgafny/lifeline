import 'package:flutter/material.dart';
import '../../../widgets/home_screen/upcoming_events.dart';
import '../../../widgets/home_screen/habit_trackers.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        UpcomingEvents(),
        HabitTrackers(),
      ],
    );
  }
}
