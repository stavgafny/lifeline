import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../utils/playable_duration.dart';
import '../models/goal_tracker_model.dart';
import '../models/goal_trackers.dart';
import './goal_tracker_controller.dart';

final goalTrackersProvider =
    StateNotifierProvider<GoalTrackersController, GoalTrackers>(
  (ref) {
    final controller = GoalTrackersController(
      GoalTrackers(
        selectedID: -1,
        providers: [
          const GoalTrackerModel(
            name: "A",
            duration: Duration(hours: 1),
            progress: PlayableDuration.paused(duration: Duration()),
          ),
          GoalTrackerModel(
            name: "B",
            duration: const Duration(hours: 1),
            progress: PlayableDuration.playing(
              timestamp: DateTime.now().subtract(const Duration(minutes: 1)),
            ),
          ),
        ]
            .map((model) =>
                GoalTrackerProvider((ref) => GoalTrackerController(model)))
            .toList(),
      ),
    );

    ref.onDispose(() {
      final providers = controller._providers;
      // final models = providers.map((p) => ref.read(p)).toList();
      for (final provider in providers) {
        ref.read(provider.notifier).dispose();
      }
    });

    return controller;
  },
);

class GoalTrackersController extends StateNotifier<GoalTrackers> {
  GoalTrackersController(GoalTrackers goalTrackers) : super(goalTrackers);

  List<GoalTrackerProvider> get _providers => state.providers;

  void swap(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex--;
    final current = state.providers;
    current.insert(newIndex, current.removeAt(oldIndex));
    state = state.copyWith(providers: current);
  }

  void remove(GoalTrackerProvider provider) {
    state = state.copyWith(providers: [
      for (final p in state.providers)
        if (p != provider) p,
    ]);
  }
}
