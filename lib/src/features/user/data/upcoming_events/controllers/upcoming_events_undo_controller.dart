part of './upcoming_events_controller.dart';

final upcomingEventsUndoProvider =
    StateNotifierProvider<UpcomingEventsUndoController, UndoData?>(
  (ref) => UpcomingEventsUndoController(ref),
);

class UndoData {
  final UpcomingEventProvider provider;
  final int index;

  UndoData({required this.provider, required this.index});
}

class UpcomingEventsUndoController extends StateNotifier<UndoData?> {
  final Ref _ref;

  UpcomingEventsUndoController(this._ref) : super(null);

  void _setUndo(UndoData undoData) {
    state = undoData;
  }

  void onUndoPressed(bool undoPressed) {
    if (state != null && undoPressed) {
      final undoData = state!;
      _ref
          .read(upcomingEventsProvider.notifier)
          .insert(undoData.provider, undoData.index);
    }
    state = null;
  }
}
