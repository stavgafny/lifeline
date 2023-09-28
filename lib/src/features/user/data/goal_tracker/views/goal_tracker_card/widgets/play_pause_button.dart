import 'package:flutter/material.dart';

class PlayPauseButton extends StatelessWidget {
  static const _size = 40.0;
  const PlayPauseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.play_arrow, // false ? Icons.pause : Icons.play_arrow,
      size: _size,
    );
  }
}
