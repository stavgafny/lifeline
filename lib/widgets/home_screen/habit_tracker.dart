import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../controllers/habit_tracker_controller.dart';

class HabitTracker extends StatelessWidget {
  final HabitTrackerController tracker;

  const HabitTracker({
    required this.tracker,
    Key? key,
  }) : super(key: key);

  bool get _selected => HabitTrackerController.selected.value == tracker.id;

  void playTap() {
    tracker.togglePlaying();
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
                const SizedBox(width: 15.0),
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
                      _duration(context),
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
      onTap: playTap,
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
        onTap: () {},
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

  Widget _duration(BuildContext context) {
    return Obx(
      () => Text(
        tracker.toString(detailed: _selected),
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSecondary,
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
              children: const [
                SizedBox(height: 10),
                Text("Test"),
                Text("Test"),
              ],
            ),
          ),
        ),
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
