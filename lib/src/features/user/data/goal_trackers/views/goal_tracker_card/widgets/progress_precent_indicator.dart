import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../../controllers/goal_tracker_controller.dart';
import './helper/progress_updater.dart';

class ProgressPrecentIndicator extends ConsumerWidget {
  static const _radius = 30.0;
  static const _lineWidth = 4.0;

  final GoalTrackerProvider provider;

  const ProgressPrecentIndicator({super.key, required this.provider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Also listen for duration changes for precentage calculation
    ref.watch(provider.select((model) => model.duration));
    return ProgressUpdater(
      provider: provider,
      builder: (context, snapshot) {
        final precent = snapshot.progressPrecentage;
        return CircularPercentIndicator(
          radius: _radius,
          lineWidth: _lineWidth,
          backgroundColor: Theme.of(context).colorScheme.onSecondary,
          progressColor: Theme.of(context).colorScheme.primary,
          percent: precent.clamp(0.0, 1.0),
        );
      },
    );
  }
}
