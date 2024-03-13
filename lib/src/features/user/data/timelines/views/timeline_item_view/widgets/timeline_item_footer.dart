import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeline/src/widgets/dialogs/name_edit_dialog.dart';
import '../../../controllers/timelines_controllers.dart';
import '../../../timeline/models/timeline_model.dart';
import './dialogs/delete_timeline_dialog.dart';

class TimelineItemFooter extends ConsumerWidget {
  static const EdgeInsets _padding = EdgeInsets.fromLTRB(10.0, 0.0, 2.0, 6.0);

  final TimelineModel timeline;

  const TimelineItemFooter({super.key, required this.timeline});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Divider(),
          Padding(
            padding: _padding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    timeline.name,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                PopupMenuButton(
                  child: const Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Icon(Icons.more_vert),
                  ),
                  itemBuilder: (context) => [
                    _buildMenuItem(
                      text: "Rename",
                      icon: Icons.text_fields,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => NameEditDialog(
                            name: timeline.name,
                            onCancel: () => Navigator.of(context).pop(),
                            onConfirm: (modifiedName) {
                              ref.read(timelinesProvider.notifier).rename(
                                  from: timeline.name, to: modifiedName);
                              Navigator.of(context).pop();
                            },
                          ),
                        );
                      },
                    ),
                    _buildMenuItem(
                      text: "Delete",
                      icon: Icons.delete_outline,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => DeleteTimelineDialog(
                            timelineName: timeline.name,
                            onDelete: () {
                              ref
                                  .read(timelinesProvider.notifier)
                                  .delete(timeline.name);
                            },
                            onCancel: () => Navigator.of(context).pop(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

PopupMenuItem _buildMenuItem({
  required String text,
  required IconData icon,
  void Function()? onTap,
}) {
  return PopupMenuItem(
    onTap: onTap,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon),
        const SizedBox(width: 10.0),
        Text(
          text,
          style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}
