import 'package:flutter/material.dart';
import '../../models/upcoming_event_model.dart';
import './upcoming_event.dart';

class UpcomingEvents extends StatefulWidget {
  const UpcomingEvents({super.key});

  @override
  State<UpcomingEvents> createState() => _UpcomingEventsState();
}

class _UpcomingEventsState extends State<UpcomingEvents> {
  final List<UpcomingEventModel> _upcomingEvents = [
    UpcomingEventModel(
      name: "AAA",
      date: DateTime.now(),
      type: UpcomingEventType.celebration,
    ),
    UpcomingEventModel(
      name: "BBB",
      date: DateTime.now(),
      type: UpcomingEventType.grocery,
    ),
    UpcomingEventModel(
      name: "CCC",
      date: DateTime.now(),
      type: UpcomingEventType.shopping,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    final height = screenSize.height / 5;
    final width = screenSize.width / 3;

    return SizedBox(
      width: double.infinity,
      height: height,
      child: Theme(
        //! Remove highlight color on reorder drag
        data: Theme.of(context).copyWith(
          canvasColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: ReorderableListView(
          scrollDirection: Axis.horizontal,
          onReorder: (oldIndex, newIndex) {
            if (newIndex > oldIndex) newIndex--;
            final upcomingEvent = _upcomingEvents.removeAt(oldIndex);
            _upcomingEvents.insert(newIndex, upcomingEvent);
            setState(() {});
          },
          footer: SizedBox(
            width: width,
            child: UpcomingEvent.addButton(context),
          ),
          children: [
            for (final upcomingEvent in _upcomingEvents)
              SizedBox(
                key: ValueKey(upcomingEvent),
                width: width,
                child: UpcomingEvent(
                  model: upcomingEvent,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
