import '../timeline/models/timeline_model.dart';

extension TimelinesListExtension on List<TimelineModel> {
  void sortByTimelineName({bool descending = false}) {
    descending
        ? sort((t1, t2) => t2.name.compareTo(t1.name))
        : sort((t1, t2) => t1.name.compareTo(t2.name));
  }
}
