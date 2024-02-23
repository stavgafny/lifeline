import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/upcoming_event_controller.dart';
import './widgets/event_date.dart';
import './widgets/event_type.dart';
import './widgets/event_name.dart';

class UpcomingEventBlob extends ConsumerWidget {
  static const double totalTextSize = EventDate.textSize + EventName.textSize;

  static Widget addButton({
    required final void Function() onTap,
    required bool standalone, // Is displayed alone with no upcoming events
  }) {
    return standalone ? _AddButtonStandalone(onTap) : _AddButton(onTap);
  }

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

class _AddButton extends StatelessWidget {
  static const double _iconSize = .3;

  final void Function() onTap;

  const _AddButton(this.onTap);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          const SizedBox(height: EventDate.textSize),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                shape: BoxShape.circle,
              ),
              child: Transform.scale(
                scale: _iconSize,
                child: const FittedBox(
                  fit: BoxFit.contain,
                  child: Icon(Icons.add),
                ),
              ),
            ),
          ),
          const SizedBox(height: EventName.textSize),
        ],
      ),
    );
  }
}

class _AddButtonStandalone extends StatelessWidget {
  static const _borderRadius = BorderRadius.all(Radius.circular(75));

  final void Function() onTap;

  const _AddButtonStandalone(this.onTap);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          const SizedBox(height: EventDate.textSize),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                shape: BoxShape.rectangle,
                borderRadius: _borderRadius,
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("No Upcoming Events", style: TextStyle(fontSize: 28.0)),
                  Text("Really...? Efficient or lazy mastermind?"),
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Icon(Icons.add, size: 40),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: EventName.textSize),
        ],
      ),
    );
  }
}
