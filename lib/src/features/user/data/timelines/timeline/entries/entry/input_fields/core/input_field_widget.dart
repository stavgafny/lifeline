import 'package:flutter/material.dart';
import './input_field_model.dart';

abstract class InputFieldWidget<Model extends InputFieldModel>
    extends StatelessWidget {
  final Model model;
  final void Function(Model snapshot) onChange;

  const InputFieldWidget({
    super.key,
    required this.model,
    required this.onChange,
  });
}

abstract class StatefulInputFieldWidget<Model extends InputFieldModel>
    extends StatefulWidget {
  final Model model;
  final void Function(Model snapshot) onChange;

  const StatefulInputFieldWidget({
    super.key,
    required this.model,
    required this.onChange,
  });
}
