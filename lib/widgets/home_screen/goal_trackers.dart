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
  List<GoalTrackerController> _goalTrackers = [];

  Future<void> _fetchTrackers() async {
    _goalTrackers = await GoalTrackerStorage.fetch();
    setState(() {});
  }

  void _onTrackerRemove(GoalTrackerController tracker) async {
    // Immediately removes the tracker from trackers list to update "storedTrackers"
    // Shows SnackBar with undo action
    // If undo was pressed, inserts removed tracker back in trackers list on its previous index
    // Else, If SnackBar closed without undo action being called then dispose removed tracker

    int index = _goalTrackers.indexOf(tracker);
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
                _goalTrackers.insert(index, tracker);
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
    _goalTrackers.remove(tracker);
    await tracker.transitionController.fadeOut();
    GoalTrackerController.setSelected(null);
    setState(() {});
  }

  void _addNewTracker() {
    final tracker = GoalTrackerController.createEmpty();
    tracker.transitionController =
        GoalTrackerTransitionController(animateIn: true);
    _goalTrackers.insert(0, tracker);
    setState(() {});
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
      child: Column(
        children: [
          Expanded(
            child: Theme(
              //! Remove highlight color on reorder drag
              data: Theme.of(context).copyWith(
                canvasColor: Colors.transparent,
                shadowColor: Colors.transparent,
              ),
              child: ReorderableListView(
                onReorder: (oldIndex, newIndex) {
                  if (newIndex > oldIndex) newIndex--;
                  final tracker = _goalTrackers.removeAt(oldIndex);
                  _goalTrackers.insert(newIndex, tracker);
                  setState(() {});
                },
                children: [
                  for (final tracker in _goalTrackers)
                    _buildGoalTracker(tracker)
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: ElevatedButton(
              onPressed: _addNewTracker,
              child: const Padding(
                padding: EdgeInsets.all(15.0),
                child: Icon(Icons.add),
              ),
            ),
          ),
          const SizedBox(height: 10.0),
        ],
      ),
    );
  }

  Widget _buildEmptyTrackers(BuildContext context) {
    return Expanded(
      child: Center(
        child: ElevatedButton(
          onPressed: _addNewTracker,
          child: const Text("Reset"),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_goalTrackers.isNotEmpty) {
      return _buildTrackers(context);
    }
    return _buildEmptyTrackers(context);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _fetchTrackers();
  }

  @override
  void dispose() {
    // Save stored trackers on dispose (switched screen)
    GoalTrackerStorage.saveStoredGoalTrackers();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// On app resume fetch trackers to make sure no changes were made in
  /// foreground notification (press stop and on resume is still playing)
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) _fetchTrackers();
  }
}
