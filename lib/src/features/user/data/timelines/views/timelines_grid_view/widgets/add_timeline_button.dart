import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lifeline/src/router/routes/app_routes.dart';

class AddTimelineButton extends ConsumerWidget {
  static const _borderRadius = BorderRadius.all(Radius.circular(6.0));

  const AddTimelineButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => context.pushNamed(AppRoutes.timelineCreate),
      child: _buildButton(context),
    );
  }

  Widget _buildButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).iconTheme.color!,
        ),
        borderRadius: _borderRadius,
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.create_new_folder, size: 22.0),
          SizedBox(width: 6.0),
          Text(
            "New Timeline",
            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
