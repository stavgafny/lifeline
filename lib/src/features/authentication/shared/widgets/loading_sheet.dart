import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

//! All fitting animations
//? LoadingAnimationWidget.fourRotatingDots,
//? LoadingAnimationWidget.staggeredDotsWave,
//? LoadingAnimationWidget.stretchedDots,
//? LoadingAnimationWidget.inkDrop

class LoadingSheet extends StatelessWidget {
  static const _animationSize = 80.0;
  static const _sheetHeight = 250.0;
  static const _sheetRadius = Radius.circular(50.0);

  static final Widget _loadingAnimation =
      LoadingAnimationWidget.fourRotatingDots(
    color: const Color(0xFFEDD8FB),
    size: _animationSize,
  );

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      isDismissible: false,
      enableDrag: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: _sheetRadius),
      ),
      context: context,
      builder: (_) => const LoadingSheet._(),
    );
  }

  const LoadingSheet._();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _sheetHeight,
      child: Center(
        child: _loadingAnimation,
      ),
    );
  }
}
