import 'dart:io';

import 'package:flutter/material.dart';
import '../core/input_field_preview.dart';
import './image_input_field_model.dart';

class ImageInputFieldPreview extends InputFieldPreview<ImageInputFieldModel> {
  static const _borderRadius = BorderRadius.all(Radius.circular(12.0));

  const ImageInputFieldPreview({super.key, required super.model});

  @override
  Widget build(BuildContext context) {
    return _InputFieldImage(model: model);
  }
}

class _InputFieldImage extends StatelessWidget {
  static const _emptyImage = _NonImage(Icons.image);
  static const _errorImage = _NonImage(Icons.broken_image_rounded);

  final ImageInputFieldModel model;
  const _InputFieldImage({required this.model});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: ClipRRect(
        borderRadius: ImageInputFieldPreview._borderRadius,
        child: model.value.isEmpty ? _emptyImage : _buildImage(context),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return Image.file(
      File(model.value),
      fit: BoxFit.cover,
      alignment: Alignment.center,
      errorBuilder: (context, error, stackTrace) {
        return _errorImage;
      },
    );
  }
}

class _NonImage extends StatelessWidget {
  final IconData icon;
  const _NonImage(this.icon);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.contain,
      child: Expanded(child: Icon(icon)),
    );
  }
}
