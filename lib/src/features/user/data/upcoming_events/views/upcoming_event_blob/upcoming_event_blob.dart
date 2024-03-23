import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/upcoming_event_controller.dart';
import './widgets/event_date.dart';
import './widgets/event_type.dart';
import './widgets/event_name.dart';

class UpcomingEventBlob extends ConsumerWidget {
  static const double totalTextSize = EventDate.textSize + EventName.textSize;

  final UpcomingEventProvider provider;
  final void Function()? onTap;

  const UpcomingEventBlob({super.key, required this.provider, this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(provider);
    return Column(
      children: [
        EventDate(model: model),
        EventType(model: model, onTap: onTap),
        EventName(model: model),
      ],
    );
  }
}
