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
  static const bool _autoSort = true;

  final Ref _ref;

  StreamSubscription<void>? _midnightListener;

  UpcomingEventsController(this._ref) : super([]) {
    _loadUpcomingEvents();
    _updateOnMidnight();
  }

  List<UpcomingEventModel> get _asModels =>
      state.map((ue) => _ref.read(ue)).toList();

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

  void _updateDB() => UpcomingEventsDatabase.set(_asModels);

  void swap(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex--;
    state.insert(newIndex, state.removeAt(oldIndex));
    UpcomingEventsDatabase.swap(oldIndex, newIndex);
    _ref.notifyListeners();
  }

  void updateItemChange(UpcomingEventProvider upcomingEvent) {
    int index = 0;
    if (UpcomingEventsController._autoSort) {
      state.remove(upcomingEvent);
      index = _getAutoSortInsertIndex(_ref.read(upcomingEvent), _asModels);
    }
    if (!state.contains(upcomingEvent)) state.insert(index, upcomingEvent);
    _ref.notifyListeners();
    _updateDB();
  }

  void remove(UpcomingEventProvider upcomingEvent) {
    if (state.remove(upcomingEvent)) {
      _ref.notifyListeners();
      _updateDB();
    }
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

int _getAutoSortInsertIndex(
    UpcomingEventModel model, List<UpcomingEventModel> models) {
  for (int i = 0; i < models.length; i++) {
    if (model.dateTime.isBefore(models[i].dateTime) && model != models[i]) {
      return i;
    }
  }
  return models.length;
}
