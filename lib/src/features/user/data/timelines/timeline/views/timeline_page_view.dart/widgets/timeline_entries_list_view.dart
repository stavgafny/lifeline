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
  String _entryTitle(int index) => '${widget.timeline.name} #${index + 1}';

  void _updateTimeline() {
    ref.read(timelinesProvider.notifier).updateTimeline(widget.timeline);
    setState(() {});
  }

  int _normalizeIndex(int index) => widget.timeline.entries.length - 1 - index;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      child: ReorderableListView.builder(
        reverse: true,
        shrinkWrap: true,
        itemCount: widget.timeline.entries.length,
        itemBuilder: (context, index) {
          return _buildEntry(context, _normalizeIndex(index));
        },
        onReorder: (oldIndex, newIndex) {
          if (newIndex > oldIndex) newIndex--;

          oldIndex = _normalizeIndex(oldIndex);
          newIndex = _normalizeIndex(newIndex);
          final entries = widget.timeline.entries;
          entries.insert(newIndex, entries.removeAt(oldIndex));
          _updateTimeline();
        },
        proxyDecorator: (child, i, a) => Material(child: child),
      ),
    );
  }

  Widget _buildEntry(BuildContext context, int index) {
    final entry = widget.timeline.entries.elementAt(index);

    return SizedBox(
      key: ValueKey(entry),
      height: TimelineEntriesListView._cardsHeight,
      child: EntryCardView(
        model: entry,
        entryIndex: index,
        onTap: () => EntryPageEditView.display(
          context,
          entry: entry,
          title: _entryTitle(index),
          onUpdate: _updateTimeline,
        ),
      ),
    );
  }
}
