import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lifeline/src/utils/time_helper.dart';
import 'package:lifeline/src/widgets/tappable_text.dart';
import '../../../controllers/goal_tracker_controller.dart';
import '../../goal_tracker_dialogs/goal_tracker_duration_edit_dialog.dart';
import '../widgets/helper/progress_updater.dart';

class PlayTimeEditFields extends StatelessWidget {
  static const _fieldsGap = SizedBox(height: 10.0);

  final GoalTrackerProvider provider;
  const PlayTimeEditFields({
    super.key,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer(
          builder: (context, ref, child) {
            return ProgressUpdater(
              provider: provider,
              builder: (context, snapshot) {
                return _EditableDuration(
                  label: "Progress",
                  duration: snapshot.progress.current,
                  onEditTap: () {
                    _showEditDialog(
                      context,
                      initialDuration: ref.read(provider).progress.current,
                      onConfirm: (duration) {
                        ref.read(provider.notifier).setProgress(duration);
                      },
                    );
                  },
                );
              },
            );
          },
        ),
        _fieldsGap,
        Consumer(
          builder: (context, ref, child) {
            final duration = ref.watch(
              provider.select((model) => model.duration),
            );
            return _EditableDuration(
              label: "Duration",
              duration: duration,
              onEditTap: () {
                _showEditDialog(
                  context,
                  initialDuration: ref.read(provider).duration,
                  onConfirm: (duration) {
                    ref.read(provider.notifier).setDuration(duration);
                  },
                );
              },
            );
          },
        ),
      ],
    );
  }

  void _showEditDialog(
    BuildContext context, {
    required Duration initialDuration,
    required void Function(Duration modifiedDuration) onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return GoalTrackerDurationEditDialog(
          initialDuration: initialDuration,
          onCancel: () => context.pop(),
          onConfirm: (duration) {
            if (duration.isNegative) return;
            onConfirm.call(duration);
            context.canPop() ? context.pop() : null;
          },
        );
      },
    );
  }
}

class _EditableDuration extends StatelessWidget {
  static const _gap = SizedBox(width: 6.0);
  static const _labelTextStyle = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w700,
  );
  static const _durationTextStyle = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w700,
  );

  final String label;
  final Duration duration;
  final void Function() onEditTap;

  const _EditableDuration({
    required this.label,
    required this.duration,
    required this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label, style: _labelTextStyle),
        _gap,
        TappableText(
          text: duration.format(DurationFormatType.absolute),
          onTap: onEditTap,
          style: _durationTextStyle,
        ),
      ],
    );
  }
}
