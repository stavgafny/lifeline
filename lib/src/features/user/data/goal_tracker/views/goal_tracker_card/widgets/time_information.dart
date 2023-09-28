import 'package:flutter/material.dart';
import 'package:lifeline/src/utils/time_helper.dart';

class TimeInformation extends StatelessWidget {
  final Duration duration;
  final Duration progress;
  const TimeInformation({
    super.key,
    required this.duration,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "${progress.format(secondary: true)} / ${duration.format(secondary: true)}",
      style: TextStyle(
        color: Theme.of(context).colorScheme.onSecondary,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
