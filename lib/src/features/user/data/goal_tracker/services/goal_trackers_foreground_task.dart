import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/goal_tracker_model.dart';
import '../utils/goal_tracker_info_formatter.dart';
import '../utils/goal_trackers_list_helper.dart';
import '../controllers/goal_trackers_controller.dart';
import './goal_trackers_storage.dart';

@pragma('vm:entry-point')
void startTask() {
  FlutterForegroundTask.setTaskHandler(_TaskService());
}

class GoalTrackersForegroundTaskWrapper extends ConsumerWidget {
  static const IOSNotificationOptions _iosNotificationOptions =
      IOSNotificationOptions(
    showNotification: true,
    playSound: false,
  );

  static const ForegroundTaskOptions _foregroundTaskOptions =
      ForegroundTaskOptions(
    interval: 1000,
    allowWakeLock: true,
    autoRunOnBoot: false,
    allowWifiLock: false,
  );

  static AndroidNotificationOptions _createAndroidNotificationOptions(
      List<NotificationButton>? buttons) {
    return AndroidNotificationOptions(
      channelId: "goal_trackers_foreground_task_channel_id",
      channelName: "Goal Trackers Foreground Task Notification",
      channelDescription: 'Appears when the goal tracker is playing.',
      channelImportance: NotificationChannelImportance.LOW,
      priority: NotificationPriority.MAX,
      iconData: const NotificationIconData(
        resType: ResourceType.mipmap,
        resPrefix: ResourcePrefix.img,
        name: 'notification',
      ),
      buttons: buttons,
    );
  }

  final Scaffold scaffold;

  const GoalTrackersForegroundTaskWrapper({
    super.key,
    required this.scaffold,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WillStartForegroundTask(
      onWillStart: () async {
        final goalTrackersController = ref.read(goalTrackersProvider.notifier);
        await goalTrackersController.storeData();

        final goalTrackers = await GoalTrackersStorage().read();

        return goalTrackers.hasPlaying();
      },
      callback: startTask,
      androidNotificationOptions: _createAndroidNotificationOptions([]),
      iosNotificationOptions: _iosNotificationOptions,
      foregroundTaskOptions: _foregroundTaskOptions,
      notificationTitle: "",
      notificationText: "",
      child: scaffold,
    );
  }
}

class _TaskService extends TaskHandler {
  //* Displays information about a playing goal tracker

  late final GoalTrackerModel _model;

  void _update() async {
    await FlutterForegroundTask.updateService(
      notificationTitle: _model.name,
      notificationText: "${GoalTrackerInfoFormatter.playtime(_model)}"
          "${' ' * 4}"
          "(${GoalTrackerInfoFormatter.progressPrecentage(_model)})",
    );
  }

  @override
  Future<void> onStart(DateTime timestamp, SendPort? sendPort) async {
    final goalTrackers = await GoalTrackersStorage().read();
    _model = goalTrackers.thatArePlaying().first;
  }

  @override
  Future<void> onEvent(DateTime timestamp, SendPort? sendPort) async {
    // Updates notification information if still has a playing goal tracker
    _update();
  }

  @override
  Future<void> onDestroy(DateTime timestamp, SendPort? sendPort) async {}
}
