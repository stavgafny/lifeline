import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeline/src/utils/global_time.dart';
import '../models/upcoming_event_model.dart';
import '../services/upcoming_events_database.dart';
import './upcoming_event_controller.dart';

final upcomingEventsProvider =
    StateNotifierProvider<UpcomingEventsController, UpcomingEvents>(
  (ref) => UpcomingEventsController(ref),
);

typedef UpcomingEvents = List<UpcomingEventProvider>;

class UpcomingEventsController extends StateNotifier<UpcomingEvents> {
  // static const bool _autoSort = true;

  final Ref _ref;

  StreamSubscription<void>? _midnightListener;

  UpcomingEventsController(this._ref) : super([]) {
    _loadUpcomingEvents();
    _updateOnMidnight();
  }

  void _loadUpcomingEvents() {
    final models = UpcomingEventsDatabase.get();
    state = _createProviders(models);
  }

  void _updateOnMidnight() {
    _midnightListener = GlobalTime.atMidnight().listen((_) {
      if (mounted) {
        _ref.notifyListeners();
      }
    });
  }

  // void _updateDB() {
  //   UpcomingEventsDatabase.set(
  //     [for (final upcomingEvent in state) ref.read(upcomingEvent)],
  //   );
  // }

  void swap(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex--;
    state.insert(newIndex, state.removeAt(oldIndex));
    UpcomingEventsDatabase.swap(oldIndex, newIndex);
    _ref.notifyListeners();
  }

  @override
  void dispose() {
    _midnightListener?.cancel();
    super.dispose();
  }
}

UpcomingEventProvider _createProvider(UpcomingEventModel model) {
  return UpcomingEventProvider((ref) => UpcomingEventController(model));
}

List<UpcomingEventProvider> _createProviders(List<UpcomingEventModel> models) {
  return models.map((model) => _createProvider(model)).toList();
}
