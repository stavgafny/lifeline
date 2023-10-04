import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeline/src/utils/time_helper.dart';
import '../../../controllers/goal_tracker_controller.dart';
import '../../../utils/goal_tracker_info_formatter.dart';

class DeadlineRemainingTime extends ConsumerStatefulWidget {
  final GoalTrackerProvider provider;

  const DeadlineRemainingTime({super.key, required this.provider});

  @override
  DeadlineRemainingTimeState createState() => DeadlineRemainingTimeState();
}

class DeadlineRemainingTimeState extends ConsumerState<DeadlineRemainingTime> {
  Timer? _timer;

  void _waitForNextUpdate() {
    _timer?.cancel();
    final deadline = ref.read(widget.provider).deadline;
    final nextUpdate = deadline.remainingTime.getNextUpdate();
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
    ref.watch(widget.provider.select((model) => model.deadline));

    // Wait for next update and setState
    _waitForNextUpdate();

    return Text(
      GoalTrackerInfoFormatter.deadlineRemainingTime(ref.read(widget.provider)),
      style: TextStyle(
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
