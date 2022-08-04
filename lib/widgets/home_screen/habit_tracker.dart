import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../controllers/habit_tracker_controller.dart';

class HabitTracker extends StatelessWidget {
  final HabitTrackerController tracker;
  final Function onChange;
  final Function onRemovePressed;

  const HabitTracker({
    required this.tracker,
    required this.onRemovePressed,
    required this.onChange,
    Key? key,
  }) : super(key: key);

  bool get _selected => HabitTrackerController.selected.value == tracker.id;

  void _playTap() => tracker.togglePlaying();

  void _labelTap(BuildContext context) {
    final controller = TextEditingController(text: tracker.name.value);
    controller.selection = TextSelection(
      baseOffset: 0,
      extentOffset: tracker.name.value.length,
    );
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: TextField(
            controller: controller,
            autofocus: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Label',
            )),
        actions: [
          MaterialButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Cancel",
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
          ),
          MaterialButton(
            onPressed: () {
              tracker.name.value = controller.text;
              Navigator.pop(context);
              onChange();
            },
            child: Text(
              "OK",
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
      child: Container(
        padding: const EdgeInsets.all(20.0),
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
                        children: [
                          Flexible(child: _label(context)),
                          const SizedBox(width: 5),
                          _precent(context),
                        ],
                      ),
                      const SizedBox(height: 4),
                      _progressDuration(context),
                    ],
                  ),
                ),
                _expandIcon(context),
              ],
            ),
            _expandedSection(context)
          ],
        ),
      ),
    );
  }

  Widget _playPauseIndicator(BuildContext context) {
    return GestureDetector(
      onTap: _playTap,
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

  Widget _label(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: () => _selected ? _labelTap(context) : null,
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
    return Obx(
      () => Visibility(
        visible: !_selected,
        child: Text(
          tracker.toString(),
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
      ),
    );
  }

  Widget _expandIcon(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: () {
          HabitTrackerController.setSelected(_selected ? null : tracker.id);
        },
        child: Icon(_selected ? Icons.expand_less : Icons.expand_more),
      ),
    );
  }

  Widget _expandedSection(BuildContext context) {
    return Obx(
      () => _ExpandedSection(
        expand: _selected,
        child: SizedBox(
          height: 100,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                _editableDuration(context, "Progress", tracker.progress),
                const SizedBox(height: 10),
                _editableDuration(context, "Duration", tracker.duration),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _resetIcon(context),
                    const SizedBox(width: 10),
                    _removeIcon(context),
                  ],
                ),
              ],
            ),
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
        GestureDetector(
          onTap: () {
            tracker.togglePlaying(playing: false);
            showTimePicker(
              context: context,
              initialTime: TimeOfDay(
                hour: durationObservable.value.inHours,
                minute: durationObservable.value.inMinutes % 60,
              ),
            ).then((value) {
              if (value != null) {
                durationObservable.value = Duration(
                  hours: value.hour,
                  minutes: value.minute,
                );
                onChange();
              }
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: _selected
                  ? Theme.of(context).colorScheme.onSecondary.withAlpha(50)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              tracker.format(durationObservable.value, true),
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
        ),
      ],
    );
  }

  Widget _resetIcon(BuildContext context) {
    return GestureDetector(
      onTap: () {
        tracker.reset();
        onChange();
      },
      child: Icon(
        Icons.restart_alt_rounded,
        color: tracker.hasProgress
            ? Theme.of(context).colorScheme.onSurface
            : Theme.of(context).colorScheme.onSecondary,
      ),
    );
  }

  Widget _removeIcon(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HabitTrackerController.setSelected(null);
        onRemovePressed();
        onChange();
      },
      child: Icon(
        Icons.delete_outline,
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }
}

class _ExpandedSection extends StatefulWidget {
  final Widget? child;
  final bool expand;
  const _ExpandedSection({this.expand = false, this.child});

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

  ///Setting up the animation
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
