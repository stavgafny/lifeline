import 'package:flutter/material.dart';
import '../core/input_field_preview.dart';
import './stars_input_field_model.dart';

class StarsInputFieldPreview extends InputFieldPreview<StarsInputFieldModel> {
  const StarsInputFieldPreview({super.key, required super.model});

  @override
  Widget build(BuildContext context) {
    assert(
      model.value <= StarsInputFieldModel.maxRating,
      "Can't have more then max rating",
    );
    final filled = model.value.toInt();
    final half = model.value.toInt() != model.value;
    final rest = (StarsInputFieldModel.maxRating - model.value).floor();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...List.generate(filled, (_) => const _Star(Icons.star_rounded)),
        if (half) const _Star(Icons.star_half_rounded),
        ...List.generate(rest, (_) => const _Star(Icons.star_outline_rounded)),
      ],
    );
  }
}

class _Star extends StatelessWidget {
  final IconData icon;
  const _Star(this.icon);

  @override
  Widget build(BuildContext context) {
    return Icon(icon, color: Colors.amber);
  }
}
