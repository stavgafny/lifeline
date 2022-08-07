import '../../controllers/habit_tracker_controller.dart';

enum HabitTrackerEvent {
  name,
  progress,
  duration,
  deadline,
  remove,
}

class HabitTrackerStorage {
  static void emitChange(
      HabitTrackerController tracker, HabitTrackerEvent event) {
    switch (event) {
      case HabitTrackerEvent.name:
        return;
      case HabitTrackerEvent.progress:
        return;
      case HabitTrackerEvent.duration:
        return;
      case HabitTrackerEvent.deadline:
        return;
      case HabitTrackerEvent.remove:
        trackers.remove(tracker);
        return;
    }
  }

  static final trackers = <HabitTrackerController>[
    HabitTrackerController(
      name: "[TEST]",
      duration: const Duration(seconds: 10),
      progress: const Duration(seconds: 2),
      playing: false,
      deadline: Deadline(
        date: DateTime.now().subtract(const Duration(seconds: 10)),
        routine: DeadlineRoutine.test,
      ),
    ),
    HabitTrackerController(
      name: "Read this is a very long as text",
      duration: const Duration(hours: 3),
      progress: const Duration(hours: 2, minutes: 13),
      playing: false,
      deadline: Deadline(
        date: Deadline.getNextDate(DeadlineRoutine.daily),
        routine: DeadlineRoutine.daily,
      ),
    ),
    HabitTrackerController(
      name: "Code",
      duration: const Duration(hours: 2, minutes: 30),
      progress: const Duration(),
      playing: false,
      deadline: Deadline(
          date: Deadline.getNextDate(DeadlineRoutine.weekly),
          routine: DeadlineRoutine.weekly),
    ),
    HabitTrackerController(
      name: "Play",
      duration: const Duration(minutes: 30),
      progress: const Duration(),
      playing: false,
      deadline: Deadline(
        date: Deadline.getNextDate(DeadlineRoutine.monthly),
        routine: DeadlineRoutine.monthly,
      ),
    ),
  ];
}
