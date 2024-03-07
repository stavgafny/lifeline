import 'package:flutter/material.dart';
import './input_field_model.dart';


abstract class InputFieldPreview<Model extends InputFieldModel>
    extends StatelessWidget {
  final Model model;

  const InputFieldPreview({super.key, required this.model});
}
