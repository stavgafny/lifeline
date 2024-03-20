import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../controllers/timelines_controllers.dart';
import '../../../timeline/views/timeline_create_page_view/timeline_create_page_view.dart';

class AddTimelineButton extends ConsumerWidget {
  const AddTimelineButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        TimelineCreatePageView.display(context);
        ref.read(timelinesProvider.notifier);
      },
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
        borderRadius: const BorderRadius.all(Radius.circular(6.0)),
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
