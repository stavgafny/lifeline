import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/upcoming_event_model.dart';
import '../services/upcoming_events_storage.dart';
import './upcoming_event_controller.dart';

final upcomingEventsProvider = StateNotifierProvider<UpcomingEventsController,
        AsyncValue<List<UpcomingEventProvider>>>(
    (ref) => UpcomingEventsController(ref));

class UpcomingEventsController
    extends StateNotifier<AsyncValue<List<UpcomingEventProvider>>> {
  final Ref ref;

  UpcomingEventsController(this.ref) : super(const AsyncValue.loading()) {
    _loadUpcomingEvents();
  }

  bool get _hasData => state.value != null;

  void _setData(List<UpcomingEventProvider> data) {
    state = AsyncValue.data(data);
  }

  Future<bool> storeData() async {
    if (!_hasData) return false;
    final data = state.value!;
    return UpcomingEventsStorage.store(data.map((p) => ref.read(p)).toList());
  }

  Future<void> _loadUpcomingEvents() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final upcomingEvents = await UpcomingEventsStorage.read();
      return _createProviders(upcomingEvents);
    });
  }

  void swap(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex--;
    if (!_hasData) return;
    final current = state.value!;
    current.insert(newIndex, current.removeAt(oldIndex));
    _setData(current);
  }

  void remove(UpcomingEventProvider upcomingEvent) {
    if (!_hasData) return;
    final data = state.value!;
    data.remove(upcomingEvent);
    _setData(data);
  }
}

UpcomingEventProvider _createProvider(UpcomingEventModel model) {
  return UpcomingEventProvider((ref) => UpcomingEventController(model));
}

List<UpcomingEventProvider> _createProviders(List<UpcomingEventModel> models) {
  return models.map((model) => _createProvider(model)).toList();
}
