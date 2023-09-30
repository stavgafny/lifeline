import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeline/src/utils/time_helper.dart';
import '../../../controllers/goal_tracker_controller.dart';
import '../../../models/goal_tracker_model.dart';

class ProgressDurationInfo extends ConsumerWidget {
  final StateNotifierProvider<GoalTrackerController, GoalTrackerModel> provider;
  const ProgressDurationInfo({
    super.key,
    required this.provider,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(provider.select((model) => model.progress));
    final duration = ref.watch(provider.select((model) => model.duration));
    return Text(
      "${progress.format(secondary: true)} / ${duration.format(secondary: true)}",
      style: TextStyle(
        color: Theme.of(context).colorScheme.onSecondary,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
