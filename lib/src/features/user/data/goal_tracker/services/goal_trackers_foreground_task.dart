import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../utils/goal_trackers_list_helper.dart';
import '../controllers/goal_trackers_controller.dart';
import '../utils/goal_trackers_notification.dart';
import './goal_trackers_storage.dart';

@pragma('vm:entry-point')
void startTask() {
  FlutterForegroundTask.setTaskHandler(_TaskService());
}

class GoalTrackersForegroundTaskWrapper extends ConsumerWidget {
  static const _stopButtonID = "@stop";

  static const _iosNotificationOptions = IOSNotificationOptions(
    showNotification: true,
    playSound: false,
  );

  static const _foregroundTaskOptions = ForegroundTaskOptions(
    interval: 1000,
    allowWakeLock: true,
    autoRunOnBoot: false,
    allowWifiLock: false,
  );

  static final _androidNotificationOptions = AndroidNotificationOptions(
    channelId: "goal_trackers_foreground_task_channel_id",
    channelName: "Goal Trackers Foreground Task Notification",
    channelDescription: 'Appears when the goal tracker is playing.',
    channelImportance: NotificationChannelImportance.DEFAULT,
    priority: NotificationPriority.HIGH,
    playSound: false,
    isSticky: true,
    iconData: const NotificationIconData(
      resType: ResourceType.mipmap,
      resPrefix: ResourcePrefix.img,
      name: 'notification',
    ),
    buttons: _buttons,
  );

  static void _createStopButton({required bool multiplePlaying}) {
    _buttons.clear();
    _buttons.add(
      NotificationButton(
        id: GoalTrackersForegroundTaskWrapper._stopButtonID,
        text: multiplePlaying ? 'Stop All' : 'Stop',
      ),
    );
  }

  static final List<NotificationButton> _buttons = [];

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

        final goalTrackers = await GoalTrackersStorage.read();
        final playingGoalTrackers = goalTrackers.thatArePlaying();

        if (playingGoalTrackers.isEmpty) return false;

        _createStopButton(multiplePlaying: playingGoalTrackers.length > 1);

        return true;
      },
      onData: (dynamic _) => ref.read(goalTrackersProvider.notifier).stopAll(),
      callback: startTask,
      androidNotificationOptions: _androidNotificationOptions,
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

  late final GoalTrackersNotification _notification;
  SendPort? _sendPort;

  void _update() async {
    await FlutterForegroundTask.updateService(
      notificationTitle: _notification.title,
      notificationText: _notification.body,
    );
  }

  @override
  Future<void> onStart(DateTime timestamp, SendPort? sendPort) async {
    _sendPort = sendPort;

    final goalTrackers = await GoalTrackersStorage.read();
    try {
      _notification = GoalTrackersNotification.createFromGoalTrackers(
        goalTrackers: goalTrackers,
      );
    } on NoPlayingGoalTrackersException {
      await FlutterForegroundTask.stopService();
    }
    _update();
  }

  @override
  void onRepeatEvent(DateTime timestamp, SendPort? sendPort) async {
    // Updates notification information if still has a playing goal tracker
    _sendPort = sendPort;

    _update();
    if (await FlutterForegroundTask.isAppOnForeground) {
      await FlutterForegroundTask.stopService();
    }
  }

  @override
  Future<void> onDestroy(DateTime timestamp, SendPort? sendPort) async {}

  @override
  void onNotificationButtonPressed(String id) async {
    if (id == GoalTrackersForegroundTaskWrapper._stopButtonID) {
      final goalTrackers = await GoalTrackersStorage.read();
      goalTrackers.stopAll();
      await GoalTrackersStorage.store(goalTrackers);
      await FlutterForegroundTask.stopService();

      // Sending a signal to the main isolate
      _sendPort?.send(null);
    }
  }
}
