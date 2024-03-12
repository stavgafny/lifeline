import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../controllers/timelines_controllers.dart';
import '../../entries/entry/views/entry_card_view/entry_card_view.dart';
import '../../entries/entry/views/entry_page_edit_view/entry_page_edit_view.dart';
import '../../models/timeline_model.dart';

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
      body: _TimelineEntries(timeline),
    );
  }
}

class _TimelineEntries extends ConsumerStatefulWidget {
  static const double _cardsHeight = 150.0;

  final TimelineModel timeline;

  const _TimelineEntries(this.timeline);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TimelineEntriesState();
}

class _TimelineEntriesState extends ConsumerState<_TimelineEntries> {
  TimelinesController get _timelinesController =>
      ref.read(timelinesProvider.notifier);

  String _entryTitle(int index) => '${widget.timeline.name} #${index + 1}';

  @override
  Widget build(BuildContext context) {
    final timeline = widget.timeline;

    return ListView.builder(
      itemCount: timeline.entries.length,
      itemExtent: _TimelineEntries._cardsHeight,
      itemBuilder: (context, index) {
        final entry = timeline.entries.elementAt(index);
        return EntryCardView(
          model: entry,
          onTap: () => EntryPageEditView.display(
            context,
            entry: entry,
            title: _entryTitle(index),
            onUpdate: () {
              _timelinesController.updateTimeline(timeline);
              setState(() {});
            },
          ),
        );
      },
    );
  }
}
