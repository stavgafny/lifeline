import 'dart:io';

import 'package:flutter/material.dart';
import '../core/input_field_preview.dart';
import './image_input_field_model.dart';

class ImageInputFieldPreview extends InputFieldPreview<ImageInputFieldModel> {
  const ImageInputFieldPreview({super.key, required super.model});

  @override
  Widget build(BuildContext context) {
    return _InputFieldImage(model: model);
  }
}

class _InputFieldImage extends StatelessWidget {
  final ImageInputFieldModel model;
  const _InputFieldImage({required this.model});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: (model.value.isEmpty ? _buildEmpty : _buildImage).call(context),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return Image.file(
      File(model.value),
      fit: BoxFit.cover,
      alignment: Alignment.center,
      errorBuilder: (context, error, stackTrace) {
        return _buildError(context);
      },
    );
  }

  Widget _buildError(BuildContext context) {
    return Transform.scale(
      scale: .5,
      child: const FittedBox(
        fit: BoxFit.contain,
        child: Expanded(child: Icon(Icons.image)),
      ),
    );
  }

  Widget _buildEmpty(BuildContext context) {
    return Transform.scale(
      scale: .5,
      child: const FittedBox(
        fit: BoxFit.contain,
        child: Expanded(child: Icon(Icons.image_not_supported_rounded)),
      ),
    );
  }
}
