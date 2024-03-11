import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/timelines_database.dart';
import '../timeline/models/timeline_model.dart';

final timelinesProvider =
    StateNotifierProvider<TimelineController, List<TimelineModel>>(
  (ref) {
    return TimelineController();
  },
);

class TimelineController extends StateNotifier<List<TimelineModel>> {
  TimelineController() : super(TimelinesDatabase.getAll());
}
