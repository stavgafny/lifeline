part of './reset_cooldown_controller.dart';

class ResetCooldownState {
  final int time;
  ResetCooldownState([this.time = 0]);

  bool get isInCooldown => time > 0;

  ResetCooldownState copyWith([int? time]) {
    return ResetCooldownState(time ?? this.time);
  }
}
