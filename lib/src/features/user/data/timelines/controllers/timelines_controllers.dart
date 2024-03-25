import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/timelines_database.dart';
import '../timeline/models/timeline_model.dart';

final timelinesProvider =
    StateNotifierProvider.autoDispose<TimelinesController, List<TimelineModel>>(
  (ref) => TimelinesController(),
);

class TimelinesController extends StateNotifier<List<TimelineModel>> {
  TimelinesController() : super(TimelinesDatabase.getAll());

  void _refreshFromDB() => state = TimelinesDatabase.getAll();

  bool nameExists(String name) {
    return TimelinesDatabase.exists(name);
  }

  void rename({required String from, required String to}) {
    final renamed = TimelinesDatabase.rename(from, to);
    if (renamed) _refreshFromDB();
  }

  void delete(String name) {
    final deleted = TimelinesDatabase.delete(name);
    if (deleted) _refreshFromDB();
  }

  void updateTimeline(TimelineModel timeline) {
    TimelinesDatabase.store(timeline.copyWith(lastModified: DateTime.now()));
  }

  TimelineModel? createTimeline(TimelineCreateModel createModel) {
    if (createModel.name.isEmpty ||
        nameExists(createModel.name) ||
        createModel.template.isEmpty) {
      return null;
    }
    final timeline = TimelineModel.create(createModel);
    updateTimeline(timeline);
    _refreshFromDB();
    return timeline;
  }

  String getSuggestedNewName() {
    int index = state.length;
    String timelineName;
    do {
      timelineName = "${(++index).toString().padLeft(2, '0')}. My Timeline";
    } while (nameExists(timelineName));

    return timelineName;
  }

  TimelineModel? getTimelineByName(String name) {
    for (final timeline in state) {
      if (timeline.name == name) {
        return timeline;
      }
    }
    return null;
  }
}
