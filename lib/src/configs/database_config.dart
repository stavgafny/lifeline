import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lifeline/src/features/user/data/timelines/services/timelines_database.dart';
import 'package:lifeline/src/features/user/data/upcoming_events/services/upcoming_events_database.dart';
import 'package:path_provider/path_provider.dart';

class _DatabaseConfig {
  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Setting DB storage directory
    final dbDirectory = await getApplicationDocumentsDirectory();
    Hive.defaultDirectory = dbDirectory.path;

    // Registering adapters on all DB implementations
    TimelinesDatabase.registerAdapters();
    UpcomingEventsDatabase.registerAdapters();
  }
}

final databaseConfig = _DatabaseConfig();
