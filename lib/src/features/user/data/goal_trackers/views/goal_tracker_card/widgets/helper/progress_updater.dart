import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../controllers/goal_tracker_controller.dart';
import '../../../../models/goal_tracker_model.dart';

/// Rebuilds on progress changes or each second when playing
class ProgressUpdater extends ConsumerStatefulWidget {
  final GoalTrackerProvider provider;

  final Widget Function(
    BuildContext context,
    GoalTrackerModel snapshot,
  ) builder;

  const ProgressUpdater({
    super.key,
    required this.provider,
    required this.builder,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProgressUpdaterState();
}

class _ProgressUpdaterState extends ConsumerState<ProgressUpdater> {
  static const _tickDuration = Duration(seconds: 1);
  Timer? _tickTimer;

  void _handlePlayStateChanges() {
    final isPlaying = ref.read(widget.provider).isPlaying;
    isPlaying
        ? _tickTimer = Timer.periodic(_tickDuration, (_) => setState(() {}))
        : _tickTimer?.cancel();
  }

  @override
  void initState() {
    _handlePlayStateChanges();
    super.initState();
  }

  @override
  void dispose() {
    _tickTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<GoalTrackerModel>(widget.provider, (previous, next) {
      if (next.isPlaying != previous?.isPlaying ||
          next.progress != previous?.progress) {
        _handlePlayStateChanges();
      }
    });

    ref.watch(widget.provider.select((model) => model.progress));

    final snapshot = ref.read(widget.provider);
    return widget.builder(context, snapshot);
  }
}
