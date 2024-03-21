import 'package:flutter/material.dart';
import '../../controllers/timeline_create_controller.dart';
import './widgets/timeline_create_name_text_field.dart';
import './widgets/timeline_create_template_selection.dart';
import './widgets/timeline_create_fab.dart';

class TimelineCreatePageView extends StatelessWidget {
  static const _padding = EdgeInsets.all(10.0);
  static const _gap = SizedBox(height: 40.0);

  static void display(BuildContext context) async {
    final timelineCreate = TimelineCreateProvider(
      (ref) => TimelineCreateController(ref),
    );

    final page = TimelineCreatePageView._(timelineCreate);

    await showDialog(
      context: context,
      builder: (context) => page,
      barrierDismissible: false,
      useSafeArea: false,
    );
  }

  final TimelineCreateProvider timelineCreate;

  const TimelineCreatePageView._(this.timelineCreate);

  @override
  Widget build(BuildContext context) {
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
