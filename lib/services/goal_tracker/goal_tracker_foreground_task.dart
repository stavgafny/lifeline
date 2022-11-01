import 'dart:isolate';
import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import '../../services/goal_tracker/goal_tracker_storage.dart';
import '../../controllers/goal_tracker_controller.dart';

@pragma('vm:entry-point')
void startTask() {
  FlutterForegroundTask.setTaskHandler(_TaskService());
}

class GoalTrackerNotification {
  GoalTrackerController tracker;
  int playingTrackers;
  GoalTrackerNotification(this.tracker, this.playingTrackers);
}

class GoalTrackerForegroundTask extends StatelessWidget {
  final Scaffold child;

  static final List<NotificationButton> _notificationButtons = [];

  const GoalTrackerForegroundTask({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return WillStartForegroundTask(
      onWillStart: () async {
        // Save stored trackers on app every lifecycle change (resume/minimized/closed)
        await GoalTrackerStorage.saveStoredTrackers();

        // Show notification if at least 1 tracker is currently playing
        final notificationInfo = await GoalTrackerStorage.getNotificationInfo();
        if (notificationInfo == null) return false;
        _notificationButtons.clear();
        _notificationButtons.add(
          NotificationButton(
            id: "stop",
            text: "Stop${notificationInfo.playingTrackers > 1 ? ' All' : ''}",
          ),
        );

        return true;
      },
      callback: startTask,
      androidNotificationOptions: AndroidNotificationOptions(
        channelId: 'notification_channel_id',
        channelName: 'Task Notification',
        channelDescription:
            'This notification appears when the task is running.',
        channelImportance: NotificationChannelImportance.LOW,
        priority: NotificationPriority.MAX,
        iconData: const NotificationIconData(
          resType: ResourceType.mipmap,
          resPrefix: ResourcePrefix.img,
          name: 'notification',
        ),
        buttons: _notificationButtons,
      ),
      iosNotificationOptions: const IOSNotificationOptions(
        showNotification: true,
        playSound: false,
      ),
      foregroundTaskOptions: const ForegroundTaskOptions(
        interval: 1000,
        allowWakeLock: true,
        autoRunOnBoot: false,
        allowWifiLock: false,
      ),
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
    final playingTrackers = _goalTrackerNotification?.playingTrackers ?? 0;
    final otherTrackers = playingTrackers > 1
        ? "\r\n(+${playingTrackers - 1} Tracker${playingTrackers - 1 > 1 ? 's' : ''})"
        : "";
    await FlutterForegroundTask.updateService(
      notificationTitle: _goalTrackerNotification?.tracker.name.value,
      notificationText: "${_goalTrackerNotification?.tracker.toString()}"
          "${' ' * 2}"
          "(${_goalTrackerNotification?.tracker.precentFormat})"
          "${' ' * 2}"
          "$otherTrackers",
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

  // @override
  // void onNotificationPressed() {
  //   FlutterForegroundTask.launchApp();
  // }
}
