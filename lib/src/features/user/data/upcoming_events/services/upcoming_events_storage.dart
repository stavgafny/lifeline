import 'dart:convert';

import 'package:lifeline/src/services/local_storage.dart';
import '../models/upcoming_event_model.dart';

class UpcomingEventsStorage extends LocalStorage<List<UpcomingEventModel>> {
  static final UpcomingEventsStorage _instance = UpcomingEventsStorage._();

  UpcomingEventsStorage._()
      : super(
          key: "upcoming-events",
          encode: (List<UpcomingEventModel> models) {
            return json.encode(models.map((model) => model.toJson()).toList());
          },
          decode: (String jsonData) {
            final jsonModels = json.decode(jsonData) as List<dynamic>;
            final models = <UpcomingEventModel>[];
            for (final jsonModel in jsonModels) {
              models.add(UpcomingEventModel.fromJson(jsonModel));
            }
            return models;
          },
          defaultValue: [],
        );

  static Future<List<UpcomingEventModel>> read() {
    return _instance.$read();
  }

  static Future<bool> store(List<UpcomingEventModel> data) {
    return _instance.$store(data);
  }
}
