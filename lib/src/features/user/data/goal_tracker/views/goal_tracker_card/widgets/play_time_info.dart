import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../controllers/goal_tracker_controller.dart';
import '../../../models/goal_tracker_model.dart';

class PlayTimeInfo extends ConsumerWidget {
  final StateNotifierProvider<GoalTrackerController, GoalTrackerModel> provider;
  const PlayTimeInfo({
    super.key,
    required this.provider,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playTimeInfo =
        ref.watch(provider.select((model) => model.playTimeInfo));
    return Text(
      playTimeInfo,
      style: TextStyle(
        color: Theme.of(context).colorScheme.onSecondary,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
