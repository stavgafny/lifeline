import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeline/src/services/global_time.dart';
import '../../../controllers/goal_tracker_controller.dart';
import '../../../utils/goal_tracker_info_formatter.dart';

class DeadlineInfo extends ConsumerStatefulWidget {
  final GoalTrackerProvider provider;

  const DeadlineInfo({super.key, required this.provider});

  @override
  DeadlineInfoState createState() => DeadlineInfoState();
}

class DeadlineInfoState extends ConsumerState<DeadlineInfo> {
  late String _deadlineInfo = _getDeadlineInfo();
  StreamSubscription<void>? _tickSubscription;

  String _getDeadlineInfo() {
    return GoalTrackerInfoFormatter.deadlineRemainingTime(
      ref.read(widget.provider),
    );
  }

  @override
  void initState() {
    super.initState();
    _tickSubscription = GlobalTime.onEveryDeviceSecond.listen((_) {
      final newDeadlineInfo = _getDeadlineInfo();
      if (newDeadlineInfo != _deadlineInfo) {
        setState(() => _deadlineInfo = newDeadlineInfo);
      }
    });
  }

  @override
  void dispose() {
    _tickSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _deadlineInfo,
      style: TextStyle(
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
