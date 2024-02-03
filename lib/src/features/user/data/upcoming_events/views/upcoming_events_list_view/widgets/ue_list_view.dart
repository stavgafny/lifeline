import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../controllers/upcoming_events_controller.dart';
import '../../../models/upcoming_event_model.dart';
import '../../../utils/upcoming_events_build_helper.dart';
import '../../upcoming_event_blob/upcoming_event_blob.dart';

class UEListView extends ConsumerWidget {
  final List<UpcomingEventModel> upcomingEvents;

  const UEListView({super.key, required this.upcomingEvents});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buildProperties = UpcomingEventsBuildHelper.getBuildProperties(
      context,
      upcomingEventsNumber: upcomingEvents.length,
    );

    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: buildProperties.maxHeight),
        child: SizedBox(
          width: double.infinity,
          height: buildProperties.height,
          child: ReorderableListView(
            scrollDirection: Axis.horizontal,
            children: [
              for (final upcomingEvent in upcomingEvents)
                SizedBox(
                  key: ValueKey(upcomingEvent),
                  width: buildProperties.itemSize,
                  child: UpcomingEventBlob(model: upcomingEvent),
                )
            ],
            onReorder: (oldIndex, newIndex) {
              ref
                  .read(upcomingEventsProvider.notifier)
                  .swap(oldIndex, newIndex);
            },
            proxyDecorator: (child, i, a) => Material(child: child),
          ),
        ),
      ),
    );
  }
}
