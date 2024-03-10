import 'dart:convert';

import 'package:flutter/foundation.dart';
import '../entries/entry/input_fields/core/input_field_model.dart';
import '../entries/entry/models/entry_model.dart';

class TimelineModel {
  final String name;
  final List<EntryModel> entries;
  final List<InputFieldModelType> template;
  final DateTime lastModified;

  TimelineModel({
    required this.name,
    required this.entries,
    required this.template,
    required this.lastModified,
  });

  TimelineModel copyWith({
    String? name,
    List<EntryModel>? entries,
    List<InputFieldModelType>? template,
    DateTime? lastModified,
  }) {
    return TimelineModel(
      name: name ?? this.name,
      entries: entries ?? this.entries,
      template: template ?? this.template,
      lastModified: lastModified ?? this.lastModified,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'entries': entries.map((entry) => entry.toMap()).toList(),
      'template': template.map((entryType) => entryType.name).toList(),
      'lastModified': lastModified.millisecondsSinceEpoch,
    };
  }

  factory TimelineModel.fromMap(Map<String, dynamic> map) {
    return TimelineModel(
      name: map['name'] as String,
      entries: List<EntryModel>.from(
        (map['entries'] as List<dynamic>).map<EntryModel>(
          (entry) => EntryModel.fromMap(entry as Map<String, dynamic>),
        ),
      ),
      template: List<InputFieldModelType>.from(
        (map['template'] as List<dynamic>).map<InputFieldModelType>(
          (entryType) => InputFieldModelType.values.byName(entryType),
        ),
      ),
      lastModified:
          DateTime.fromMillisecondsSinceEpoch(map['lastModified'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory TimelineModel.fromJson(String source) =>
      TimelineModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TimelineModel(name: $name, entries: $entries, template: $template, lastModified: $lastModified)';
  }

  @override
  bool operator ==(covariant TimelineModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        listEquals(other.entries, entries) &&
        listEquals(other.template, template) &&
        other.lastModified == lastModified;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        entries.hashCode ^
        template.hashCode ^
        lastModified.hashCode;
  }
}
