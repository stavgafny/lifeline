import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../timeline/models/timeline_model.dart';
import '../entries/entry/input_fields/core/input_field_model.dart';

typedef TimelineCreateProvider = AutoDisposeStateNotifierProvider<
    TimelineCreateController, TimelineCreateModel>;

class TimelineCreateController extends StateNotifier<TimelineCreateModel> {
  TimelineCreateController({
    required String initialName,
    TimelineTemplate? template,
  }) : super(TimelineCreateModel(name: initialName, template: template));

  void setName(String name) => state = state.copyWith(name: name);

  void setTypeOnTemplate(InputFieldModelType type, bool isSet) {
    final template = [...state.template];
    final hasType = state.template.contains(type);

    if (isSet && !hasType) {
      template.add(type);
    } else if (!isSet && hasType) {
      template.remove(type);
    } else {
      return;
    }
    state = state.copyWith(template: template);
  }
}
