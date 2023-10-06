import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../controllers/goal_tracker_controller.dart';
import '../../../utils/goal_tracker_info_formatter.dart';
import './helper/progress_updater.dart';

class PlayTimeInfo extends ConsumerWidget {
  final GoalTrackerProvider provider;
  const PlayTimeInfo({
    super.key,
    required this.provider,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ProgressUpdater(
      provider: provider,
      builder: (context, snapshot) {
        final playtimeInfo = GoalTrackerInfoFormatter.playtime(snapshot);
        return Text(
          playtimeInfo,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSecondary,
            fontWeight: FontWeight.w700,
          ),
        );
      },
    );
  }
}
