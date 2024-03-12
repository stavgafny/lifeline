import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeline/src/features/user/data/timelines/utils/timelines_list_extension.dart';
import '../../controllers/timelines_controllers.dart';
import '../../timeline/views/timeline_page_view.dart/timeline_page_view.dart';
import '../timeline_item_view/timeline_item_view.dart';

class TimelinesGridView extends ConsumerWidget {
  static const EdgeInsets _padding = EdgeInsets.all(10.0);
  static const double _gridGap = 20.0;

  const TimelinesGridView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timelines = ref.watch(timelinesProvider)..sortByTimelineName();

    return GridView.count(
      crossAxisCount: 2,
      padding: _padding,
      crossAxisSpacing: _gridGap,
      mainAxisSpacing: _gridGap,
      children: [
        for (final timeline in timelines)
          TimelineItemView(
            timeline: timeline,
            onTap: () => TimelinePageView.display(context, timeline: timeline),
          )
      ],
    );
  }
}
