import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

int _i = 0;
const _ani = [
  LoadingAnimationWidget.fourRotatingDots,
  LoadingAnimationWidget.staggeredDotsWave,
  LoadingAnimationWidget.stretchedDots,
  LoadingAnimationWidget.inkDrop
];

class LoadingSheet extends StatelessWidget {
  const LoadingSheet._();

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      isDismissible: false,
      enableDrag: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(50.0)),
      ),
      context: context,
      builder: (_) => const LoadingSheet._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    _i = (_i + 1) % _ani.length;
    return SizedBox(
      height: 250.0,
      child: Center(
        child:
            _ani[_i](color: Theme.of(context).colorScheme.onSurface, size: 80),
      ),
    );
  }
}
