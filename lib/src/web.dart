part of '../cli_commands.dart';

/// Start create web icons
void createWebIcons({required String imagePath, String? maskableImagePath}) {
  CliLogger.info('Creating Web icons...', emoji: '🌐');

  final image = Icon.loadFile(imagePath);
  if (image == null) {
    CliLogger.error('The file $imagePath could not be read.', level: .two);
    exit(1);
  }

  final maskableImageFile =
      (maskableImagePath == null || maskableImagePath == imagePath)
      ? image
      : Icon.loadFile(maskableImagePath);
  if (maskableImageFile == null) {
    CliLogger.error(
      'The file ${maskableImagePath!} could not be read.',
      level: .two,
    );
    exit(1);
  }

  final webIcons = <WebIconTemplate>[
    WebIconTemplate(name: 'Icon-192.png', size: 192),
    WebIconTemplate(name: 'Icon-512.png', size: 512),
  ];

  for (final template in webIcons) {
    _saveImageWeb(template, image);
  }

  final pwaIcons = <WebIconTemplate>[
    WebIconTemplate(name: 'Icon-maskable-192.png', size: 192),
    WebIconTemplate(name: 'Icon-maskable-512.png', size: 512),
  ];

  for (final template in pwaIcons) {
    _saveImageWeb(template, maskableImageFile);
  }

  CliLogger.success('Generated icon images', level: .two);
}

/// Start create web favicon
void createWebFavicon({
  required String imagePath,
  String faviconOutputExtension = '.png',
}) {
  final image = Icon.loadFile(imagePath);
  if (image == null) {
    CliLogger.error('The file $imagePath could not be read.', level: .two);
    exit(1);
  }

  final fileName = faviconOutputExtension.endsWith('ico')
      ? 'favicon.ico'
      : 'favicon.png';

  if (faviconOutputExtension.endsWith('ico')) {
    final templates = [
      WebIconTemplate(name: fileName, size: 16),
      WebIconTemplate(name: fileName, size: 32),
      WebIconTemplate(name: fileName, size: 48),
    ];
    _saveFaviconIcoWeb(templates, fileName, image);
    CliLogger.success('Generated favicon ico image', level: .two);
  } else {
    final template = WebIconTemplate(name: fileName, size: 48);
    _saveFaviconPngWeb(template, image);
    CliLogger.success('Generated favicon png image', level: .two);
  }

  // Remove the old favicon if it exists
  final oldFileName = faviconOutputExtension.endsWith('ico')
      ? 'favicon.png'
      : 'favicon.ico';
  final oldFaviconFile = File('$WEB_DEFAULT_FAVICON_DIR$oldFileName');
  if (oldFaviconFile.existsSync()) {
    oldFaviconFile.deleteSync();
  }

  // Update index.html
  final indexHtmlFile = File('${WEB_DEFAULT_FAVICON_DIR}index.html');
  if (indexHtmlFile.existsSync()) {
    var content = indexHtmlFile.readAsStringSync();
    final newType = faviconOutputExtension.endsWith('ico')
        ? 'image/x-icon'
        : 'image/png';

    final regex = RegExp(r'<link rel="icon"([^>]+)>', multiLine: true);
    content = content.replaceAllMapped(regex, (match) {
      var tagInfo = match.group(1)!;
      tagInfo = tagInfo.replaceAll(
        RegExp(r'href="[^"]*"|href=\x27[^\x27]*\x27'),
        'href="$fileName"',
      );
      if (tagInfo.contains('type=')) {
        tagInfo = tagInfo.replaceAll(
          RegExp(r'type="[^"]*"|type=\x27[^\x27]*\x27'),
          'type="$newType"',
        );
      } else {
        if (tagInfo.endsWith('/')) {
          tagInfo =
              '${tagInfo.substring(0, tagInfo.length - 1)} type="$newType"/';
        } else {
          tagInfo += ' type="$newType"';
        }
      }
      return '<link rel="icon"$tagInfo>';
    });

    indexHtmlFile.writeAsStringSync(content);
  }

  CliLogger.success('Updated index.html', level: .two);
}

/// Save web image
void _saveImageWeb(WebIconTemplate template, Icon image) {
  image.saveResizedPng(template.size, '$WEB_DEFAULT_ICON_DIR${template.name}');
}

/// Save favicon png
void _saveFaviconPngWeb(WebIconTemplate template, Icon image) {
  image.saveResizedPng(
    template.size,
    '$WEB_DEFAULT_FAVICON_DIR${template.name}',
  );
}

/// Save favicon ico
void _saveFaviconIcoWeb(
  List<WebIconTemplate> templates,
  String fileName,
  Icon image,
) {
  final images = <Icon>[];
  for (final template in templates) {
    final resizedImage = image.copyResized(template.size);
    images.add(resizedImage);
  }

  Icon.saveIco(images, '$WEB_DEFAULT_FAVICON_DIR$fileName');
}
