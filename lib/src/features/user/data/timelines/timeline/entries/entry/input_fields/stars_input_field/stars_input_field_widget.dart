import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../core/input_field_widget.dart';
import './stars_input_field_model.dart';

class StarsInputFieldWidget extends InputFieldWidget<StarsInputFieldModel> {
  static const _itemBuild = Icon(Icons.star, color: Colors.amber);

  const StarsInputFieldWidget({
    super.key,
    required super.model,
    required super.onChange,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final textSize = width / 15.0;
    final iconSize = width / 11.0;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Rating:", style: TextStyle(fontSize: textSize)),
        const SizedBox(width: 12.0),
        RatingBar.builder(
          initialRating: model.value,
          minRating: StarsInputFieldModel.minRating,
          maxRating: StarsInputFieldModel.maxRating,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: StarsInputFieldModel.maxRating.toInt(),
          itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
          itemBuilder: (context, _) => _itemBuild,
          itemSize: iconSize,
          onRatingUpdate: (rating) {
            onChange(StarsInputFieldModel(value: rating));
          },
        ),
      ],
    );
  }
}
