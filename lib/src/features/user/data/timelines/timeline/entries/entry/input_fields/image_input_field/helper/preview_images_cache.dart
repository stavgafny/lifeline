import 'dart:io';

import 'package:flutter/material.dart';
import '../../../views/entry_card_view/entry_card_view.dart';

class PreviewImagesCache {
  static final int previewSize = EntryCardView.cardHeight.toInt();

  static final Map<String, MemoryImage> _cache = {};

  static void _loadImageToCache(String path) {
    try {
      final file = File(path);
      final fileBytes = file.readAsBytesSync();
      _cache[path] = MemoryImage(fileBytes);
    } finally {}
  }

  static MemoryImage? get(String path) {
    if (!_cache.containsKey(path)) {
      _loadImageToCache(path);
    }
    return _cache[path];
  }
}
