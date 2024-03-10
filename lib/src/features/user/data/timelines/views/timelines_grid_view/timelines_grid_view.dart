import 'package:flutter/material.dart';
import 'package:lifeline/src/features/user/data/timelines/views/timeline_item_view/timeline_item_view.dart';

class TimelinesGridView extends StatelessWidget {
  static const EdgeInsets _padding = EdgeInsets.all(10.0);
  static const double _gridGap = 20.0;

  const TimelinesGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _padding,
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: _gridGap,
        mainAxisSpacing: _gridGap,
        children: const [
          TimelineItemView(),
          TimelineItemView(),
          TimelineItemView(),
        ],
      ),
    );
  }
}
