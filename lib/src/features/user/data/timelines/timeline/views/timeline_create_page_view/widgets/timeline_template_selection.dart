import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../controllers/timeline_create_controller.dart';
import '../../../entries/entry/input_fields/core/input_field_model.dart';

class _TypeChip {
  final String labelText;
  final IconData iconData;

  const _TypeChip._(this.labelText, this.iconData);

  static const _text = _TypeChip._("Text", Icons.short_text_outlined);
  static const _number = _TypeChip._("Number", Icons.numbers_outlined);
  static const _weight = _TypeChip._("Weight", Icons.monitor_weight_outlined);
  static const _stars = _TypeChip._("Stars", Icons.stars_sharp);
  static const _image = _TypeChip._("Image", Icons.image);

  factory _TypeChip.getByType(InputFieldModelType type) {
    switch (type) {
      case InputFieldModelType.text:
        return _text;
      case InputFieldModelType.number:
        return _number;
      case InputFieldModelType.weight:
        return _weight;
      case InputFieldModelType.stars:
        return _stars;
      case InputFieldModelType.image:
        return _image;
    }
  }
}

class TimelineTemplateSelection extends ConsumerWidget {
  final TimelineCreateProvider timeline;

  const TimelineTemplateSelection({super.key, required this.timeline});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final template = ref.watch(timeline.select((t) => t.template));

    return Expanded(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _label(context),
            Expanded(
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 10.0,
                  children: [
                    for (final type in InputFieldModelType.values)
                      _TypeChoiceChip(
                        _TypeChip.getByType(type),
                        template.contains(type),
                        (selected) {
                          ref
                              .read(timeline.notifier)
                              .setTypeOnTemplate(type, selected);
                        },
                      )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _label(BuildContext context) {
    return Text(
      "Template:",
      style: TextStyle(fontSize: 24.0, color: Theme.of(context).hintColor),
    );
  }
}

class _TypeChoiceChip extends StatelessWidget {
  final _TypeChip typeChip;
  final bool isSelected;
  final void Function(bool selected) onSelect;

  const _TypeChoiceChip(this.typeChip, this.isSelected, this.onSelect);

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(typeChip.labelText, style: const TextStyle(fontSize: 15.0)),
      selected: isSelected,
      onSelected: onSelect,
      avatar: Icon(typeChip.iconData),
      showCheckmark: false,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      selectedColor: Theme.of(context).colorScheme.background,
      side: BorderSide.none,
    );
  }
}
