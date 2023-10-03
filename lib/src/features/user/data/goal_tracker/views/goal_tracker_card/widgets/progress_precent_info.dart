import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controllers/goal_tracker_controller.dart';

class ProgressPrecentInfo extends ConsumerWidget {
  final GoalTrackerProvider provider;

  const ProgressPrecentInfo({super.key, required this.provider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formattedPrecent = ref.watch(
      provider.select((model) => model.formattedProgressPrecentage),
    );
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Text(
        formattedPrecent,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSecondary,
          fontSize: 14.0,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
