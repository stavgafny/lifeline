import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../controllers/timelines_controllers.dart';
import '../../../../entries/entry/models/entry_model.dart';
import '../../../../entries/entry/views/entry_card_view/entry_card_view.dart';
import '../../../../entries/entry/views/entry_page_view/entry_page_view.dart';
import '../../../../models/timeline_model.dart';
import './widgets/timeline_add_entry_button.dart';

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

  List<EntryModel> get entries => widget.timeline.entries;

  void _updateTimeline() {
    ref.read(timelinesProvider.notifier).updateTimeline(widget.timeline);
    setState(() {});
  }

  void _deleteEntry(EntryModel entry) {
    entries.remove(entry);
    _updateTimeline();
  }

  void _addEntry() async {
    final entry = EntryModel.createNew(widget.timeline.template);
    entries.add(entry);
    await _displayEntry(context, entry, entries.length - 1);
    if (mounted) _updateTimeline();
  }

  void _onReorder(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex--;

    oldIndex = _normalizeIndex(oldIndex);
    newIndex = _normalizeIndex(newIndex);
    entries.insert(newIndex, entries.removeAt(oldIndex));
    _updateTimeline();
  }

  Future<void> _displayEntry(
    BuildContext context,
    EntryModel entry,
    int index,
  ) {
    return EntryPageView.display(
      context,
      entry: entry,
      title: _entryTitle(index),
      onUpdate: _updateTimeline,
      onDelete: () => _deleteEntry(entry),
    );
  }

  int _normalizeIndex(int index) => entries.length - index - 1;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          child: ReorderableListView.builder(
            reverse: true,
            shrinkWrap: true,
            itemCount: entries.length,
            itemBuilder: (context, index) {
              return _buildEntry(context, _normalizeIndex(index));
            },
            onReorder: _onReorder,
            header: _buildAddEntryButton(context, constraints),
            proxyDecorator: (child, i, a) => Material(child: child),
          ),
        );
      },
    );
  }

  Widget _buildEntry(BuildContext context, int index) {
    final entry = widget.timeline.entries.elementAt(index);

    return SizedBox(
      key: ValueKey(index),
      height: TimelineEntriesListView._cardsHeight,
      child: EntryCardView(
        model: entry,
        entryIndex: index,
        onTap: () => _displayEntry(context, entry, index),
      ),
    );
  }

  Widget _buildAddEntryButton(
      BuildContext context, BoxConstraints constraints) {
    final mediaQueryPadding = MediaQuery.of(context).padding;
    final entriesHeight = entries.length * TimelineEntriesListView._cardsHeight;

    final double remainingScreenHeight = max(
      constraints.maxHeight -
          mediaQueryPadding.top -
          mediaQueryPadding.bottom -
          entriesHeight,
      TimelineAddEntryButton.height,
    );

    return SizedBox(
      height: remainingScreenHeight,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          height: TimelineAddEntryButton.height,
          child: TimelineAddEntryButton(
            entryNumber: entries.length + 1,
            onTap: _addEntry,
          ),
        ),
      ),
    );
  }
}
