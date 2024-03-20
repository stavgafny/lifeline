import 'package:flutter/material.dart';
import '../../../controllers/timelines_controllers.dart';
import '../../controllers/timeline_create_controller.dart';
import './widgets/timeline_name_text_field.dart';

class TimelineCreatePageView extends StatelessWidget {
  static void display(BuildContext context) async {
    final timeline = TimelineCreateProvider(
      (ref) {
        final name = ref.read(timelinesProvider.notifier).getSuggestedNewName();
        return TimelineCreateController(initialName: name);
      },
    );

    final page = TimelineCreatePageView._(timeline);

    await showDialog(
      context: context,
      builder: (context) => page,
      barrierDismissible: false,
      useSafeArea: false,
    );
  }

  final TimelineCreateProvider timeline;

  const TimelineCreatePageView._(this.timeline);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const Text(
          "New Timeline",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          TimelineNameTextField(timeline: timeline),
        ],
      ),
    );
  }
}
