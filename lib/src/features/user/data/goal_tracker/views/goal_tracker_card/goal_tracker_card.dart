import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/goal_tracker_controller.dart';
import '../../models/goal_tracker_model.dart';
import './widgets/progress_precent_indicator.dart';
import './widgets/play_pause_button.dart';
import './widgets/goal_name.dart';
import './widgets/progress_duration_info.dart';

class GoalTrackerCard extends StatelessWidget {
  static const _width = double.infinity;
  static const _height = 100.0;
  static const _outerPadding = 12.0;
  static const _innerPadding = 15.0;
  static const _cardBorderRadius = 15.0;
  static const _playerToInfoGap = SizedBox(width: 12.0);

  final StateNotifierProvider<GoalTrackerController, GoalTrackerModel> provider;
  const GoalTrackerCard({
    super.key,
    required this.provider,
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
            _playerToInfoGap,
            _info(context),
          ],
        ),
      ),
    );
  }

  Widget _player(BuildContext context) {
    return SizedBox(
      child: Stack(
        alignment: Alignment.center,
        children: [
          ProgressPrecentIndicator(provider: provider),
          PlayPauseButton(provider: provider),
        ],
      ),
    );
  }

  Widget _info(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GoalName(provider: provider),
        ProgressDurationInfo(provider: provider),
      ],
    );
  }
}
