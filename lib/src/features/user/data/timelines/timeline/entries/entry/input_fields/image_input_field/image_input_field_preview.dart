import 'package:flutter/material.dart';
import '../core/input_field_preview.dart';
import './image_input_field_model.dart';
import './helper/preview_images_cache.dart';

class ImageInputFieldPreview extends InputFieldPreview<ImageInputFieldModel> {
  static const _borderRadius = BorderRadius.all(Radius.circular(12.0));

  static const _emptyImage = _NonImage(Icons.image);
  static const _errorImage = _NonImage(Icons.broken_image_rounded);

  static int _getCacheSize(BuildContext context) {
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    return (devicePixelRatio * PreviewImagesCache.previewSize).toInt();
  }

  static Image? _buildImage(BuildContext context, MemoryImage? imageProvider) {
    // Using cache size on cacheWidth only to maintain image aspect ratio
    final cacheSize = _getCacheSize(context);
    if (imageProvider == null) return null;
    return Image.memory(
      imageProvider.bytes,
      fit: BoxFit.cover,
      alignment: Alignment.center,
      cacheWidth: cacheSize,
      filterQuality: FilterQuality.high,
      errorBuilder: (context, error, stackTrace) => _errorImage,
    );
  }

  const ImageInputFieldPreview({super.key, required super.model});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: ClipRRect(
        borderRadius: ImageInputFieldPreview._borderRadius,
        child: _buildImageView(context),
      ),
    );
  }

  Widget _buildImageView(BuildContext context) {
    if (model.value.isEmpty) return _emptyImage;
    final imageProvider = PreviewImagesCache.get(model.value);
    return _buildImage(context, imageProvider) ?? _errorImage;
  }
}

class _NonImage extends StatelessWidget {
  final IconData icon;
  const _NonImage(this.icon);

  @override
  Widget build(BuildContext context) {
    return FittedBox(fit: BoxFit.contain, child: Icon(icon));
  }
}
