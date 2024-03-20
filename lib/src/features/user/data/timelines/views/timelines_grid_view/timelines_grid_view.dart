import 'package:flutter/material.dart';
import './widgets/timelines_grid.dart';
import './widgets/add_timeline_button.dart';

class TimelinesGridView extends StatelessWidget {
  const TimelinesGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        AddTimelineButton(),
        Expanded(child: TimelinesGrid()),
      ],
    );
  }
}
