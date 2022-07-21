import 'package:icons_launcher/constants.dart';
import 'package:icons_launcher/utils.dart';

import '../icon.dart';

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

/// Overwrites the default favicon
void overwriteDefaultFavicon(WebIconTemplate template, Icon image) {
  image.saveResizedPng(
    template.size,
    webDefaultFaviconFolder + template.name + '.png',
  );
}

/// Overwrites the default icons
void overwriteDefaultIcons(WebIconTemplate template, Icon image) {
  try {
    image.saveResizedPng(
      template.size,
      webDefaultIconFolder + template.name + '.png',
    );
  } catch (e) {
    print(e);
  }
}

/// Creates new favicon
void saveNewFavicon(WebIconTemplate template, Icon image) {
  image.saveResizedPng(
    template.size,
    webDefaultFaviconFolder + template.name + '.png',
  );
}

/// Creates new icons
void saveNewIcons(WebIconTemplate template, Icon image) {
  image.saveResizedPng(
    template.size,
    webDefaultIconFolder + template.name + '.png',
  );
}

/// Create icons
void createIcons(Map<String, dynamic> config, String? flavor) {
  final String filePath = config['image_path_web'] ?? config['image_path'];
  final String faviconPath = config['favicon_path'] ?? filePath;
  // decodeImageFile shows error message if null
  // so can return here if image is null
  final image = Icon.loadFile(filePath);
  final favicon = Icon.loadFile(faviconPath);
  if (image == null || favicon == null) {
    return;
  }

  final dynamic webConfig = config['web'];
  if (flavor != null) {
    printStatus('Building Web launcher icon for $flavor');
    saveNewFavicon(webFavicon, favicon);
    for (WebIconTemplate template in webIcons) {
      saveNewIcons(template, image);
    }
  } else if (webConfig is String) {
    // If the Web configuration is a string then the user has specified a new icon to be created
    // and for the old icon file to be kept
    printStatus('Adding new Web launcher icon');
    saveNewFavicon(webFavicon, favicon);
    for (WebIconTemplate template in webIcons) {
      saveNewIcons(template, image);
    }
  }
  // Otherwise the user wants the new icon to use the default icons name and
  // update config file to use it
  else {
    printStatus('Overwriting default Web launcher icon with new icon');
    overwriteDefaultFavicon(webFavicon, favicon);
    for (WebIconTemplate template in webIcons) {
      overwriteDefaultIcons(template, image);
    }
  }
}
