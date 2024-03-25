import 'package:flutter/foundation.dart';
import '../input_fields/core/input_field_model.dart';

class EntryModel {
  final List<InputFieldModel> inputFields;
  final List<String> tags;
  const EntryModel({required this.inputFields, required this.tags});

  factory EntryModel.createNew(List<InputFieldModelType> types) {
    final inputFields = [
      for (final inputFieldType in types) InputFieldModel.empty(inputFieldType)
    ];
    return EntryModel(inputFields: inputFields, tags: []);
  }

  bool get hasChanges {
    if (tags.isNotEmpty) return true;
    for (final inputField in inputFields) {
      if (inputField != InputFieldModel.empty(inputField.type)) {
        return true;
      }
    }
    return false;
  }

  EntryModel copyWith({
    List<InputFieldModel>? inputFields,
    List<String>? tags,
  }) {
    return EntryModel(
      inputFields: inputFields ?? this.inputFields,
      tags: tags ?? this.tags,
    );
  }

  Map<String, List<dynamic>> toJson() {
    return <String, List<dynamic>>{
      'inputFields': inputFields.map((iField) => iField.toJson()).toList(),
      'tags': tags,
    };
  }

  factory EntryModel.fromJson(dynamic map) {
    return EntryModel(
      inputFields: List<InputFieldModel>.from(
        (map['inputFields'] as List<dynamic>).map(
          (iField) => InputFieldModel.fromJson(iField),
        ),
      ),
      tags: List<String>.from(map['tags']),
    );
  }

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
