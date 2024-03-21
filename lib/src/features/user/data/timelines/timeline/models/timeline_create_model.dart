part of './timeline_model.dart';

class TimelineCreateModel {
  final String name;
  final TimelineTemplate template;

  final bool nameExists;

  const TimelineCreateModel({
    required this.name,
    TimelineTemplate? template,
    this.nameExists = false,
  }) : template = template ?? const [];

  bool get canCreate => !nameExists && name.isNotEmpty && template.isNotEmpty;

  TimelineCreateModel copyWith({
    String? name,
    TimelineTemplate? template,
    bool? nameExists,
  }) {
    return TimelineCreateModel(
      name: name ?? this.name,
      template: template ?? this.template,
      nameExists: nameExists ?? this.nameExists,
    );
  }
}
