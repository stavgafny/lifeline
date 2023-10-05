import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeline/src/models/deadline.dart';
import 'package:lifeline/src/utils/time_helper.dart';
import '../../../controllers/goal_tracker_controller.dart';
import '../../../utils/goal_tracker_info_formatter.dart';

class DeadlineRemainingTime extends ConsumerStatefulWidget {
  final GoalTrackerProvider provider;
  final bool secondary;

  const DeadlineRemainingTime({
    super.key,
    required this.provider,
    required this.secondary,
  });

  @override
  DeadlineRemainingTimeState createState() => DeadlineRemainingTimeState();
}

class DeadlineRemainingTimeState extends ConsumerState<DeadlineRemainingTime> {
  Timer? _timer;

  void _waitForNextUpdate(Deadline deadline) {
    _timer?.cancel();
    final nextUpdate = deadline.remainingTime.getNextUpdate(
      secondary: widget.secondary,
    );
    _timer = Timer(nextUpdate, () => setState(() {}));
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Listen for deadline changes
    final deadline = ref.watch(
      widget.provider.select((model) => model.deadline),
    );

    // Wait for next update and setState
    _waitForNextUpdate(deadline);

    final deadlineInfoText = GoalTrackerInfoFormatter.deadlineRemainingTime(
      deadline,
      widget.secondary,
    );

    return Text(
      deadlineInfoText,
      style: TextStyle(
        color: deadline.isActive
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.surface,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
