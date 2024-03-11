import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../controllers/timelines_controllers.dart';
import '../../entries/entry/views/entry_card_view/entry_card_view.dart';
import '../../entries/entry/views/entry_page_edit_view/entry_page_edit_view.dart';
import '../../models/timeline_model.dart';

class TimelinePageView extends ConsumerStatefulWidget {
  static const double _cardsHeight = 150.0;

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
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TimelinePageViewState();
}

class _TimelinePageViewState extends ConsumerState<TimelinePageView> {
  TimelinesController get _timelinesController =>
      ref.read(timelinesProvider.notifier);

  String _entryTitle(int index) => '${widget.timeline.name} #${index + 1}';

  @override
  Widget build(BuildContext context) {
    final timeline = widget.timeline;
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          timeline.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        itemCount: timeline.entries.length,
        itemExtent: TimelinePageView._cardsHeight,
        itemBuilder: (context, index) {
          final entry = timeline.entries.elementAt(index);
          return EntryCardView(
            model: entry,
            onTap: () => EntryPageEditView.display(
              context,
              entry: entry,
              title: _entryTitle(index),
              onUpdate: (updatedEntry) {
                final entries = timeline.entries;
                entries[index] = updatedEntry;
                _timelinesController.store(timeline.copyWith(entries: entries));
                setState(() {});
              },
            ),
          );
        },
      ),
    );
  }
}
