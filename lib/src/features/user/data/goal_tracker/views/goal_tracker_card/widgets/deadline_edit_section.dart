import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lifeline/src/widgets/tappable_text.dart';
import '../../../controllers/goal_tracker_controller.dart';
import '../../../utils/goal_tracker_info_formatter.dart';
import '../../goal_tracker_dialogs/goal_tracker_deadline_days_edit_dialog.dart';
import './deadline_remaining_time.dart';

class DeadlineEditSection extends StatelessWidget {
  static const _borderRadius = BorderRadius.all(Radius.circular(15.0));
  static const _padding = EdgeInsets.all(10.0);
  static const _titleTextStyle = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
  );
  static const _editTextStyle = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.bold,
  );

  final GoalTrackerProvider provider;

  const DeadlineEditSection({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: _padding,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: _borderRadius,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Deadline", style: _titleTextStyle),
              Row(
                children: [
                  DeadlineRemainingTime(provider: provider, extended: true),
                  _activateButton(),
                ],
              ),
            ],
          ),
          _repetitionField(),
        ],
      ),
    );
  }

  Widget _activateButton() {
    return Consumer(
      builder: (context, ref, child) {
        final deadline = ref.watch(provider.select((model) => model.deadline));
        return Checkbox(
          value: deadline.isActive,
          onChanged: (value) {
            ref
                .read(provider.notifier)
                .setDeadline(deadline.copyWith(isActive: value));
          },
        );
      },
    );
  }

  Widget _repetitionField() {
    return Consumer(
      builder: (context, ref, child) {
        final deadline = ref.watch(provider.select((model) => model.deadline));
        return IntrinsicHeight(
          child: Row(
            children: [
              Row(
                children: [
                  const Text("Resets every", style: _editTextStyle),
                  const SizedBox(width: 4.0),
                  TappableText(
                    text: GoalTrackerInfoFormatter.deadlineIterationDays(
                        deadline),
                    style: _editTextStyle,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return GoalTrackerDeadlineDaysEditDialog(
                            initialDays: deadline.iterationDays,
                            onCancel: () => context.pop(),
                            onConfirm: (days) {
                              ref.read(provider.notifier).setDeadline(
                                  deadline.reCreateWith(iterationDays: days));
                              context.canPop() ? context.pop() : null;
                            },
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
              VerticalDivider(
                color: Theme.of(context).colorScheme.onSecondary,
                thickness: 1.25,
              ),
              Row(
                children: [
                  const Text("at", style: _editTextStyle),
                  const SizedBox(width: 4.0),
                  TappableText(
                    text: GoalTrackerInfoFormatter.deadlineIterationTime(
                        deadline),
                    style: _editTextStyle,
                    onTap: () async {
                      final timeOfDay = await showTimePicker(
                        context: context,
                        initialTime: deadline.iterationTimeOfDay,
                      );
                      if (timeOfDay == null) return;
                      ref.read(provider.notifier).setDeadline(
                          deadline.reCreateWith(iterationTimeOfDay: timeOfDay));
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
