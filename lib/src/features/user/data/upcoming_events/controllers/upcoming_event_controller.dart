import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/upcoming_event_model.dart';

typedef UpcomingEventProvider = AutoDisposeStateNotifierProvider<
    UpcomingEventController, UpcomingEventModel>;

class UpcomingEventController extends StateNotifier<UpcomingEventModel> {
  UpcomingEventController(super.model);

  void _update({
    String? name,
    DateTime? dateTime,
    UpcomingEventType? type,
    String? details,
  }) {
    state = state.copyWith(
      name: name,
      dateTime: dateTime,
      type: type,
      details: details,
    );
  }

  void setType({required UpcomingEventType type}) => _update(type: type);
  void setName({required String name}) => _update(name: name);
  void setDatetime({required DateTime dateTime}) => _update(dateTime: dateTime);
  void setDetails({required String details}) => _update(details: details);
  void update(UpcomingEventModel model) => state = model;
}
