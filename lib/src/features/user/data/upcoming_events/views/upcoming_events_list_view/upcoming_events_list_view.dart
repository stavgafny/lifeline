import 'package:flutter/material.dart';
import 'package:lifeline/src/features/user/data/upcoming_events/models/upcoming_event_model.dart';
import 'package:lifeline/src/features/user/data/upcoming_events/models/upcoming_event_type.dart';
import 'package:lifeline/src/features/user/data/upcoming_events/utils/upcoming_events_build_helper.dart';
import 'package:lifeline/src/features/user/data/upcoming_events/views/upcoming_event_blob/upcoming_event_blob.dart';

class UpcomingEventsListView extends StatelessWidget {
  const UpcomingEventsListView({super.key});

  Widget _buildUpcomingEvent(UpcomingEventModel upcomingEvent) {
    return UpcomingEventBlob(
      key: ValueKey(upcomingEvent),
      model: upcomingEvent,
    );
  }

  @override
  Widget build(BuildContext context) {
    final buildProperties = UpcomingEventsBuildHelper.getBuildProperties(
      context,
      upcomingEventsNumber: exampleModels.length,
    );

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: buildProperties.maxHeight),
      child: SizedBox(
        width: double.infinity,
        height: buildProperties.height,
        child: ReorderableListView(
          scrollDirection: Axis.horizontal,
          itemExtent: buildProperties.itemExtent,
          children: exampleModels.map(_buildUpcomingEvent).toList(),
          onReorder: (oldIndex, newIndex) {},
        ),
      ),
    );
  }
}

final exampleModels = [
  UpcomingEventModel(
    name: "example1",
    type: UpcomingEventType.birthday,
    date: DateTime.now(),
    details: "",
  ),
  UpcomingEventModel(
    name: "example2",
    type: UpcomingEventType.celebration,
    date: DateTime.now(),
    details: "",
  ),
  UpcomingEventModel(
    name: "example3",
    type: UpcomingEventType.movie,
    date: DateTime.now(),
    details: "",
  ),
  UpcomingEventModel(
    name: "example4",
    type: UpcomingEventType.groceries,
    date: DateTime.now(),
    details: "",
  ),
];
