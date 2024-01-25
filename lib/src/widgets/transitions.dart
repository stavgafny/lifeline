import 'package:flutter/material.dart';

class TransitionController {
  bool animateOnStart;

  AnimationController? _controller;

  TransitionController({this.animateOnStart = false});

  void setController(AnimationController controller) {
    _controller = controller;
  }

  Future<void> animateIn() async => await _controller?.forward(from: 0);

  Future<void> animateOut() async => await _controller?.animateTo(0);
}

class Transitions extends StatefulWidget {
  final TransitionController controller;
  final Duration duration;
  final Curve curve;
  final Widget Function(Animation<double> animation) builder;

  const Transitions.custom({
    super.key,
    required this.controller,
    required this.duration,
    required this.curve,
    required this.builder,
  });

  factory Transitions.sizeFade({
    required TransitionController controller,
    required Widget child,
  }) {
    return Transitions.custom(
      controller: controller,
      duration: const Duration(milliseconds: 325),
      curve: Curves.easeInOutSine,
      builder: (animation) {
        return SizeTransition(
          sizeFactor: animation,
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
    );
  }

  @override
  State<Transitions> createState() => _TransitionsState();
}

class _TransitionsState extends State<Transitions>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  void _attachAnimationController() {
    _controller = AnimationController(
      vsync: this,
      value: widget.controller.animateOnStart ? 0 : 1,
      duration: widget.duration,
    );
    _animation = CurvedAnimation(curve: widget.curve, parent: _controller);
    widget.controller.setController(_controller);
  }

  @override
  void initState() {
    super.initState();
    _attachAnimationController();
    if (widget.controller.animateOnStart) {
      widget.controller.animateIn();
      widget.controller.animateOnStart = false;
    }
  }

  // @override
  // void didUpdateWidget(covariant Transitions oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   _attachAnimationController();
  // }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(_animation);
  }
}
