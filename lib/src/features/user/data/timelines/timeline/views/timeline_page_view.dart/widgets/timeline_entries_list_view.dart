import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../controllers/timelines_controllers.dart';
import '../../../entries/entry/views/entry_card_view/entry_card_view.dart';
import '../../../entries/entry/views/entry_page_edit_view/entry_page_edit_view.dart';
import '../../../models/timeline_model.dart';

class TimelineEntriesListView extends ConsumerStatefulWidget {
  static const double _cardsHeight = 150.0;

  final TimelineModel timeline;

  const TimelineEntriesListView({super.key, required this.timeline});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TimelineEntriesListViewState();
}

class _TimelineEntriesListViewState
    extends ConsumerState<TimelineEntriesListView> {
  TimelinesController get _timelinesController =>
      ref.read(timelinesProvider.notifier);

  String _entryTitle(int index) => '${widget.timeline.name} #${index + 1}';

  @override
  Widget build(BuildContext context) {
    final timeline = widget.timeline;

    return ListView.builder(
      itemCount: timeline.entries.length,
      itemExtent: TimelineEntriesListView._cardsHeight,
      itemBuilder: (context, index) {
        final entry = timeline.entries.elementAt(index);
        return EntryCardView(
          model: entry,
          entryIndex: index,
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
