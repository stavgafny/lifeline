import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/upcoming_event_model.dart';
import '../services/upcoming_events_storage.dart';
import './upcoming_event_controller.dart';

final upcomingEventsProvider = StateNotifierProvider<UpcomingEventsController,
        AsyncValue<List<UpcomingEventProvider>>>(
    (ref) => UpcomingEventsController(ref));

class UpcomingEventsController
    extends StateNotifier<AsyncValue<List<UpcomingEventProvider>>> {
  static const bool _autoSort = true;

  final Ref ref;

  UpcomingEventsController(this.ref) : super(const AsyncValue.loading()) {
    _loadUpcomingEvents();
  }

  bool get _hasData => state.value != null;

  List<UpcomingEventModel> _asModels(List<UpcomingEventProvider> data) {
    return data.map((p) => ref.read(p)).toList();
  }

  void _setData(List<UpcomingEventProvider> data) {
    state = AsyncValue.data(data);
    UpcomingEventsStorage.store(_asModels(state.value!));
  }

  Future<void> _loadUpcomingEvents() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final upcomingEvents = await UpcomingEventsStorage.read();
      return _createProviders(upcomingEvents);
    });
  }

  int indexOf(UpcomingEventProvider upcomingEvent) {
    if (!_hasData) return -1;
    return state.value!.indexOf(upcomingEvent);
  }

  void swap(int oldIndex, int newIndex) {
    if (!_hasData) return;
    final data = state.value!;
    if (newIndex > oldIndex) newIndex--;
    data.insert(newIndex, data.removeAt(oldIndex));
    _setData(data);
  }

  void remove(UpcomingEventProvider upcomingEvent) {
    if (!_hasData) return;
    final data = state.value!;
    if (data.remove(upcomingEvent)) _setData(data);
  }

  void insert(UpcomingEventProvider upcomingEvent, int index) {
    if (!_hasData) return;
    final data = state.value!;
    if (data.contains(upcomingEvent)) return;
    data.insert(index, upcomingEvent);
    _setData(data);
  }

  void updateItemChange(UpcomingEventProvider upcomingEvent) {
    if (!_hasData) return;
    final data = state.value!;
    int index = 0;
    if (UpcomingEventsController._autoSort) {
      data.remove(upcomingEvent);
      index = _getAutoSortInsertIndex(ref.read(upcomingEvent), _asModels(data));
    }
    if (!data.contains(upcomingEvent)) data.insert(index, upcomingEvent);
    _setData(data);
  }
}

UpcomingEventProvider _createProvider(UpcomingEventModel model) {
  return UpcomingEventProvider((ref) => UpcomingEventController(model));
}

List<UpcomingEventProvider> _createProviders(List<UpcomingEventModel> models) {
  return models.map((model) => _createProvider(model)).toList();
}

int _getAutoSortInsertIndex(
    UpcomingEventModel model, List<UpcomingEventModel> models) {
  for (int i = 0; i < models.length; i++) {
    if (model.dateTime.isBefore(models[i].dateTime) && model != models[i]) {
      return i;
    }
  }
  return models.length;
}
