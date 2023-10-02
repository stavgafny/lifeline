import 'dart:convert';

import 'package:lifeline/src/services/local_storage.dart';
import '../models/goal_tracker_model.dart';

class GoalTrackersStorage extends LocalStorage<List<GoalTrackerModel>> {
  static final GoalTrackersStorage _instance = GoalTrackersStorage._();

  GoalTrackersStorage._()
      : super(
          key: "goal-trackers",
          encode: (List<GoalTrackerModel> models) {
            return json.encode(models.map((model) => model.toJson()).toList());
          },
          decode: (String jsonData) {
            final jsonModels = json.decode(jsonData) as List<dynamic>;
            final models = <GoalTrackerModel>[];
            for (final jsonModel in jsonModels) {
              models.add(GoalTrackerModel.fromJson(jsonModel));
            }
            return models;
          },
          defaultValue: [],
        );

  factory GoalTrackersStorage() => _instance;
}
