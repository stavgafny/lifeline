import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lifeline/src/router/routes/app_routes.dart';
import '../../upcoming_event_blob/widgets/event_date.dart';
import '../../upcoming_event_blob/widgets/event_name.dart';

class AddUpcomingEventButton extends StatelessWidget {
  final double size;
  final bool standalone;

  static void _onAddTap(BuildContext context) {
    context.pushNamed(
      AppRoutes.upcomingEvent,
      pathParameters: {'ue': "create"},
    );
  }

  const AddUpcomingEventButton({
    super.key,
    required this.size,
    required this.standalone,
  });

  @override
  Widget build(BuildContext context) {
    onTap() => _onAddTap(context);
    return SizedBox(
      width: size,
      child: standalone ? _AddButtonStandalone(onTap) : _AddButton(onTap),
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
