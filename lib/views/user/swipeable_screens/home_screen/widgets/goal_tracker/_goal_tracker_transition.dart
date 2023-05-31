import 'package:flutter/material.dart';
import '../../../../../../controllers/goal_tracker_controller.dart';

class GoalTrackerTransition extends StatefulWidget {
  final Widget child;
  final GoalTrackerTransitionController transitionController;
  const GoalTrackerTransition({
    Key? key,
    required this.child,
    required this.transitionController,
  }) : super(key: key);

  @override
  State<GoalTrackerTransition> createState() => _GoalTrackerTransitionState();
}

class _GoalTrackerTransitionState extends State<GoalTrackerTransition>
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
