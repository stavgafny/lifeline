import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeline/src/widgets/snackbars.dart';
import '../../../../../controllers/timelines_controllers.dart';
import '../../../../entries/entry/models/entry_model.dart';
import '../../../../entries/entry/views/entry_card_view/entry_card_view.dart';
import '../../../../entries/entry/views/entry_page_view/entry_page_view.dart';
import '../../../../models/timeline_model.dart';
import './widgets/timeline_add_entry_button.dart';

class TimelineEntriesListView extends ConsumerStatefulWidget {
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
    await _displayEntry(context, entry, entries.length, true);
    if (!mounted) return;
    if (entry.hasChanges) {
      entries.add(entry);
      _updateTimeline();
    } else {
      _showBlankEntrySnackbar(context);
    }
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
    bool isNew,
  ) {
    return EntryPageView.display(
      context,
      entry: entry,
      title: _entryTitle(index),
      onUpdate: _updateTimeline,
      onDelete: () => _deleteEntry(entry),
      isNew: isNew,
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
              return _buildEntryCard(context, _normalizeIndex(index));
            },
            onReorder: _onReorder,
            header: _buildAddEntryButton(context, constraints),
            proxyDecorator: (child, i, a) => Material(child: child),
          ),
        );
      },
    );
  }

  Widget _buildEntryCard(BuildContext context, int index) {
    final entry = widget.timeline.entries.elementAt(index);

    return SizedBox(
      key: ValueKey(index),
      height: EntryCardView.cardHeight,
      child: EntryCardView(
        model: entry,
        entryIndex: index,
        onTap: () => _displayEntry(context, entry, index, false),
      ),
    );
  }

  Widget _buildAddEntryButton(
      BuildContext context, BoxConstraints constraints) {
    final mediaQueryPadding = MediaQuery.of(context).padding;
    final entriesHeight = entries.length * EntryCardView.cardHeight;

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

void _showBlankEntrySnackbar(BuildContext context) {
  const InfoSnackBar(
    text: "Blank entry not saved",
    textAlign: TextAlign.center,
  ).display(
    context,
    override: true,
  );
}
