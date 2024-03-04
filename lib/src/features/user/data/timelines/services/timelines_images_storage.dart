import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lifeline/src/services/local_files_storage.dart';

class TimelinesImagesStorage extends LocalFilesImagesStorage {
  static TimelinesImagesStorage instance = TimelinesImagesStorage._();

  TimelinesImagesStorage._() : super('timelines/');

  /// Creates a copy of the image inside `PATH:myapp/files/images/timelines/`
  ///
  /// Asynchronously saves an image file to the local storage.
  ///
  /// If an image with the same name already exists,
  /// checks whether the images are the same and if so, returns same image path.
  ///
  /// If the images are not the same the new image is saved with a counter
  /// next to it that increases until its unique.
  Future<String> saveImage(XFile xfile, [int counter = 0]) async {
    final directory = await current;
    final file = File(xfile.path);
    final destination = [
      directory.path,
      if (counter == 0) xfile.name else "${xfile.name}($counter)",
    ].join("/");

    final destFile = File(destination);

    if (!destFile.existsSync()) {
      file.copySync(destination);
      return destination;
    }
    if (listEquals(destFile.readAsBytesSync(), file.readAsBytesSync())) {
      return destination;
    }

    return saveImage(xfile, counter + 1);
  }
}
