import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../input_fields/core/input_field_model.dart';

class EntryModel {
  final List<InputFieldModel> inputFields;
  final List<String> tags;
  const EntryModel({required this.inputFields, required this.tags});

  EntryModel copyWith({
    List<InputFieldModel>? inputFields,
    List<String>? tags,
  }) {
    return EntryModel(
      inputFields: inputFields ?? this.inputFields,
      tags: tags ?? this.tags,
    );
  }

  Map<String, List<dynamic>> toMap() {
    return <String, List<dynamic>>{
      'inputFields': inputFields.map((x) => x.toMap()).toList(),
      'tags': tags,
    };
  }

  factory EntryModel.fromMap(Map<String, dynamic> map) {
    return EntryModel(
      inputFields: List<InputFieldModel>.from(
        (map['inputFields'] as List<dynamic>).map(
          (x) => InputFieldModel.fromMap(x),
        ),
      ),
      tags: List<String>.from(map['tags']),
    );
  }

  String toJson() => json.encode(toMap());

  factory EntryModel.fromJson(String source) =>
      EntryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'EntryModel(inputFields: $inputFields, tags: $tags)';

  @override
  bool operator ==(covariant EntryModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.inputFields, inputFields) &&
        listEquals(other.tags, tags);
  }

  @override
  int get hashCode => inputFields.hashCode ^ tags.hashCode;
}
