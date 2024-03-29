import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../controllers/goal_tracker_controller.dart';
import './helper/selected_wrapper.dart';

class SelectedIcon extends ConsumerWidget {
  final GoalTrackerProvider provider;

  const SelectedIcon({super.key, required this.provider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SelectedWrapper(
        provider: provider,
        builder: (context, isSelected) {
          return Icon(
            isSelected ? Icons.expand_more : Icons.expand_less,
            size: 26,
          );
        },
      ),
    );
  }
}
