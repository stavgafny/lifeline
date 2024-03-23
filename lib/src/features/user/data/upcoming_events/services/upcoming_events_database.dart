import 'package:hive/hive.dart';
import '../models/upcoming_event_model.dart';

class UpcomingEventsDatabase {
  static const String _dbName = "upcoming-events";
  static final _db = Hive.box<UpcomingEventModel>(name: _dbName);

  static void registerAdapters() {
    Hive.registerAdapter('UE-UpcomingEventsType', UpcomingEventType.fromJson);
    Hive.registerAdapter('UE-UpcomingEventModel', UpcomingEventModel.fromJson);
  }

  static void clear() => _db.clear();

  static List<UpcomingEventModel> get() => _db.getRange(0, _db.length);

  static void set(List<UpcomingEventModel> models) {
    clear();
    _db.addAll(models);
  }

  static void swap(int oldIndex, int newIndex) {
    _db.write(() {
      final oldModel = _db.getAt(oldIndex);
      final newModel = _db.getAt(newIndex);
      _db.putAt(oldIndex, newModel);
      _db.putAt(newIndex, oldModel);
    });
  }
}
