import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../controllers/timelines_controllers.dart';
import './widgets/no_timeline_error.dart';
import './widgets/timeline_entries_list_view/timeline_entries_list_view.dart';

class TimelineScreen extends ConsumerWidget {
  final String timelineName;

  const TimelineScreen({super.key, required this.timelineName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timeline =
        ref.read(timelinesProvider.notifier).getTimelineByName(timelineName);

    if (timeline == null) return const NoTimelineError();

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          timeline.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(child: TimelineEntriesListView(timeline: timeline)),
    );
  }
}
