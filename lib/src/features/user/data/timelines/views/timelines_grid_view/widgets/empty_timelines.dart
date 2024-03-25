import 'package:flutter/material.dart';
import 'package:lifeline/src/widgets/transitions.dart';

class EmptyTimelines extends StatelessWidget {
  const EmptyTimelines({super.key});

  @override
  Widget build(BuildContext context) {
    return Transitions.scale(
      controller: TransitionController(animateOnStart: true),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "No timelines yet?",
            style: TextStyle(fontSize: 24.0),
          ),
          Text(
            "Let's paint some memories!",
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}
