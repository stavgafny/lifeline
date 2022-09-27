import 'dart:isolate';
import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import '../../services/goal_tracker/goal_tracker_storage.dart';
import '../../controllers/goal_tracker_controller.dart';

@pragma('vm:entry-point')
void startTask() {
  FlutterForegroundTask.setTaskHandler(_TaskService());
}

AndroidNotificationOptions _androidNotificationOptions =
    AndroidNotificationOptions(
        channelId: 'notification_channel_id',
        channelName: 'Task Notification',
        channelDescription:
            'This notification appears when the task is running.',
        channelImportance: NotificationChannelImportance.DEFAULT,
        priority: NotificationPriority.HIGH,
        iconData: const NotificationIconData(
          resType: ResourceType.mipmap,
          resPrefix: ResourcePrefix.img,
          name: 'notification',
        ),
        buttons: [
      const NotificationButton(id: 'stop', text: 'Stop'),
    ]);

ForegroundTaskOptions _foregroundTaskOptions = const ForegroundTaskOptions(
  interval: 1000,
  allowWakeLock: false,
  autoRunOnBoot: false,
  allowWifiLock: false,
);

class GoalTrackerNotification {
  GoalTrackerController tracker;
  int playingTrackers;
  GoalTrackerNotification(this.tracker, this.playingTrackers);
}

class GoalTrackerForegroundTask extends StatelessWidget {
  final Scaffold child;

  const GoalTrackerForegroundTask({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return WillStartForegroundTask(
      onWillStart: () async {
        return await GoalTrackerStorage.getNotificationInfo() != null;
      },
      callback: startTask,
      androidNotificationOptions: _androidNotificationOptions,
      foregroundTaskOptions: _foregroundTaskOptions,
      notificationTitle: "",
      notificationText: "",
      child: child,
    );
  }
}

class _TaskService extends TaskHandler {
  //* Displays information about that tracker and the number of playing trackers if there are more then one
  GoalTrackerNotification? _goalTrackerNotification;

  void _killIfNone() async {
    // Kills service if on foreground or goal tracker notification is null
    if (await FlutterForegroundTask.isAppOnForeground ||
        _goalTrackerNotification == null) {
      await FlutterForegroundTask.stopService();
    }
  }

  void _update() async {
    // Updates notification to show latest played tracker information and playing trackers count if there are more
    await FlutterForegroundTask.updateService(
      notificationTitle: _goalTrackerNotification?.tracker.name.toString(),
      notificationText: _goalTrackerNotification?.tracker.toString(),
    );
  }

  @override
  Future<void> onStart(DateTime timestamp, SendPort? sendPort) async {
    _goalTrackerNotification = await GoalTrackerStorage.getNotificationInfo();
  }

  @override
  Future<void> onEvent(DateTime timestamp, SendPort? sendPort) async {
    // Updates notification information if still has a playing tracker
    _killIfNone();
    _update();
  }

  @override
  Future<void> onDestroy(DateTime timestamp, SendPort? sendPort) async {}

  @override
  void onButtonPressed(String id) async {
    if (id == "stop") {
      await GoalTrackerStorage.stopAllTrackers();
      await FlutterForegroundTask.stopService();
    }
  }

  @override
  void onNotificationPressed() {
    FlutterForegroundTask.launchApp();
  }
}
