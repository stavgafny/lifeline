part of './email_cooldown_controller.dart';

class EmailCooldownState {
  final int time;
  EmailCooldownState([this.time = 0]);

  bool get isInCooldown => time > 0;

  EmailCooldownState copyWith([int? time]) {
    return EmailCooldownState(time ?? this.time);
  }
}
