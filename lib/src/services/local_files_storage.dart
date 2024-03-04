import 'dart:io';

import 'package:path_provider/path_provider.dart';

class DirectoryCreationException implements Exception {
  const DirectoryCreationException();
}

abstract class LocalFilesStorage {
  final String entry;

  LocalFilesStorage(this.entry) {
    _init();
  }

  /// Root of `files` directory -> com.theapp/files/
  Future<Directory> get root => getApplicationSupportDirectory();

  Future<Directory> get current async =>
      Directory("${(await root).path}/$entry");

  void _init() async {
    final directory = await current;
    if (!directory.existsSync()) {
      try {
        await directory.create(recursive: true);
      } catch (e) {
        throw const DirectoryCreationException();
      }
    }
  }

  void clear() async {
    final directory = await current;
    directory.deleteSync(recursive: true);
    directory.createSync(recursive: true);
  }
}

class LocalFilesImagesStorage extends LocalFilesStorage {
  LocalFilesImagesStorage([String path = ""]) : super('images/$path');
}
