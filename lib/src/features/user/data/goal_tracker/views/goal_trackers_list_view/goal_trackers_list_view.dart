import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/goal_trackers_controller.dart';
import './widgets/gt_list_view.dart';
import './widgets/gt_error.dart';
import './widgets/gt_loading.dart';

class GoalTrackersListView extends ConsumerWidget {
  const GoalTrackersListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(goalTrackersProvider).when(
          data: (goalTrackers) => GTListView(
            goalTrackers: goalTrackers,
            onReorder: (oldIndex, newIndex) {
              ref.read(goalTrackersProvider.notifier).swap(oldIndex, newIndex);
            },
          ),
          error: (error, stackTrace) => GTError(error: error),
          loading: () => const GTLoading(),
        );
  }
}