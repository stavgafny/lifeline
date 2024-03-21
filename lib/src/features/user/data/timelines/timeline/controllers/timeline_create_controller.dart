import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/timelines_controllers.dart';
import '../../timeline/models/timeline_model.dart';
import '../entries/entry/input_fields/core/input_field_model.dart';

typedef TimelineCreateProvider = AutoDisposeStateNotifierProvider<
    TimelineCreateController, TimelineCreateModel>;

class TimelineCreateController extends StateNotifier<TimelineCreateModel> {
  final Ref _ref;

  TimelineCreateController(this._ref)
      : super(
          TimelineCreateModel(
            name: _ref.read(timelinesProvider.notifier).getSuggestedNewName(),
            template: [],
          ),
        );

  void setName(String name) {
    state = state.copyWith(
      name: name,
      nameExists: _ref.read(timelinesProvider.notifier).nameExists(name),
    );
  }

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

  TimelineModel? createTimeline() {
    return _ref.read(timelinesProvider.notifier).createTimeline(state);
  }
}
