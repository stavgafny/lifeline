import 'package:flutter/material.dart';
import '../../services/upcoming_event/upcoming_event_storage.dart';
import '../../models/upcoming_event_model.dart';
import './upcoming_event.dart';

class UpcomingEvents extends StatefulWidget {
  const UpcomingEvents({super.key});

  @override
  State<UpcomingEvents> createState() => _UpcomingEventsState();
}

class _UpcomingEventsState extends State<UpcomingEvents>
    with WidgetsBindingObserver {
  List<UpcomingEventModel> _upcomingEvents = [];

  Future<void> _fetchUpcomingEvents() async {
    _upcomingEvents = await UpcomingEventStorage.fetch();
    setState(() {});
  }

  Widget _buildUpcomingEvents(BuildContext context) {
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
              child: UpcomingEvent.addButton(
                context,
                onTap: () {
                  final upcomingEvent = UpcomingEventModel.createEmpty();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => UpcomingEvent.editablePage(
                        model: upcomingEvent,
                        onChange: () => setState(() {
                          _upcomingEvents.remove(upcomingEvent);
                          _upcomingEvents.add(upcomingEvent);
                        }),
                        onDelete: () => setState(() {
                          _upcomingEvents.remove(upcomingEvent);
                        }),
                      ),
                    ),
                  );
                },
              ),
            ),
            children: [
              for (final upcomingEvent in _upcomingEvents)
                SizedBox(
                  key: ValueKey(upcomingEvent),
                  width: size,
                  child: UpcomingEvent(
                    model: upcomingEvent,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => UpcomingEvent.editablePage(
                            model: upcomingEvent,
                            onChange: () => setState(() {}),
                            onDelete: () => setState(() {
                              _upcomingEvents.remove(upcomingEvent);
                            }),
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
            //! Remove default shadow elevation on reorder drag
            proxyDecorator: (child, i, a) => Material(child: child),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyUpcomingEvents(BuildContext context) {
    return const Center(
      child: Text("Empty"),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_upcomingEvents.isNotEmpty) {
      return _buildUpcomingEvents(context);
    }
    return _buildEmptyUpcomingEvents(context);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _fetchUpcomingEvents();
  }

  @override
  void dispose() {
    // Save stored upcoming events on dispose (switched screen)
    UpcomingEventStorage.saveUpcomingEvents(_upcomingEvents);
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // If event isn't resume save stored upcoming events(inactive/paused/detached)
    if (state != AppLifecycleState.resumed) {
      UpcomingEventStorage.saveUpcomingEvents(_upcomingEvents);
    }
  }
}
