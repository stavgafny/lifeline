import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProgressPrecentIndicator extends StatelessWidget {
  static const _radius = 30.0;
  static const _lineWidth = 4.0;

  const ProgressPrecentIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: _radius,
      lineWidth: _lineWidth,
      backgroundColor: Theme.of(context).colorScheme.onSecondary,
      progressColor: Theme.of(context).colorScheme.primary,
      percent: .0,
    );
  }
}
