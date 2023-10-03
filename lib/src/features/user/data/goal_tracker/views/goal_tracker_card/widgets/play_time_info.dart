import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../controllers/goal_tracker_controller.dart';
import '../../../utils/goal_tracker_info_formatter.dart';

class PlayTimeInfo extends ConsumerWidget {
  final GoalTrackerProvider provider;
  const PlayTimeInfo({
    super.key,
    required this.provider,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playtimeInfo = ref.watch(
      provider.select(GoalTrackerInfoFormatter.playtime),
    );
    return Text(
      playtimeInfo,
      style: TextStyle(
        color: Theme.of(context).colorScheme.onSecondary,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
