import 'dart:async';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeline/src/utils/global_time.dart';
import '../models/upcoming_event_model.dart';
import '../services/upcoming_events_database.dart';
import './upcoming_event_controller.dart';

part './upcoming_events_undo_controller.dart';

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
    final data = [...state];
    if (UpcomingEventsController._autoSort) {
      data.remove(upcomingEvent);
      index = _getAutoSortInsertIndex(_ref.read(upcomingEvent), _asModels);
    }
    if (!data.contains(upcomingEvent)) {
      data.insert(min(index, data.length), upcomingEvent);
      state = [...data];
      _updateDB();
    }
  }

  void remove(UpcomingEventProvider upcomingEvent) {
    final data = [...state];
    if (data.remove(upcomingEvent)) {
      final undo = UndoData(
        provider: _createProvider(_ref.read(upcomingEvent)),
        index: state.indexOf(upcomingEvent),
      );
      _ref.read(upcomingEventsUndoProvider.notifier)._setUndo(undo);
      state = data;
      _updateDB();
    }
  }

  void insert(UpcomingEventProvider upcomingEvent, int index) {
    final data = [...state];

    if (data.contains(upcomingEvent)) return;
    data.insert(index, upcomingEvent);
    state = [...data];
    _updateDB();
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
