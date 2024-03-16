import 'package:flutter/material.dart';
import '../../models/timeline_model.dart';
import './widgets/timeline_entries_list_view.dart';

class TimelinePageView extends StatelessWidget {
  static void display(
    BuildContext context, {
    required TimelineModel timeline,
  }) {
    final page = TimelinePageView._(timeline: timeline);

    showDialog(
      context: context,
      builder: (context) => page,
      barrierDismissible: false,
      useSafeArea: false,
    );
  }

  final TimelineModel timeline;

  const TimelinePageView._({required this.timeline});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          timeline.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: TimelineEntriesListView(timeline: timeline),
      ),
    );
  }
}
