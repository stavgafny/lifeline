import '../controllers/goal_tracker_controller.dart';

class GoalTrackers {
  final int selectedID;
  final List<GoalTrackerProvider> providers;
  GoalTrackers({
    required this.selectedID,
    required this.providers,
  });

  GoalTrackers copyWith({
    int? selectedID,
    List<GoalTrackerProvider>? providers,
  }) {
    return GoalTrackers(
      selectedID: selectedID ?? this.selectedID,
      providers: providers ?? this.providers,
    );
  }
}
