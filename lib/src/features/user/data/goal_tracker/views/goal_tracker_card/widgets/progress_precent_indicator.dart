import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../controllers/goal_tracker_controller.dart';
import '../../../models/goal_tracker_model.dart';

class ProgressPrecentIndicator extends ConsumerWidget {
  static const _radius = 30.0;
  static const _lineWidth = 4.0;

  final StateNotifierProvider<GoalTrackerController, GoalTrackerModel> provider;
  const ProgressPrecentIndicator({super.key, required this.provider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final precent =
        ref.watch(provider.select((model) => model.progressPrecentage));
    return CircularPercentIndicator(
      radius: _radius,
      lineWidth: _lineWidth,
      backgroundColor: Theme.of(context).colorScheme.onSecondary,
      progressColor: Theme.of(context).colorScheme.primary,
      percent: precent,
    );
  }
}
