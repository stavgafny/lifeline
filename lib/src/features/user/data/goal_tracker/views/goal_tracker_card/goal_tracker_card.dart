import 'package:flutter/material.dart';
import 'package:lifeline/src/widgets/expanded_section.dart';
import '../../controllers/goal_tracker_controller.dart';
import './widgets/progress_precent_indicator.dart';
import './widgets/play_pause_button.dart';
import './widgets/goal_name.dart';
import './widgets/play_time_info.dart';
import './widgets/progress_precent_info.dart';
import './widgets/select_button.dart';
import './widgets/selected_wrapper.dart';

class GoalTrackerCard extends StatelessWidget {
  static const _margin = EdgeInsets.all(12.0);
  static const _padding = EdgeInsets.symmetric(
    horizontal: 15.0,
    vertical: 20.0,
  );
  static const _cardBorderRadius = 15.0;
  static const _playerToInfoGap = SizedBox(width: 12.0);
  static const _nameToInfoGap = SizedBox(height: 6.0);

  final GoalTrackerProvider provider;
  const GoalTrackerCard({
    super.key,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: _margin,
      padding: _padding,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(_cardBorderRadius),
      ),
      child: Column(
        children: [
          Row(
            children: [
              _player(context),
              _playerToInfoGap,
              _info(context),
              _suffix(context),
            ],
          ),
          SelectedWrapper(
            provider: provider,
            builder: (context, isSelected) {
              print("build");

              return ExpandedSection(
                expand: isSelected,
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Center(child: Text("SELECTED")),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _player(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ProgressPrecentIndicator(provider: provider),
        PlayPauseButton(provider: provider),
      ],
    );
  }

  Widget _info(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GoalName(provider: provider),
              ProgressPrecentInfo(provider: provider),
            ],
          ),
          _nameToInfoGap,
          PlayTimeInfo(provider: provider),
        ],
      ),
    );
  }

  Widget _suffix(BuildContext context) {
    return SelectButton(provider: provider);
  }
}
