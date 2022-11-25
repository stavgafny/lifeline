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
      name: "AAAasasd asdasd asdasd",
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
    // Gets screen dimensions
    final screenSize = MediaQuery.of(context).size;

    // Max height
    final maxHeight = screenSize.height / 4.0;

    // Number of upcoming events displayed at once
    final displayedOnScreen =
        screenSize.width ~/ UpcomingEvent.defaultMinimumSize;

    // Final size of every upcoming event is the screen width divided by the number displayed at once
    // If that number exceeds the total number of upcoming events then the size is the screen width divided by the number of upcoming events
    final size = screenSize.width /
        (displayedOnScreen > _upcomingEvents.length
            ? _upcomingEvents.length
            : displayedOnScreen);

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: maxHeight),
      child: SizedBox(
        width: double.infinity,
        height: size + UpcomingEvent.additionalTextSizes,
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
              width: size,
              child: UpcomingEvent.addButton(context),
            ),
            children: [
              for (final upcomingEvent in _upcomingEvents)
                SizedBox(
                  key: ValueKey(upcomingEvent),
                  width: size,
                  child: UpcomingEvent(
                    model: upcomingEvent,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
