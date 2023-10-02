import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/goal_tracker_model.dart';
import '../models/goal_trackers.dart';
import '../services/goal_trackers_storage.dart';
import './goal_tracker_controller.dart';

final goalTrackersProvider = StateNotifierProvider.autoDispose<
    GoalTrackersController, AsyncValue<GoalTrackers>>(
  (ref) {
    final controller = GoalTrackersController();

    ref.onDispose(() {
      final providers = controller._providers;
      final models = providers.map((p) => ref.read(p)).toList();
      for (final provider in providers) {
        ref.read(provider.notifier).dispose();
      }
      GoalTrackersStorage().store(models);
    });

    return controller;
  },
);

class GoalTrackersController extends StateNotifier<AsyncValue<GoalTrackers>> {
  GoalTrackersController() : super(const AsyncValue.loading()) {
    _loadGoalTrackers();
  }

  List<GoalTrackerProvider> get _providers => state.value?.providers ?? [];

  Future<void> _loadGoalTrackers() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final models = await GoalTrackersStorage().read();
      return GoalTrackers(
        selectedID: -1,
        providers: _createProviders(models),
      );
    });
  }

  void swap(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex--;
    if (state.value == null) return;
    final current = state.value!.providers;
    current.insert(newIndex, current.removeAt(oldIndex));
    state = AsyncValue.data(state.value!.copyWith(providers: current));
  }

  void remove(GoalTrackerProvider provider) {
    if (state.value == null) return;
    state = AsyncValue.data(state.value!.copyWith(providers: [
      for (final p in state.value!.providers)
        if (p != provider) p,
    ]));
  }
}

List<GoalTrackerProvider> _createProviders(List<GoalTrackerModel> models) {
  return models
      .map(
        (model) => GoalTrackerProvider(
          (ref) => GoalTrackerController(model),
        ),
      )
      .toList();
}
