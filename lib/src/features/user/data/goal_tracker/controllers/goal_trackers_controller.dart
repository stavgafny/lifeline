import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/goal_tracker_model.dart';
import '../services/goal_trackers_storage.dart';
import './goal_tracker_controller.dart';

final goalTrackersProvider = StateNotifierProvider.autoDispose<
    GoalTrackersController, AsyncValue<List<GoalTrackerProvider>>>(
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

class GoalTrackersController
    extends StateNotifier<AsyncValue<List<GoalTrackerProvider>>> {
  GoalTrackersController() : super(const AsyncValue.loading()) {
    _loadGoalTrackers();
  }

  List<GoalTrackerProvider> get _providers => state.value ?? [];

  Future<void> _loadGoalTrackers() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final models = await GoalTrackersStorage().read();
      return _createProviders(models);
    });
  }

  void swap(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex--;
    if (state.value == null) return;
    final current = state.value!;
    current.insert(newIndex, current.removeAt(oldIndex));
    state = AsyncValue.data(current);
  }

  void add(GoalTrackerModel model) {
    if (state.value == null) return;
    state = AsyncValue.data([...state.value!, _createProvider(model)]);
  }

  void remove(GoalTrackerProvider provider) {
    if (state.value == null) return;
    state = AsyncValue.data([
      for (final p in state.value!)
        if (p != provider) p,
    ]);
  }
}

GoalTrackerProvider _createProvider(GoalTrackerModel model) {
  return GoalTrackerProvider((ref) => GoalTrackerController(model));
}

List<GoalTrackerProvider> _createProviders(List<GoalTrackerModel> models) {
  return models.map((model) => _createProvider(model)).toList();
}
