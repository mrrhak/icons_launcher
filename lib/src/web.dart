part of icons_launcher_cli;

void _createWebIcons({required String imagePath}) {
  CliLogger.info('Creating Web icons...');

  final image = decodeImage(File(imagePath).readAsBytesSync());
  if (image == null) {
    CliLogger.error('The file $imagePath could not be read.',
        level: CliLoggerLevel.two);
    exit(1);
  }

  final webIcons = <WebIconTemplate>[
    WebIconTemplate(name: 'Icon-192.png', size: 192),
    WebIconTemplate(name: 'Icon-512.png', size: 512),
    WebIconTemplate(name: 'Icon-maskable-192.png', size: 192),
    WebIconTemplate(name: 'Icon-maskable-512.png', size: 512),
  ];

  for (final template in webIcons) {
    _saveImageWeb(template, image);
  }
  CliLogger.success('Generated icon images', level: CliLoggerLevel.two);

  final webFavicon = WebIconTemplate(name: 'favicon.png', size: 16);
  _saveFaviconImageWeb(webFavicon, image);
  CliLogger.success('Generated favicon image', level: CliLoggerLevel.two);
}

void _saveImageWeb(WebIconTemplate template, Image image) {
  final resizedImage = createResizedImage(template.size, image);
  final file = File('$WEB_DEFAULT_ICON_DIR${template.name}');
  file.createSync(recursive: true);
  file.writeAsBytesSync(encodePng(resizedImage));
}

void _saveFaviconImageWeb(WebIconTemplate template, Image image) {
  final resizedImage = createResizedImage(template.size, image);
  final file = File('$WEB_DEFAULT_FAVICON_DIR${template.name}');
  file.createSync(recursive: true);
  file.writeAsBytesSync(encodePng(resizedImage));
}
