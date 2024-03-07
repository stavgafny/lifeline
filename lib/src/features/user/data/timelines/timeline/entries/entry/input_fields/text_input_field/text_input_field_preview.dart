import 'package:flutter/material.dart';
import '../core/input_field_preview.dart';
import './text_input_field_model.dart';

class TextInputFieldPreview extends InputFieldPreview<TextInputFieldModel> {
  const TextInputFieldPreview({super.key, required super.model});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSecondary.withAlpha(50),
          border: Border.all(color: Theme.of(context).colorScheme.onSecondary),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Text(
          model.value.isEmpty ? "Empty text" : model.value,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 11.0),
          textAlign: model.value.isEmpty ? TextAlign.center : TextAlign.justify,
        ),
      ),
    );
  }
}
