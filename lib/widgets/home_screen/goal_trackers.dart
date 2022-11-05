import 'package:flutter/material.dart';
import '../../controllers/goal_tracker_controller.dart';
import '../../services/goal_tracker/goal_tracker_storage.dart';
import './goal_tracker.dart';

const _trackerUndoDuration = Duration(milliseconds: 2500);

/// Fetch trackers from local storage once on init and every time the app is resumed
///
/// On each trackers fetch, assign them to "storedTrackers"
///
/// Build trackers if fetched and not empty
///
/// Else(not fetched yet or empty), build empty trackers widget
class GoalTrackers extends StatefulWidget {
  const GoalTrackers({super.key});

  @override
  State<GoalTrackers> createState() => _GoalTrackersState();
}

class _GoalTrackersState extends State<GoalTrackers>
    with WidgetsBindingObserver {
  List<GoalTrackerController> _trackers = [];

  Future<void> _fetchTrackers() async {
    _trackers = await GoalTrackerStorage.fetch();
    GoalTrackerStorage.storedTrackers = _trackers;
    setState(() {});
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) _fetchTrackers();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _fetchTrackers();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _onTrackerRemove(GoalTrackerController tracker) async {
    // Immediately removes the tracker from trackers list to update "storedTrackers"
    // Shows SnackBar with undo action
    // If undo was pressed, inserts removed tracker back in trackers list on its previous index
    // Else, If SnackBar closed without undo action being called then dispose removed tracker

    int index = _trackers.indexOf(tracker);
    if (index == -1) return;
    // Clear all previous SnackBars
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context)
        .showSnackBar(
          SnackBar(
            content: Text(
              "Removed ${tracker.name.value}",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            duration: _trackerUndoDuration,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
            ),
            action: SnackBarAction(
              label: "Undo",
              onPressed: () async {
                // If undo pressed: set tracker transition to animate in and insert back to trackers list
                tracker.transitionController =
                    GoalTrackerTransitionController(animateIn: true);
                _trackers.insert(index, tracker);
                setState(() {});
              },
            ),
          ),
        )
        .closed
        .then((SnackBarClosedReason reason) {
      // On SnackBar closed check if reason is because action(undo was pressed)
      if (reason != SnackBarClosedReason.action) {
        // If SnackBar closed with any reason but action(undo pressed) then dispose removed tracker
        tracker.dispose();
      }
    });
    _trackers.remove(tracker);
    await tracker.transitionController.fadeOut();
    GoalTrackerController.setSelected(null);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_trackers.isNotEmpty) {
      return _buildTrackers(context);
    }
    return _buildEmptyTrackers(context);
  }

  Widget _buildGoalTracker(GoalTrackerController tracker) {
    return GoalTracker(
      key: ValueKey(tracker),
      tracker: tracker,
      onRemove: () => _onTrackerRemove(tracker),
    );
  }

  Widget _buildTrackers(BuildContext context) {
    return Expanded(
      child: Theme(
        //! Theme to remove highlight color onb reorder drag
        data: Theme.of(context).copyWith(
          canvasColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: ReorderableListView(
          onReorder: (oldIndex, newIndex) {
            if (newIndex > oldIndex) newIndex--;
            final tracker = _trackers.removeAt(oldIndex);
            _trackers.insert(newIndex, tracker);
            setState(() {});
          },
          children: [
            for (final tracker in _trackers) _buildGoalTracker(tracker)
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyTrackers(BuildContext context) {
    return Expanded(
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            _trackers.addAll(resetTrackers);
            setState(() {});
          },
          child: const Text("Reset"),
        ),
      ),
    );
  }
}

final resetTrackers = [
  GoalTrackerController(
    name: "Read this is a very long as text",
    duration: const Duration(hours: 3),
    progress: const Duration(hours: 2, minutes: 13),
    playing: false,
    deadline: Deadline(
      days: 1,
      time: TimeOfDay.now(),
      active: true,
    ),
  ),
  GoalTrackerController(
    name: "Code",
    duration: const Duration(hours: 2, minutes: 30),
    progress: const Duration(),
    playing: false,
    deadline: Deadline(
      days: 2,
      time: TimeOfDay.now(),
      active: false,
    ),
  ),
  GoalTrackerController(
    name: "Play",
    duration: const Duration(minutes: 30),
    progress: const Duration(),
    playing: false,
    deadline: Deadline(
      days: 3,
      time: TimeOfDay.now(),
      active: false,
    ),
  ),
];
