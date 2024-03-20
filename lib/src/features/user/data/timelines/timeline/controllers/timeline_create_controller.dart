import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../timeline/models/timeline_model.dart';

typedef TimelineCreateProvider = AutoDisposeStateNotifierProvider<
    TimelineCreateController, TimelineCreateModel>;

class TimelineCreateController extends StateNotifier<TimelineCreateModel> {
  TimelineCreateController({
    required String initialName,
    TimelineTemplate? template,
  }) : super(TimelineCreateModel(name: initialName, template: template));

  void setName(String name) => state = state.copyWith(name: name);
}
