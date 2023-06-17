import 'dart:async';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

part './reset_cooldown_state.dart';

final resetCooldownProvider =
    StateNotifierProvider<ResetCooldownController, ResetCooldownState>(
        (ref) => ResetCooldownController());

class ResetCooldownController extends StateNotifier<ResetCooldownState> {
  static const cooldownDuration = Duration(seconds: 30);

  Timer? _timer;
  ResetCooldownController() : super(ResetCooldownState());

  void _clearTimer() => _timer?.cancel();

  void _updateTime(int time) => state = state.copyWith(time);

  void _setCooldownTime() => _updateTime(cooldownDuration.inSeconds);

  void setCooldown() {
    _clearTimer();
    _setCooldownTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateTime(max(state.time - 1, 0));
      if (!state.isInCooldown) {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
