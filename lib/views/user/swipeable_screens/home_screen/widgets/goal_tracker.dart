import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../../../controllers/goal_tracker_controller.dart';
import '../../../../../widgets/tappable_text.dart';
import '../../../../../widgets/wheel_input.dart';

/// Dialog for editing the goal tracker name
///
/// [name] -> the current goal tracker name
///
/// [onCancel] -> callback function when exiting the dialog with cancel
///
/// [onConfirm] -> callback function for confirm action
/// callback has the modified name passed as an argument
///
/// [startSelected] -> select all name text at start
///
/// Defaults to true.
///
/// Note that confirm can only be called if current [modifiedName] is not empty
class _NameEditDialog extends StatefulWidget {
  final TextEditingController controller;
  final void Function() onCancel;
  final void Function(String modifiedName) onConfirm;

  /// Create [TextEditingController] form given name and if [startSelected] is
  /// true set the controller selection to select the whole name text
  _NameEditDialog({
    required String name,
    required this.onCancel,
    required this.onConfirm,
    bool startSelected = true,
  }) : controller = TextEditingController(text: name) {
    if (startSelected) {
      controller.selection =
          TextSelection(baseOffset: 0, extentOffset: name.length);
    }
  }

  @override
  State<_NameEditDialog> createState() => _NameEditDialogState();
}

class _NameEditDialogState extends State<_NameEditDialog> {
  /// Determines whether can be confirmed
  ///
  /// If false, [onConfirm] won't be called and the confirm button text color
  /// will be set as disabled
  bool enabled = false;

  /// updates [enabled] value to the current controller text value
  /// whether its empty or not.
  ///
  /// [enabled] = controller text not empty
  ///
  /// Only if the condition isn't the same as [enabled], then setState is called
  /// to reduce unnecessary rebuilds
  void _updateEnabled() {
    final isNotEmpty = widget.controller.text.trim().isNotEmpty;
    if (enabled == isNotEmpty) return;
    setState(() => enabled = isNotEmpty);
  }

  @override
  void initState() {
    // Updates enabled on start once and then for every controller text change
    _updateEnabled();
    widget.controller.addListener(_updateEnabled);
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the text controller when the dialog is dismissed
    widget.controller.removeListener(_updateEnabled);
    widget.controller.dispose();
    super.dispose();
  }

  @override
  AlertDialog build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.surface,
      title: TextField(
        controller: widget.controller,
        autofocus: true,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Name',
        ),
      ),
      actions: [
        MaterialButton(
          onPressed: widget.onCancel,
          child: Text(
            "Cancel",
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
        ),
        MaterialButton(
          onPressed: enabled
              ? () => widget.onConfirm.call(widget.controller.text.trim())
              : null,
          textColor: enabled ? Theme.of(context).colorScheme.primary : null,
          disabledTextColor: Theme.of(context).disabledColor,
          child: const Text("OK"),
        ),
      ],
    );
  }
}

class GoalTracker extends StatelessWidget {
  static void showNameEditDialog(
    BuildContext context, {
    required String name,
    required void Function() onCancel,
    required void Function(String modifiedName) onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (context) => _NameEditDialog(
        name: name,
        onCancel: onCancel,
        onConfirm: onConfirm,
      ),
    );
  }

  final GoalTrackerController tracker;
  final Function onRemove;
  const GoalTracker({
    required this.tracker,
    required this.onRemove,
    Key? key,
  }) : super(key: key);

  bool get _selected => GoalTrackerController.selected.value == tracker;

  @override
  Widget build(BuildContext context) {
    return _GoalTrackerTransition(
      transitionController: tracker.transitionController,
      child: GestureDetector(
        onTap: () {
          GoalTrackerController.setSelected(_selected ? null : tracker);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          child: Container(
            padding: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    _playPauseIndicator(context),
                    const SizedBox(width: 12.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(child: _name(context)),
                              const SizedBox(width: 5),
                              _precent(context),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Obx(
                            () => Visibility(
                              visible: !_selected,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _progressDuration(context),
                                  _deadlineRemain(context, expanded: false),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    _expandIcon(),
                  ],
                ),
                _expandedSection(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _playPauseIndicator(BuildContext context) {
    return GestureDetector(
      onTap: () {
        tracker.togglePlaying();
      },
      child: SizedBox(
        width: 50.0,
        height: 50.0,
        child: Stack(
          children: [
            Obx(
              () => CircularPercentIndicator(
                radius: 25.0,
                lineWidth: 4,
                backgroundColor: Theme.of(context).colorScheme.onSecondary,
                progressColor: Theme.of(context).colorScheme.primary,
                percent: tracker.toIndicator,
              ),
            ),
            Center(
              child: Obx(
                () => Icon(
                  tracker.playing.value ? Icons.pause : Icons.play_arrow,
                  size: 30.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _name(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: _selected
            ? () => GoalTracker.showNameEditDialog(
                  context,
                  name: tracker.name.value,
                  onCancel: () => Navigator.of(context).pop(),
                  onConfirm: (modifiedName) {
                    tracker.name.value = modifiedName;
                    Navigator.of(context).pop();
                  },
                )
            : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            color: _selected
                ? Theme.of(context).colorScheme.onSecondary.withAlpha(50)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Visibility(
                visible: _selected,
                child: const Padding(
                  padding: EdgeInsets.only(right: 6),
                  child: Icon(
                    Icons.label_outline,
                    size: 20.0,
                  ),
                ),
              ),
              Flexible(
                child: Text(
                  tracker.name.value,
                  style: const TextStyle(fontSize: 18.0),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _precent(BuildContext context) {
    return Obx(
      () => Text(
        tracker.precentFormat,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSecondary,
        ),
      ),
    );
  }

  Widget _progressDuration(BuildContext context) {
    return Visibility(
      visible: !_selected,
      child: Text(
        tracker.toString(),
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSecondary,
        ),
      ),
    );
  }

  Widget _expandIcon() {
    return Obx(
      () => Icon(_selected ? Icons.expand_less : Icons.expand_more),
    );
  }

  Widget _expandedSection(BuildContext context) {
    return Obx(
      () => _ExpandedSection(
        expand: _selected,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              _editableDuration(context, "Progress", tracker.progress),
              const SizedBox(height: 10),
              _editableDuration(context, "Duration", tracker.duration),
              const SizedBox(height: 20),
              _deadline(context),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _resetIcon(context),
                  const SizedBox(width: 10.0),
                  _removeIcon(context),
                  const SizedBox(width: 5.0),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _editableDuration(
      BuildContext context, String text, Rx<Duration> durationObservable) {
    return Row(
      children: [
        Text(
          text,
          style: const TextStyle(fontSize: 16.0),
        ),
        const SizedBox(width: 5),
        TappableText(
          text:
              formatDuration(durationObservable.value, DurationFormat.absolute),
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => WheelInputDurationDialog(
                days: durationObservable.value.inDays,
                hours: durationObservable.value.inHours % Duration.hoursPerDay,
                minutes: durationObservable.value.inMinutes %
                    Duration.minutesPerHour,
                onSubmit: (days, hours, minutes) {
                  tracker.refreshTimer(() {
                    durationObservable.value = Duration(
                      days: days,
                      hours: hours,
                      minutes: minutes,
                    );
                  });
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _deadline(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withAlpha(100),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text("Deadline", style: TextStyle(fontSize: 20.0)),
                  const SizedBox(width: 6.0),
                  Column(
                    children: [
                      const SizedBox(height: 6.0),
                      _deadlineRemain(context, expanded: true),
                    ],
                  ),
                ],
              ),
              Obx(
                () => Checkbox(
                  value: tracker.deadline.value.active.value,
                  onChanged: (value) {
                    if (value != null) {
                      tracker.deadline.value.active.value = value;
                    }
                  },
                  activeColor: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Reset Every"),
              TappableText(
                text: "${tracker.deadline.value.days} day"
                    "${tracker.deadline.value.days > 1 ? "s" : ""}",
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => WheelInputDaysDialog(
                      days: tracker.deadline.value.days,
                      onSubmit: (days) {
                        Deadline.modify(tracker.deadline, days: days);
                      },
                    ),
                  );
                },
              ),
              const Text("At"),
              TappableText(
                text: tracker.deadline.value.stringifedTime,
                onTap: () {
                  showTimePicker(
                    context: context,
                    initialTime: tracker.deadline.value.time,
                    initialEntryMode: TimePickerEntryMode.dial,
                  ).then((time) {
                    if (time != null) {
                      Deadline.modify(tracker.deadline, time: time);
                    }
                  });
                },
              ),
              const SizedBox(width: 30.0),
            ],
          ),
          const SizedBox(height: 6.0),
        ],
      ),
    );
  }

  Widget _deadlineRemain(BuildContext context, {required bool expanded}) {
    // Display deadline remaining time if active, add "Time left" on expanded
    if (!tracker.deadline.value.active.value && !expanded) {
      return const SizedBox();
    }
    return Obx(
      () => Text(
        formatDuration(
          tracker.deadline.value.timeRemain.value,
          expanded ? DurationFormat.detailed : DurationFormat.shortened,
        ),
        style: TextStyle(
          color: Theme.of(context)
              .colorScheme
              .primary
              .withAlpha(tracker.deadline.value.active.value ? 255 : 100),
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _resetIcon(BuildContext context) {
    return IconButton(
      onPressed: tracker.hasProgress
          ? () {
              tracker.togglePlaying(playing: false);
              tracker.reset();
            }
          : null,
      icon: const Icon(Icons.restart_alt_rounded),
      style: IconButton.styleFrom(splashFactory: NoSplash.splashFactory),
    );
  }

  Widget _removeIcon(BuildContext context) {
    return GestureDetector(
      onTap: () => onRemove.call(),
      child: Icon(
        Icons.delete_outline,
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }
}

class _ExpandedSection extends StatefulWidget {
  final bool expand;
  final Widget? child;
  const _ExpandedSection({
    this.expand = false,
    this.child,
  });

  @override
  _ExpandedSectionState createState() => _ExpandedSectionState();
}

class _ExpandedSectionState extends State<_ExpandedSection>
    with SingleTickerProviderStateMixin {
  late AnimationController expandController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    prepareAnimations();
    _runExpandCheck();
  }

  /// Setting up the animation
  void prepareAnimations() {
    expandController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.easeInOut,
    );
  }

  void _runExpandCheck() {
    if (widget.expand) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  @override
  void didUpdateWidget(_ExpandedSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    _runExpandCheck();
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
        axisAlignment: 1.0, sizeFactor: animation, child: widget.child);
  }
}

class _GoalTrackerTransition extends StatefulWidget {
  final Widget child;
  final GoalTrackerTransitionController transitionController;
  const _GoalTrackerTransition({
    Key? key,
    required this.child,
    required this.transitionController,
  }) : super(key: key);

  @override
  State<_GoalTrackerTransition> createState() => _GoalTrackerTransitionState();
}

class _GoalTrackerTransitionState extends State<_GoalTrackerTransition>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      value: widget.transitionController.animateIn ? 0 : 1,
      duration: GoalTrackerTransitionController.duration,
    );
    _animation = CurvedAnimation(
      curve: Curves.easeInOutSine,
      parent: _controller,
    );
    widget.transitionController.controller = _controller;
    if (widget.transitionController.animateIn) {
      widget.transitionController.fadeIn();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: _animation,
      axis: Axis.vertical,
      axisAlignment: 0.0,
      child: FadeTransition(
        opacity: _animation,
        child: widget.child,
      ),
    );
  }
}
