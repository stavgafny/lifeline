import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/timeline_create_controller.dart';
import './widgets/timeline_create_name_text_field.dart';
import './widgets/timeline_create_template_selection.dart';
import './widgets/timeline_create_fab.dart';

class TimelineCreateScreen extends ConsumerWidget {
  static const _padding = EdgeInsets.all(10.0);
  static const _gap = SizedBox(height: 40.0);

  const TimelineCreateScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timelineCreate = TimelineCreateProvider(
      (ref) => TimelineCreateController(ref),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const Text(
          "New Timeline",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: _padding,
        child: Column(
          children: [
            TimelineCreateNameTextField(timelineCreate: timelineCreate),
            _gap,
            TimelineCreateTemplateSelection(timelineCreate: timelineCreate),
          ],
        ),
      ),
      floatingActionButton: TimelineCreateFAB(timelineCreate: timelineCreate),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
