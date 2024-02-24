import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lifeline/src/widgets/snackbars.dart';
import 'package:lifeline/src/widgets/transitions.dart';
import '../../../models/goal_tracker_model.dart';
import '../../../controllers/goal_tracker_controller.dart';
import '../../../controllers/goal_tracker_select_controller.dart';
import '../../../controllers/goal_trackers_controller.dart';
import '../../goal_tracker_card/goal_tracker_card.dart';
import '../../goal_tracker_dialogs/goal_tracker_name_edit_dialog.dart';

class GTListView extends ConsumerStatefulWidget {
  final List<GoalTrackerProvider> goalTrackers;

  const GTListView({super.key, required this.goalTrackers});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GTListViewState();
}

class _GTListViewState extends ConsumerState<GTListView> {
  GoalTrackersController get _goalTrackersController =>
      ref.read(goalTrackersProvider.notifier);
  GoalTrackerSelectController get _goalTrackersSelectController =>
      ref.read(goalTrackerSelectProvider.notifier);

  @override
  Widget build(BuildContext context) {
    return widget.goalTrackers.isEmpty
        ? _emptyGoalTrackers(context)
        : _goalTrackers(context);
  }

  Widget _goalTrackers(BuildContext context) {
    return Stack(
      children: [_goalTrackersList(context), _createGoalTrackerButton(context)],
    );
  }

  Widget _emptyGoalTrackers(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Transitions.sizeFade(
          controller: TransitionController(animateOnStart: true),
          child: const Center(
            child: Column(
              children: [
                Text("No Goal Trackers", style: TextStyle(fontSize: 24)),
                SizedBox(height: 10.0),
                Text("Add one below", style: TextStyle(fontSize: 16)),
                Icon(Icons.arrow_downward_rounded, size: 30.0),
              ],
            ),
          ),
        ),
        _createGoalTrackerButton(context),
      ],
    );
  }

  Widget _buildGoalTracker(GoalTrackerProvider goalTracker) {
    return Consumer(
      key: ValueKey(goalTracker),
      builder: (context, ref, child) {
        final tc = ref.read(goalTracker.notifier).transitionController;
        return Transitions.sizeFade(
          controller: tc,
          child: GoalTrackerCard(
            provider: goalTracker,
            onDelete: () => _onDeleteGoalTracker(goalTracker),
          ),
        );
      },
    );
  }

  Widget _goalTrackersList(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      child: ReorderableListView(
        onReorder: (oldIndex, newIndex) {
          _goalTrackersController.swap(oldIndex, newIndex);
        },
        children: widget.goalTrackers.map(_buildGoalTracker).toList(),
        proxyDecorator: (child, i, a) => Material(child: child),
      ),
    );
  }

  Widget _createGoalTrackerButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: ElevatedButton(
          onPressed: _onCreateGoalTracker,
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }

  void _onCreateGoalTracker() {
    showDialog(
      context: context,
      builder: (context) => GoalTrackerNameEditDialog(
        name: "",
        onCancel: () => context.pop(),
        onConfirm: (name) {
          final goalTracker = _goalTrackersController
              .create(GoalTrackerModel.empty(name: name));

          if (goalTracker != null) {
            final tc = ref.read(goalTracker.notifier).transitionController;
            tc.animateOnStart = true;
          }

          context.pop();
        },
      ),
    );
  }

  void _onDeleteGoalTracker(GoalTrackerProvider goalTracker) async {
    final goalTrackerController = ref.read(goalTracker.notifier);
    final name = ref.read(goalTracker).name;
    final index = _goalTrackersController.indexOf(goalTracker);
    if (index == -1) return;

    UndoSnackBar(
      text: "Removed $name",
      onUndoResult: (undoPressed) {
        if (undoPressed) {
          // if switched to a different screen and tapped undo while closing
          if (!mounted) return;
          goalTrackerController.transitionController.animateOnStart = true;
          _goalTrackersController.insert(goalTracker, index);
        } else {
          goalTrackerController.dispose();
        }
      },
    ).display(context, override: true);

    await goalTrackerController.transitionController.animateOut();
    _goalTrackersSelectController.select(null);
    _goalTrackersController.remove(goalTracker);
  }

  @override
  void dispose() {
    UndoSnackBar.clear();
    super.dispose();
  }
}
