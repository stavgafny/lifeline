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

  void _saveTrackers(List<GoalTrackerController> trackers) {
    GoalTrackerStorage.save(trackers);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          FutureBuilder<List<GoalTrackerController>>(
              future: GoalTrackerStorage.fetch(),
              builder: (context,
                  AsyncSnapshot<List<GoalTrackerController>> snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: AnimatedList(
                      key: _animatedListKey,
                      initialItemCount: snapshot.data!.length,
                      itemBuilder: (context, index, animation) => GoalTracker(
                        tracker: snapshot.data![index],
                        animation: animation,
                        onChange: () => _saveTrackers(snapshot.data!),
                        onRemove: (GoalTrackerController tracker) {
                          snapshot.data!.removeAt(index);
                          _removeTracker(tracker, index);
                          _saveTrackers(snapshot.data!);
                        },
                      ),
                    ),
                  );
                } else {
                  return const Expanded(
                      child: Center(child: CircularProgressIndicator()));
                }
              }),
          ElevatedButton(
            onPressed: () {
              GoalTrackerStorage.save([
                GoalTrackerController(
                  name: "Read this is a very long as text",
                  duration: const Duration(hours: 3),
                  progress: const Duration(hours: 2, minutes: 13),
                  playing: false,
                  deadline: Deadline(
                    date: Deadline.getNextDate(DeadlineRoutine.daily),
                    routine: DeadlineRoutine.daily,
                  ),
                ),
                GoalTrackerController(
                  name: "Code",
                  duration: const Duration(hours: 2, minutes: 30),
                  progress: const Duration(),
                  playing: false,
                  deadline: Deadline(
                    date: Deadline.getNextDate(DeadlineRoutine.weekly),
                    routine: DeadlineRoutine.weekly,
                  ),
                ),
                GoalTrackerController(
                  name: "Play",
                  duration: const Duration(minutes: 30),
                  progress: const Duration(),
                  playing: false,
                  deadline: Deadline(
                    date: Deadline.getNextDate(DeadlineRoutine.monthly),
                    routine: DeadlineRoutine.monthly,
                  ),
                ),
              ]);
            },
            child: const Text("RESET"),
          ),
          const SizedBox(height: 40.0),
        ],
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
