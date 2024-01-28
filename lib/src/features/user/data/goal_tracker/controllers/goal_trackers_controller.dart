import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/goal_tracker_model.dart';
import '../services/goal_trackers_storage.dart';
import './goal_tracker_controller.dart';

final goalTrackersProvider = StateNotifierProvider.autoDispose<
        GoalTrackersController, AsyncValue<List<GoalTrackerProvider>>>(
    (ref) => GoalTrackersController(ref: ref));

class GoalTrackersController
    extends StateNotifier<AsyncValue<List<GoalTrackerProvider>>> {
  final Ref ref;

  GoalTrackersController({required this.ref})
      : super(const AsyncValue.loading()) {
    _loadGoalTrackers();
  }

  bool get _hasData => state.value != null;

  void _setData(List<GoalTrackerProvider> data) {
    state = AsyncValue.data(data);
  }

  Future<void> _loadGoalTrackers() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final models = await GoalTrackersStorage().read();
      return _createProviders(models);
    });
  }

  Future<bool> storeData() async {
    if (!_hasData) return false;
    final data = state.value!;
    return GoalTrackersStorage().store(data.map((p) => ref.read(p)).toList());
  }

  void swap(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex--;
    if (!_hasData) return;
    final current = state.value!;
    current.insert(newIndex, current.removeAt(oldIndex));
    _setData(current);
  }

  GoalTrackerProvider? create(GoalTrackerModel model) {
    if (!_hasData) return null;
    final goalTrackerProvider = _createProvider(model);
    _setData([goalTrackerProvider, ...state.value!]);
    return goalTrackerProvider;
  }

  void insert(GoalTrackerProvider provider, int index) {
    if (!_hasData) return;
    final data = [...state.value!];
    data.insert(index, provider);
    _setData(data);
  }

  void remove(GoalTrackerProvider provider) {
    if (!_hasData) return;
    _setData([
      for (final p in state.value!)
        if (p != provider) p,
    ]);
  }

  int indexOf(GoalTrackerProvider provider) {
    if (!_hasData) return -1;
    return state.value!.indexOf(provider);
  }

  @override
  void dispose() {
    storeData();
    super.dispose();
  }
}

GoalTrackerProvider _createProvider(GoalTrackerModel model) {
  return GoalTrackerProvider((ref) => GoalTrackerController(model));
}

List<GoalTrackerProvider> _createProviders(List<GoalTrackerModel> models) {
  return models.map((model) => _createProvider(model)).toList();
}
