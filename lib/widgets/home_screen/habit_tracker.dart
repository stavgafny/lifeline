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

  @override
  Widget build(BuildContext context) {
    void playTap() {
      tracker.togglePlaying();
    }

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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
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
                                backgroundColor:
                                    Theme.of(context).colorScheme.onSecondary,
                                progressColor:
                                    Theme.of(context).colorScheme.primary,
                                percent: tracker.toIndicator,
                              ),
                            ),
                            Center(
                              child: Obx(
                                () => Icon(
                                  tracker.playing.value
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  size: 30.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 15.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Obx(
                              () => Text(
                                tracker.name.value,
                                style: const TextStyle(fontSize: 20.0),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Obx(
                              () => Text(
                                tracker.precentFormat,
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Obx(
                          () => Text(
                            tracker.toString(),
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Obx(
                  () => GestureDetector(
                    onTap: () {
                      HabitTrackerController.setSelected(
                          _selected ? null : tracker.id);
                    },
                    child:
                        Icon(_selected ? Icons.expand_less : Icons.expand_more),
                  ),
                ),
              ],
            ),
            Obx(
              () => _ExpandedSection(
                expand: _selected,
                child: SizedBox(
                  height: 80,
                  child: Center(
                    child: Column(
                      children: const [
                        SizedBox(height: 20),
                        Text("Test"),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
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
