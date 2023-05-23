import 'package:flutter/material.dart';
import '../../controllers/goal_tracker_controller.dart';
import '../../services/goal_tracker/goal_tracker_storage.dart';
import '../../widgets/undo_snack_bar.dart';
import './goal_tracker.dart';

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

  /// Remove tracker from trackers list and show undo snack bar
  ///
  /// If undo pressed, insert removed tracker back in list on its previous index
  ///
  /// Else, on snack bar closed, dispose removed tracker
  void _onTrackerRemove(GoalTrackerController tracker) async {
    final index = _goalTrackers.indexOf(tracker);
    if (index == -1) return;
    UndoSnackBar(
      text: "Removed ${tracker.name.value}",
      onPressed: () async {
        // If undo pressed: insert tracker back with transition
        tracker.transitionController =
            GoalTrackerTransitionController(animateIn: true);
        _goalTrackers.insert(index, tracker);
        setState(() {});
      },
    ).display(context).closed.then((SnackBarClosedReason reason) {
      // On snack bar closed check if reason is because action(undo was pressed)
      if (reason != SnackBarClosedReason.action) {
        // If snack bar closed with any reason undo then dispose removed tracker
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
      child: Stack(
        children: [
          Theme(
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
                for (final tracker in _goalTrackers) _buildGoalTracker(tracker)
              ],
              //! Remove default shadow elevation on reorder drag
              proxyDecorator: (child, i, a) => Material(child: child),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: ElevatedButton(
                onPressed: _addNewTracker,
                style: ElevatedButton.styleFrom(
                  elevation: 5.0,
                  backgroundColor: Theme.of(context).colorScheme.background,
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 15.0,
                  ),
                  child: Icon(
                    Icons.add,
                    size: 32.0,
                  ),
                ),
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
