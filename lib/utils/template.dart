import 'dart:convert';

import 'package:universal_io/io.dart';

import 'cli_logger.dart';
import 'constants.dart';

/// Android template
class AndroidMipMapIconTemplate {
  /// Constructor
  AndroidMipMapIconTemplate({required this.directoryName, required this.size});

  /// Directory name
  final String directoryName;

  /// Icon size
  final int size;
}

/// Interface for any templates that use Apple's Asset Catalog App Icon Type.
///
/// See https://developer.apple.com/library/archive/documentation/Xcode/Reference/xcode_ref-Asset_Catalog_Format/AppIconType.html
abstract class AppleIconTemplate {
  /// Constructor
  AppleIconTemplate({
    required this.sizeName,
    required this.scaledSize,
    required this.scale,
    required this.idiom,
    this.platform,
    this.appearances,
  });

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
  String get filename;

  /// Icon platform
  final String? platform;

  /// Icon appearances
  final List<IconAppearance>? appearances;

  /// Used to encode the attributes for this asset file in a corresponding
  /// Asset's Contents.json file.
  Map<String, dynamic> toJson();
}

class IconAppearance {
  IconAppearance({
    required this.appearance,
    required this.value,
  });

  final String appearance;
  final String value;

  Map<String, String> toJson() {
    return <String, String>{
      'appearance': appearance,
      'value': value,
    };
  }

  IconAppearance fromJson(Map<String, String> json) {
    return IconAppearance(
      appearance: json['appearance'] as String,
      value: json['value'] as String,
    );
  }
}

/// iOS template
class IosIconTemplate extends AppleIconTemplate {
  /// Constructor
  IosIconTemplate({
    required super.sizeName,
    required super.scaledSize,
    required super.scale,
    required super.idiom,
    super.platform,
    super.appearances,
  });

  @override
  String get filename {
    var isDarkAppearance = appearances != null &&
        appearances!
            .any((e) => e.appearance == 'luminosity' && e.value == 'dark');

    var isTintedAppearance = appearances != null &&
        appearances!
            .any((e) => e.appearance == 'luminosity' && e.value == 'tinted');

    var defaultName = IOS_DEFAULT_ICON_NAME;
    if (isDarkAppearance) {
      defaultName = '$defaultName-Dark';
    } else if (isTintedAppearance) {
      defaultName = '$defaultName-Tinted';
    }

    if (scale == 0) {
      return '$defaultName-$sizeName.png';
    } else {
      return '$defaultName-$sizeName@${scale}x.png';
    }
  }

  @override
  Map<String, dynamic> toJson() {
    var json = <String, dynamic>{
      'filename': filename,
      'idiom': idiom,
      'scale': '${scale}x',
      'size': sizeName,
      if (platform != null) 'platform': platform,
      if (appearances != null)
        'appearances': appearances!.map((e) => e.toJson()).toList(),
    };

    if (scale == 0) {
      json.remove('scale');
    }

    return json;
  }
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
class MacOSIconTemplate extends AppleIconTemplate {
  /// Constructor
  MacOSIconTemplate({
    required super.sizeName,
    required super.scaledSize,
    required super.scale,
    required super.idiom,
  });

  @override
  String get filename {
      if (scale == 0) {
        return '${MACOS_DEFAULT_ICON_NAME}-$sizeName.png';
      } else {
        return '${MACOS_DEFAULT_ICON_NAME}-$sizeName@${scale}x.png';
      }
  }

  @override
  Map<String, dynamic> toJson() => <String, String>{
        'filename': filename,
        'idiom': 'mac',
        'scale': '${scale}x',
        'size': sizeName
      };
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

/// Wrapper to allow generation of the Contents.json file used by Apple's Asset
/// Catalog "App Icon Type":
/// https://developer.apple.com/library/archive/documentation/Xcode/Reference/xcode_ref-Asset_Catalog_Format/AppIconType.html
class AppleAppIconType {
  /// Provide a list of [images] to be created in your Asset set, whose
  /// Contents.json file can be written out to [assetPath].
  const AppleAppIconType({
    required this.images,
    required this.assetPath,
    this.darkImages,
    this.tintedImages,
  });

  /// The meta data for each asset file to create.
  final List<AppleIconTemplate> images;
  final List<AppleIconTemplate>? darkImages;
  final List<AppleIconTemplate>? tintedImages;

  /// Where to write out the Contents.json file.
  final String assetPath;

  /// For use with a [JsonEncoder] to generate this Asset's Contents.json file.
  Map<String, dynamic> toJson() {
    final imagesMap = <Map<String, dynamic>>[];
    imagesMap.addAll(images.map((e) => e.toJson()));

    if (darkImages != null) {
      imagesMap.addAll(darkImages!.map((e) => e.toJson()));
    }

    if (tintedImages != null) {
      imagesMap.addAll(tintedImages!.map((e) => e.toJson()));
    }

    return <String, dynamic>{
      'images': imagesMap,
      'info': {
        'author': 'icons_launcher',
        'version': 1,
      }
    };
  }

  /// Writes out the Contents.json file.
  void saveContentsJson() {
    final file = File('${assetPath}Contents.json');
    const encoder = JsonEncoder.withIndent('  ');
    file.writeAsStringSync(encoder.convert(this), flush: true);
    CliLogger.success(
      'Generated `Contents.json` file',
      level: CliLoggerLevel.two,
    );
  }
}
