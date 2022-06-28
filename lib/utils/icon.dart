import 'dart:typed_data';

import 'package:image/image.dart';
import 'package:universal_io/io.dart';

/// Icon template
class IconTemplate {
  const IconTemplate({required this.size});

  final int size;
}

class Icon {
  const Icon._(this.image);
  final Image image;

  /// Load an image from bytes
  static Icon? _loadBytes(Uint8List bytes) {
    final image = decodeImage(bytes);
    if (image == null) {
      return null;
    }

    return Icon._(image);
  }

  /// Load an image from file
  static Icon? loadFile(String filePath) {
    return Icon._loadBytes(File(filePath).readAsBytesSync());
  }

  bool get hasAlpha => image.channels == Channels.rgba;

  /// Remove alpha channel from the image
  void removeAlpha() {
    image.channels = Channels.rgb;
    image.fillBackground(0xFFFFFFFF);
  }

  /// Create a resized copy of this Icon
  Icon copyResized(int iconSize) {
    // Note: Do not change interpolation unless you end up with better results
    // (see issue for result when using cubic interpolation)
    if (image.width >= iconSize) {
      return Icon._(copyResize(
        image,
        width: iconSize,
        height: iconSize,
        interpolation: Interpolation.average,
      ));
    } else {
      return Icon._(copyResize(
        image,
        width: iconSize,
        height: iconSize,
        interpolation: Interpolation.linear,
      ));
    }
  }

  /// Save the resized image to a file
  void saveResizedPng(int iconSize, String filePath) {
    final data = encodePng(copyResized(iconSize).image);
    final file = File(filePath);
    file.createSync(recursive: true);
    file.writeAsBytesSync(data);
  }

  /// Save the resized image to a Windows ico file
  static void saveIco(List<Icon> icons, String filePath) {
    final data = encodeIcoImages(icons.map((e) => e.image).toList());
    final file = File(filePath);
    file.createSync(recursive: true);
    file.writeAsBytesSync(data);
  }
}
