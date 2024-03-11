import 'package:flutter/material.dart';
import '../../entries/entry/views/entry_card_view/entry_card_view.dart';
import '../../entries/entry/views/entry_page_edit_view/entry_page_edit_view.dart';
import '../../models/timeline_model.dart';

class TimelinePageView extends StatelessWidget {
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
  Widget build(BuildContext context) {
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
        itemExtent: _cardsHeight,
        itemBuilder: (context, index) {
          final entry = timeline.entries.elementAt(index);
          return EntryCardView(
            model: entry,
            onTap: () => EntryPageEditView.display(context, entry: entry),
          );
        },
      ),
    );
  }
}
