import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../controllers/goal_tracker_controller.dart';

class DeadlineInfo extends ConsumerWidget {
  final GoalTrackerProvider provider;
  const DeadlineInfo({super.key, required this.provider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final info = ref.watch(
      provider.select((model) => model.deadlineRemainingTimeInfo),
    );
    return Text(
      info,
      style: TextStyle(
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
