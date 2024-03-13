import 'package:flutter/material.dart';
import '../../../../models/upcoming_event_type.dart';

class UpcomingEventTypeEditDialog extends StatelessWidget {
  final Function(UpcomingEventType type) onSubmit;

  const UpcomingEventTypeEditDialog({required this.onSubmit, super.key});

  Widget _buildType(BuildContext context, UpcomingEventType type) {
    return Column(
      children: [
        Expanded(
          child: InkWell(
            onTap: () => onSubmit.call(type),
            customBorder: const CircleBorder(),
            child: Ink(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: type.value,
                  opacity: 1.0,
                ),
              ),
            ),
          ),
        ),
        Text(
          type.name,
          style: const TextStyle(fontSize: 18.0),
        ),
      ],
    );
  }

  Widget _buildTypesGrid(BuildContext context) {
    final upcomingEventsTypes = UpcomingEventType.values.toList();
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 20.0,
      crossAxisSpacing: 2.0,
      children: [
        for (final type in upcomingEventsTypes) _buildType(context, type),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: _buildTypesGrid(context),
      ),
    );
  }
}
