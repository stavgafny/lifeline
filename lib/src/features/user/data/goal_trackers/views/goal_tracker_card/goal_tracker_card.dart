import 'package:flutter/material.dart';
import 'package:lifeline/src/widgets/expanded_section.dart';
import '../../controllers/goal_tracker_controller.dart';
import './widgets/helper/selected_wrapper.dart';
import './widgets/progress_precent_indicator.dart';
import './widgets/play_pause_button.dart';
import './widgets/goal_name.dart';
import './widgets/play_time_info.dart';
import './widgets/progress_precent_info.dart';
import './widgets/tap_select_detector.dart';
import './widgets/selected_icon.dart';
import './widgets/deadline_remaining_time.dart';
import './widgets/play_time_edit_fields.dart';
import './widgets/deadline_edit_section.dart';
import './widgets/footer_buttons.dart';

class GoalTrackerCard extends StatelessWidget {
  static const _margin = EdgeInsets.all(12.0);
  static const _padding = EdgeInsets.symmetric(
    horizontal: 15.0,
    vertical: 20.0,
  );
  static const _cardBorderRadius = 15.0;
  static const _playerPadding = EdgeInsets.only(right: 12.0);
  static const _headerPadding = EdgeInsets.only(bottom: 6.0);
  static const _expandedSectionPadding = EdgeInsets.only(
    left: 5.0,
    right: 5.0,
    top: 10.0,
  );
  static const _expandedSectionItemsGap = SizedBox(height: 20.0);

  final GoalTrackerProvider provider;
  final void Function() onDelete;

  const GoalTrackerCard({
    super.key,
    required this.provider,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return TapSelectDetector(
      provider: provider,
      child: Container(
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
                Expanded(
                  child: Column(
                    children: [
                      _header(context),
                      _shrinkedInfo(context),
                    ],
                  ),
                ),
                _suffix(context),
              ],
            ),
            _selected(context),
          ],
        ),
      ),
    );
  }

  Widget _player(BuildContext context) {
    return Padding(
      padding: _playerPadding,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ProgressPrecentIndicator(provider: provider),
          PlayPauseButton(provider: provider),
        ],
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Padding(
      padding: _headerPadding,
      child: Row(
        children: [
          GoalName(provider: provider),
          ProgressPrecentInfo(provider: provider),
        ],
      ),
    );
  }

  Widget _shrinkedInfo(BuildContext context) {
    return SelectedWrapper(
      provider: provider,
      builder: (context, isSelected) {
        return Visibility.maintain(
          visible: !isSelected,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PlayTimeInfo(provider: provider),
              DeadlineRemainingTime(provider: provider, extended: false),
            ],
          ),
        );
      },
    );
  }

  Widget _suffix(BuildContext context) {
    return SelectedIcon(provider: provider);
  }

  Widget _selected(BuildContext context) {
    return SelectedWrapper(
      provider: provider,
      builder: (context, isSelected) {
        return ExpandedSection(
          expand: isSelected,
          child: Padding(
            padding: _expandedSectionPadding,
            child: Column(
              children: [
                PlayTimeEditFields(provider: provider),
                _expandedSectionItemsGap,
                DeadlineEditSection(provider: provider),
                Padding(
                  padding: _expandedSectionPadding,
                  child: FooterButtons(provider: provider, onDelete: onDelete),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
