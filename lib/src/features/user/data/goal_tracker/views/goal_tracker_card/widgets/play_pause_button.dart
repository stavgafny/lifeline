import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../controllers/goal_tracker_controller.dart';
import '../../../models/goal_tracker_model.dart';

class PlayPauseButton extends ConsumerWidget {
  static const _size = 40.0;

  final StateNotifierProvider<GoalTrackerController, GoalTrackerModel> provider;
  const PlayPauseButton({super.key, required this.provider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPlaying = ref.watch(provider.select((model) => model.isPlaying));
    return GestureDetector(
      onTap: () => ref.read(provider.notifier).toggle(),
      child: Icon(
        isPlaying ? Icons.pause : Icons.play_arrow,
        size: _size,
      ),
    );
  }
}
