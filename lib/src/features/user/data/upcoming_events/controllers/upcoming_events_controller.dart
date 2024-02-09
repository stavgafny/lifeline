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

  List<UpcomingEventModel> get _asModels {
    final data = state.value ?? [];
    return data.map((p) => ref.read(p)).toList();
  }

  void _setData(List<UpcomingEventProvider> data) {
    state = AsyncValue.data(data);
    UpcomingEventsStorage.store(_asModels);
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
    if (data.remove(upcomingEvent)) _setData(data);
  }

  int indexOf(UpcomingEventProvider upcomingEvent) {
    if (!_hasData) return -1;
    return state.value!.indexOf(upcomingEvent);
  }

  void insert(UpcomingEventProvider upcomingEvent, int index) {
    if (!_hasData) return;
    final data = [...state.value!];
    if (data.contains(upcomingEvent)) return;
    data.insert(index, upcomingEvent);
    _setData(data);
  }

  /// Inserting in an index based on its date
  void autoInsert(UpcomingEventProvider upcomingEvent) {
    if (!_hasData) return;

    final insertIndex = _getInsertIndex(ref.read(upcomingEvent), _asModels);
    insert(upcomingEvent, insertIndex);
  }

  void update(UpcomingEventProvider upcomingEvent) {
    if (!_hasData) return;
    remove(upcomingEvent);
    autoInsert(upcomingEvent);
  }
}

UpcomingEventProvider _createProvider(UpcomingEventModel model) {
  return UpcomingEventProvider((ref) => UpcomingEventController(model));
}

List<UpcomingEventProvider> _createProviders(List<UpcomingEventModel> models) {
  return models.map((model) => _createProvider(model)).toList();
}

int _getInsertIndex(UpcomingEventModel model, List<UpcomingEventModel> models) {
  for (int i = 0; i < models.length; i++) {
    if (model.dateTime.isBefore(models[i].dateTime) && model != models[i]) {
      return i;
    }
  }
  return models.length;
}
