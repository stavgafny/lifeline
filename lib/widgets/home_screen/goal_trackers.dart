import 'package:flutter/material.dart';
import '../../controllers/goal_tracker_controller.dart';
import '../../services/goal_tracker/goal_tracker_storage.dart';
import './goal_tracker.dart';

class GoalTrackers extends StatefulWidget {
  const GoalTrackers({super.key});

  @override
  State<GoalTrackers> createState() => _GoalTrackersState();
}

class _GoalTrackersState extends State<GoalTrackers>
    with WidgetsBindingObserver {
  final _animatedListKey = GlobalKey<AnimatedListState>();

  void _removeTracker(GoalTrackerController tracker, int index) {
    tracker.dispose();
    _animatedListKey.currentState!.removeItem(
      index,
      (context, animation) => GoalTracker(
        tracker: tracker,
        animation: animation,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder<List<GoalTrackerController>>(
        future: GoalTrackerStorage.fetch(),
        builder:
            (context, AsyncSnapshot<List<GoalTrackerController>> snapshot) {
          if (snapshot.hasData) {
            GoalTrackerStorage.storedTrackers = snapshot.data;
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: AnimatedList(
                    key: _animatedListKey,
                    initialItemCount: snapshot.data!.length,
                    itemBuilder: (context, index, animation) => GoalTracker(
                      tracker: snapshot.data![index],
                      animation: animation,
                      onRemove: (GoalTrackerController tracker) {
                        snapshot.data!.removeAt(index);
                        _removeTracker(tracker, index);
                      },
                    ),
                  ),
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        GoalTrackerStorage.storedTrackers = [
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
                        await GoalTrackerStorage.saveStoredTrackers();
                      },
                      child: const Text("RESET"),
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ),
              ],
            );
          } else {
            return const Expanded(
                child: Center(child: CircularProgressIndicator()));
          }
        },
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
