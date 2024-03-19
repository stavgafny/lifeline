import 'dart:io';

import 'package:flutter/material.dart';
import '../core/input_field_widget.dart';
import './image_input_field_model.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../services/timelines_images_storage.dart';

class ImageInputFieldWidget extends InputFieldWidget<ImageInputFieldModel> {
  const ImageInputFieldWidget({
    super.key,
    required super.model,
    required super.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return _ImageInputFieldWidget(key: key, model: model, onChange: onChange);
  }
}

class _ImageInputFieldWidget extends StatefulWidget {
  final ImageInputFieldModel model;
  final void Function(ImageInputFieldModel) onChange;

  const _ImageInputFieldWidget({
    super.key,
    required this.model,
    required this.onChange,
  });

  @override
  State<_ImageInputFieldWidget> createState() => _ImageInputFieldWidgetState();
}

class _ImageInputFieldWidgetState extends State<_ImageInputFieldWidget> {
  late ImageInputFieldModel _current = widget.model;

  void _handlePickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imagePath = await TimelinesImagesStorage.instance.saveImage(image);

      if (imagePath != _current.value) {
        setState(() => _current = ImageInputFieldModel(value: imagePath));
        widget.onChange(_current);
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handlePickImage,
      child: _ImageField(model: _current),
    );
  }
}

class _ImageField extends StatelessWidget {
  final ImageInputFieldModel model;
  const _ImageField({required this.model});

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
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline_outlined, size: 80.0),
          Text("Failed to load image", style: TextStyle(fontSize: 24.0)),
        ],
      ),
    );
  }

  Widget _buildEmpty(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add_photo_alternate_outlined, size: 80.0),
          Text("No image selected", style: TextStyle(fontSize: 24.0)),
        ],
      ),
    );
  }
}
