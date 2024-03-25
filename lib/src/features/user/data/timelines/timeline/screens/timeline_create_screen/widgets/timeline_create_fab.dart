import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lifeline/src/router/routes/app_routes.dart';
import '../../../controllers/timeline_create_controller.dart';

class TimelineCreateFAB extends ConsumerWidget {
  static const _textStyle = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
  );
  static const _padding = EdgeInsets.all(10.0);

  static const ShapeBorder _shape = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  );

  final TimelineCreateProvider timelineCreate;

  const TimelineCreateFAB({super.key, required this.timelineCreate});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canCreate = ref.watch(timelineCreate.select((t) => t.canCreate));

    final onPressed = canCreate
        ? () {
            final timeline = ref.read(timelineCreate.notifier).createTimeline();
            if (timeline == null) return;
            context.pushReplacementNamed(
              AppRoutes.timeline,
              pathParameters: {'timeline': timeline.name},
            );
          }
        : null;

    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: MaterialButton(
        onPressed: onPressed,
        padding: _padding,
        shape: _shape,
        color: Theme.of(context).colorScheme.primary,
        disabledColor: Theme.of(context).colorScheme.onSecondary,
        child: Text(
          "Create Timeline",
          style: _textStyle.copyWith(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}
