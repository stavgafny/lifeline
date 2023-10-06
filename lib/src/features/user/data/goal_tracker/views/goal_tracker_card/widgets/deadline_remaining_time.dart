import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeline/src/models/deadline.dart';
import 'package:lifeline/src/utils/global_time.dart';
import '../../../controllers/goal_tracker_controller.dart';
import '../../../utils/goal_tracker_info_formatter.dart';

class DeadlineRemainingTime extends ConsumerStatefulWidget {
  final GoalTrackerProvider provider;
  final bool extended;

  const DeadlineRemainingTime({
    super.key,
    required this.provider,
    required this.extended,
  });

  @override
  DeadlineRemainingTimeState createState() => DeadlineRemainingTimeState();
}

class DeadlineRemainingTimeState extends ConsumerState<DeadlineRemainingTime> {
  String? _deadlineInfo;
  StreamSubscription<void>? _deviceSecondListener;

  @override
  void initState() {
    _deviceSecondListener = GlobalTime.onEveryDeviceSecond.listen((_) {
      final current = _getDeadlineInfo(ref.read(widget.provider).deadline);
      if (current != _deadlineInfo) {
        setState(() => _deadlineInfo = current);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _deviceSecondListener?.cancel();
    super.dispose();
  }

  String _getDeadlineInfo(Deadline deadline) {
    return GoalTrackerInfoFormatter.deadlineRemainingTime(
      deadline,
      widget.extended,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Listen for deadline changes
    final deadline = ref.watch(
      widget.provider.select((model) => model.deadline),
    );

    _deadlineInfo = _getDeadlineInfo(deadline);

    return Text(
      _deadlineInfo ?? "",
      style: TextStyle(
        color: deadline.isActive
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.surface,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
