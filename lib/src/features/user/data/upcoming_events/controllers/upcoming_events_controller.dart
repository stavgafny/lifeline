import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/upcoming_event_model.dart';
import '../services/upcoming_events_storage.dart';

final upcomingEventsProvider = StateNotifierProvider<UpcomingEventsController,
    AsyncValue<List<UpcomingEventModel>>>((ref) => UpcomingEventsController());

class UpcomingEventsController
    extends StateNotifier<AsyncValue<List<UpcomingEventModel>>> {
  UpcomingEventsController() : super(const AsyncValue.loading()) {
    _loadUpcomingEvents();
  }

  bool get _hasData => state.value != null;

  void _setData(List<UpcomingEventModel> data) {
    state = AsyncValue.data(data);
    UpcomingEventsStorage.store(data);
  }

  Future<void> _loadUpcomingEvents() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final upcomingEvents = await UpcomingEventsStorage.read();
      return upcomingEvents;
    });
  }

  void swap(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex--;
    if (!_hasData) return;
    final current = state.value!;
    current.insert(newIndex, current.removeAt(oldIndex));
    _setData(current);
  }
}
