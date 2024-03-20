part of './timeline_model.dart';

class TimelineCreateModel {
  final String name;
  final TimelineTemplate template;

  const TimelineCreateModel({
    required this.name,
    TimelineTemplate? template,
  }) : template = template ?? const [];

  TimelineCreateModel copyWith({
    String? name,
    TimelineTemplate? template,
  }) {
    return TimelineCreateModel(
      name: name ?? this.name,
      template: template ?? this.template,
    );
  }
}
