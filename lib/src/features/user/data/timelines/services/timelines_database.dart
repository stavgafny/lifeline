import 'package:hive/hive.dart';
import '../timeline/entries/entry/input_fields/core/input_field_model.dart';
import '../timeline/entries/entry/models/entry_model.dart';
import '../timeline/models/timeline_model.dart';

class TimelinesDatabase {
  static const String _dbName = "timelines";
  static final _db = Hive.box<TimelineModel>(name: _dbName);

  static void registerAdapters() {
    Hive.registerAdapter('Timelines-InputField', InputFieldModel.fromJson);
    Hive.registerAdapter('Timelines-Entry', EntryModel.fromJson);
    Hive.registerAdapter('Timelines-Timeline', TimelineModel.fromJson);
  }

  static void clear() => _db.clear();

  static TimelineModel? get(String name) => _db.get(name);

  static void store(TimelineModel timeline) {
    _db.put(timeline.name, timeline);
  }

  static List<TimelineModel> getAll() {
    return _db.getAll(_db.keys).nonNulls.toList();
  }

  static bool exists(String name) => _db.containsKey(name);
}
