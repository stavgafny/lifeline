import 'package:flutter/material.dart';
import '../../../widgets/home_screen/upcoming_events.dart';
import '../../../widgets/home_screen/goal_trackers.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  Widget _addButton(BuildContext context,
      {required String text, required void Function() onTap}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 2.0),
                Text(
                  text,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 15.0,
                  ),
                ),
                Icon(
                  Icons.add,
                  color: Theme.of(context).colorScheme.onPrimary,
                  size: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _addButtons(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _addButton(
              context,
              text: "Upcoming Event",
              onTap: () {},
            ),
            _addButton(
              context,
              text: "Goal Tracker",
              onTap: () => GoalTrackers.add?.call(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _addButtons(context),
        const UpcomingEvents(),
        const GoalTrackers(),
      ],
    );
  }
}
