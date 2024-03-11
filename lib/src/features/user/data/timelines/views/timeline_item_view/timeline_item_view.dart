import 'package:flutter/material.dart';
import '../../timeline/models/timeline_model.dart';
import './widgets/timeline_item_footer.dart';

class TimelineItemView extends StatelessWidget {
  static const _borderRadius = BorderRadius.all(Radius.circular(6.0));

  final TimelineModel timeline;
  final void Function()? onTap;

  const TimelineItemView({super.key, required this.timeline, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: _borderRadius,
        ),
        child: Column(
          children: [
            TimelineItemFooter(timeline: timeline),
          ],
        ),
      ),
    );
  }
}
