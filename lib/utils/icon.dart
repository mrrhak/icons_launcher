import 'dart:typed_data';

import 'package:image/image.dart';
import 'package:universal_io/io.dart';

/// Icon template
class IconTemplate {
  /// Constructor
  const IconTemplate({required this.size});

  /// Size
  final int size;
}

/// Icon
class Icon {
  Icon._(this.image);

  /// Image
  Image image;

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

  /// Check image has an alpha channel
  bool get hasAlpha => image.hasAlpha;

  /// Remove alpha channel from the image
  void removeAlpha() {
    if (!hasAlpha) {
      return;
    }

    image.backgroundColor = ColorUint8.rgb(255, 255, 255);
    image = image.convert(numChannels: 3);
  }

  /// Create a resized copy of this Icon
  Icon copyResized(int iconSize) {
    if (image.width >= iconSize) {
      return Icon._(
        copyResize(
          image,
          width: iconSize,
          height: iconSize,
          interpolation: .average,
        ),
      );
    } else {
      return Icon._(
        copyResize(
          image,
          width: iconSize,
          height: iconSize,
          interpolation: .linear,
        ),
      );
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
    if (icons.isEmpty) {
      return;
    }

    final image = icons.first.image.clone();
    for (var i = 1; i < icons.length; i++) {
      image.addFrame(icons[i].image);
    }

    final data = encodeIco(image);
    final file = File(filePath);
    file.createSync(recursive: true);
    file.writeAsBytesSync(data);
  }

  void convertToGrayscale() => image = grayscale(image);

  void convertToWhite() {
    for (var y = 0; y < image.height; y++) {
      for (var x = 0; x < image.width; x++) {
        var pixel = image.getPixel(x, y);
        if (pixel.a > 0) {
          image.setPixel(x, y, image.getColor(255, 255, 255, pixel.a));
        }
      }
    }
  }
}
