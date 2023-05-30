import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../services/upcoming_event/upcoming_event_storage.dart';
import '../../../../../models/upcoming_event_model.dart';
import '../../../../../widgets/undo_snack_bar.dart';
import './editable_upcoming_event_page.dart';
import './upcoming_event.dart';

class UpcomingEvents extends StatefulWidget {
  const UpcomingEvents({super.key});

  @override
  State<UpcomingEvents> createState() => _UpcomingEventsState();
}

class _UpcomingEventsState extends State<UpcomingEvents>
    with WidgetsBindingObserver {
  List<UpcomingEventModel> _upcomingEvents = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _fetchUpcomingEvents();
    _atMidnight().listen((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    if (_upcomingEvents.isNotEmpty) {
      return _buildUpcomingEvents(context);
    }
    return _buildEmptyUpcomingEvents(context);
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

  Future<void> _fetchUpcomingEvents() async {
    _upcomingEvents = await UpcomingEventStorage.fetch();
    setState(() {});
  }

  /// yields every time the clock strikes at midnight
  Stream<void> _atMidnight() async* {
    while (true) {
      final now = DateTime.now();
      final midnight =
          DateTime(now.year, now.month, now.day + 1).difference(now);
      await midnight.delay();
      yield null;
    }
  }

  /// Returns the index at which to insert the given [upcomingEvent] into
  /// [_upcomingEvents] list based on the event's date using a binary search.
  int _getInsertIndex(UpcomingEventModel upcomingEvent) {
    final date = upcomingEvent.date;
    final dates = _upcomingEvents.map((event) => event.date).toList();
    int left = 0, right = dates.length;
    while (left < right) {
      final mid = (left + right) ~/ 2;
      if (date.isAfter(dates[mid])) {
        left = mid + 1;
      } else {
        right = mid;
      }
    }
    return left;
  }

  /// Removes previous [upcomingEvent] in [_upcomingEvents] if exists in list,
  /// and reinsers it back with applied changes at the appropriate position
  ///
  /// Used for both creation and for reinserting it back based on updated date.
  void _reinsertUpcomingEvent(UpcomingEventModel upcomingEvent) {
    _upcomingEvents.remove(upcomingEvent);
    _upcomingEvents.insert(_getInsertIndex(upcomingEvent), upcomingEvent);
    setState(() {});
  }

  /// Pushes [EditableUpcomingEventPage] for given [upcomingEvent]
  void _editUpcomingEvent(UpcomingEventModel upcomingEvent) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditableUpcomingEventPage(
          model: upcomingEvent,
          onChange: () => _reinsertUpcomingEvent(upcomingEvent),
          onDelete: () => _removeUpcomingEvent(upcomingEvent),
        ),
      ),
    );
  }

  /// Remove upcoming event from upcoming events list and show undo snack bar
  ///
  /// If undo pressed, insert removed upcoming event back in list on its
  /// previous index
  void _removeUpcomingEvent(UpcomingEventModel upcomingEvent) {
    final index = _upcomingEvents.indexOf(upcomingEvent);
    if (index == -1) return;
    UndoSnackBar(
      text: "Removed ${upcomingEvent.name}",
      onPressed: () {
        _upcomingEvents.insert(index, upcomingEvent);
        setState(() {});
      },
    ).display(context);
    _upcomingEvents.remove(upcomingEvent);
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
                onTap: () =>
                    _editUpcomingEvent(UpcomingEventModel.createEmpty()),
              ),
            ),
            children: [
              for (final upcomingEvent in _upcomingEvents)
                SizedBox(
                  key: ValueKey(upcomingEvent),
                  width: size,
                  child: UpcomingEvent(
                    model: upcomingEvent,
                    onTap: () => _editUpcomingEvent(upcomingEvent),
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
}
