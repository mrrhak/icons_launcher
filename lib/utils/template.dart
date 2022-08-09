import 'package:icons_launcher/utils/constants.dart';

/// Android template
class AndroidMipMapIconTemplate {
  /// Constructor
  AndroidMipMapIconTemplate({required this.directoryName, required this.size});

  /// Directory name
  final String directoryName;

  /// Icon size
  final int size;
}

/// iOS template
///
/// See https://developer.apple.com/library/archive/documentation/Xcode/Reference/xcode_ref-Asset_Catalog_Format/AppIconType.html
class IosIconTemplate {
  /// Constructor
  IosIconTemplate(
      {required this.sizeName,
      required this.scaledSize,
      required this.scale,
      required this.idiom});

  /// Icon size
  final int scaledSize;

  /// Icon size name to use in file names.
  final String sizeName;

  /// The device type for the image.
  /// See https://developer.apple.com/library/archive/documentation/Xcode/Reference/xcode_ref-Asset_Catalog_Format/ImageSetType.html#//apple_ref/doc/uid/TP40015170-CH25-SW2
  final String idiom;

  /// The targeted display scale for the image, currently one of {1, 2, 3}
  final int scale;

  /// Icon file name
  String get filename => '$IOS_DEFAULT_ICON_NAME-$sizeName@${scale}x.png';

  /// Used to encode the attributes for this asset file in a corresponding
  /// Asset's Contents.json file.
  Map<String, String> toJson() => {
        'filename': filename,
        'idiom': idiom,
        'scale': '${scale}x',
        'size': sizeName
      };
}

/// Web template
class WebIconTemplate {
  /// Constructor
  WebIconTemplate({required this.size, required this.name});

  /// Icon name
  final String name;

  /// Icon size
  final int size;
}

/// MacOS template
class MacOSIconTemplate {
  /// Constructor
  MacOSIconTemplate({required this.size, required this.name});

  /// Icon name
  final String name;

  /// Icon size
  final int size;
}

/// Windows template
class WindowsIconTemplate {
  /// Constructor
  WindowsIconTemplate({required this.size, required this.name});

  /// Icon name
  final String name;

  /// Icon size
  final int size;
}

/// Linux template
class LinuxIconTemplate {
  /// Constructor
  LinuxIconTemplate({required this.size, required this.name});

  /// Icon name
  final String name;

  /// Icon size
  final int size;
}
