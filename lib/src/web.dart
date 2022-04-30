import 'dart:io';

import 'package:icons_launcher/constants.dart';
import 'package:icons_launcher/utils.dart';
import 'package:image/image.dart';

/// File to handle the creation of icons for Web platform
class WebIconTemplate {
  WebIconTemplate({required this.size, required this.name});

  final String name;
  final int size;
}

List<WebIconTemplate> webIcons = <WebIconTemplate>[
  WebIconTemplate(name: 'Icon-192', size: 192),
  WebIconTemplate(name: 'Icon-512', size: 512),
  WebIconTemplate(name: 'Icon-maskable-192', size: 192),
  WebIconTemplate(name: 'Icon-maskable-512', size: 512),
];

WebIconTemplate webFavicon = WebIconTemplate(name: 'favicon', size: 16);

/// Creates icons with resize
Image createResizedImage(WebIconTemplate template, Image image) {
  if (image.width >= template.size) {
    return copyResize(image,
        width: template.size,
        height: template.size,
        interpolation: Interpolation.average);
  } else {
    return copyResize(image,
        width: template.size,
        height: template.size,
        interpolation: Interpolation.linear);
  }
}

/// Overwrites the default favicon
void overwriteDefaultFavicon(WebIconTemplate template, Image image) {
  final Image newFile = createResizedImage(template, image);
  File(webDefaultFaviconFolder + template.name + '.png')
    ..writeAsBytesSync(encodePng(newFile));
}

/// Overwrites the default icons
void overwriteDefaultIcons(WebIconTemplate template, Image image) {
  try {
    final Image newFile = createResizedImage(template, image);
    File(webDefaultIconFolder + template.name + '.png')
      ..writeAsBytesSync(encodePng(newFile));
  } catch (e) {
    print(e);
  }
}

/// Creates new favicon
void saveNewFavicon(WebIconTemplate template, Image image) {
  final Image newFile = createResizedImage(template, image);
  File(webDefaultFaviconFolder + template.name + '.png')
      .create(recursive: true)
      .then((File file) {
    file.writeAsBytesSync(encodePng(newFile));
  });
}

/// Creates new icons
void saveNewIcons(WebIconTemplate template, Image image) {
  final Image newFile = createResizedImage(template, image);
  File(webDefaultIconFolder + template.name + '.png')
      .create(recursive: true)
      .then((File file) {
    file.writeAsBytesSync(encodePng(newFile));
  });
}

/// Create icons
void createIcons(Map<String, dynamic> config, String? flavor) {
  final String filePath = config['image_path_web'] ?? config['image_path'];
  // decodeImageFile shows error message if null
  // so can return here if image is null
  final Image? image = decodeImage(File(filePath).readAsBytesSync());
  if (image == null) {
    return;
  }

  final dynamic webConfig = config['web'];
  if (flavor != null) {
    printStatus('Building Web icon launcher for $flavor');
    saveNewFavicon(webFavicon, image);
    for (WebIconTemplate template in webIcons) {
      saveNewIcons(template, image);
    }
  } else if (webConfig is String) {
    // If the Web configuration is a string then the user has specified a new icon to be created
    // and for the old icon file to be kept
    printStatus('Adding new Web icon launcher');
    saveNewFavicon(webFavicon, image);
    for (WebIconTemplate template in webIcons) {
      saveNewIcons(template, image);
    }
  }
  // Otherwise the user wants the new icon to use the default icons name and
  // update config file to use it
  else {
    printStatus('Overwriting default Web icon launcher with new icon');
    overwriteDefaultFavicon(webFavicon, image);
    for (WebIconTemplate template in webIcons) {
      overwriteDefaultIcons(template, image);
    }
  }
}
