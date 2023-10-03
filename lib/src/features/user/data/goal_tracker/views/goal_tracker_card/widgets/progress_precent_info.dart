import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../controllers/goal_tracker_controller.dart';
import '../../../utils/goal_tracker_info_formatter.dart';

class ProgressPrecentInfo extends ConsumerWidget {
  final GoalTrackerProvider provider;

  const ProgressPrecentInfo({super.key, required this.provider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final precentageInfo = ref.watch(
      provider.select(GoalTrackerInfoFormatter.progressPrecentage),
    );
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Text(
        precentageInfo,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSecondary,
          fontSize: 14.0,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
