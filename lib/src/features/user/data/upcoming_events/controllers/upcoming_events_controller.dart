import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/upcoming_event_model.dart';
import '../models/upcoming_event_type.dart';

final upcomingEventsProvider = StateNotifierProvider.autoDispose<
    UpcomingEventsController, AsyncValue<List<UpcomingEventModel>>>((ref) {
  ref.maintainState = true;
  return UpcomingEventsController();
});

class UpcomingEventsController
    extends StateNotifier<AsyncValue<List<UpcomingEventModel>>> {
  UpcomingEventsController() : super(const AsyncValue.loading()) {
    _loadUpcomingEvents();
  }

  bool get _hasData => state.value != null;

  void _setData(List<UpcomingEventModel> data) {
    state = AsyncValue.data(data);
  }

  Future<void> _loadUpcomingEvents() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final upcomingEvents = await _dummyFetch();
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

Future<List<UpcomingEventModel>> _dummyFetch() async {
  return [
    UpcomingEventModel(
      name: "example1",
      type: UpcomingEventType.birthday,
      date: DateTime.now(),
      details: "",
    ),
    UpcomingEventModel(
      name: "example2",
      type: UpcomingEventType.celebration,
      date: DateTime.now(),
      details: "",
    ),
    UpcomingEventModel(
      name: "example3",
      type: UpcomingEventType.movie,
      date: DateTime.now(),
      details: "",
    ),
    UpcomingEventModel(
      name: "example4",
      type: UpcomingEventType.groceries,
      date: DateTime.now(),
      details: "",
    ),
  ];
}
