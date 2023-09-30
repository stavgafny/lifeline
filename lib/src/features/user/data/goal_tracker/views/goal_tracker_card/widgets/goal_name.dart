import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../controllers/goal_tracker_controller.dart';
import '../../../models/goal_tracker_model.dart';

class GoalName extends ConsumerWidget {
  final StateNotifierProvider<GoalTrackerController, GoalTrackerModel> provider;
  const GoalName({super.key, required this.provider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = ref.watch(provider.select((model) => model.name));
    return Text(
      name,
      style: const TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
