import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeline/src/features/user/data/timelines/utils/timelines_list_extension.dart';
import '../../controllers/timelines_controllers.dart';
import './widgets/timelines_grid.dart';
import './widgets/add_timeline_button.dart';
import './widgets/empty_timelines.dart';

class TimelinesGridView extends ConsumerWidget {
  const TimelinesGridView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timelines = ref.watch(timelinesProvider)..sortByTimelineName();

    return Column(
      children: [
        const AddTimelineButton(),
        Expanded(
          child: timelines.isEmpty
              ? const EmptyTimelines()
              : TimelinesGrid(timelines: timelines),
        ),
      ],
    );
  }
}
