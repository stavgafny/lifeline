import 'package:flutter/material.dart';
import '../../models/goal_tracker_model.dart';
import './widgets/progress_precent_indicator.dart';
import './widgets/play_pause_button.dart';
import './widgets/goal_name.dart';
import './widgets/time_information.dart';

class GoalTrackerCard extends StatelessWidget {
  static const _width = double.infinity;
  static const _height = 100.0;
  static const _outerPadding = 12.0;
  static const _innerPadding = 15.0;
  static const _cardBorderRadius = 15.0;

  final GoalTrackerModel model;
  const GoalTrackerCard({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(_outerPadding),
      child: Container(
        width: _width,
        height: _height,
        padding: const EdgeInsets.all(_innerPadding),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(_cardBorderRadius),
        ),
        child: Row(
          children: [
            _player(context),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GoalName(name: model.name),
                  TimeInformation(
                    duration: model.duration,
                    progress: model.progress,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _player(BuildContext context) {
    return const SizedBox(
      child: Stack(
        alignment: Alignment.center,
        children: [
          ProgressPrecentIndicator(),
          PlayPauseButton(),
        ],
      ),
    );
  }
}
