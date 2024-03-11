import 'package:flutter/material.dart';
import '../../../timeline/models/timeline_model.dart';

class TimelineItemFooter extends StatelessWidget {
  static const EdgeInsets _padding = EdgeInsets.fromLTRB(6.0, 0.0, 2.0, 6.0);

  final TimelineModel timeline;

  const TimelineItemFooter({super.key, required this.timeline});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Divider(),
          Padding(
            padding: _padding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    timeline.name,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                const Icon(Icons.more_vert_rounded),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
