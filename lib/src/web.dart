part of icons_launcher_cli;

/// Start create web icons
void _createWebIcons({required String imagePath}) {
  CliLogger.info('Creating Web icons...');

  final image = Icon.loadFile(imagePath);
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
}

/// Start create web favicon
void _createWebFavicon({required String imagePath}) {
  final image = Icon.loadFile(imagePath);
  if (image == null) {
    CliLogger.error('The file $imagePath could not be read.',
        level: CliLoggerLevel.two);
    exit(1);
  }

  final webFavicon = WebIconTemplate(name: 'favicon.png', size: 16);
  _saveFaviconImageWeb(webFavicon, image);
  CliLogger.success('Generated favicon image', level: CliLoggerLevel.two);
}

/// Save web image
void _saveImageWeb(WebIconTemplate template, Icon image) {
  image.saveResizedPng(template.size, '$WEB_DEFAULT_ICON_DIR${template.name}');
}

/// Save favicon image
void _saveFaviconImageWeb(WebIconTemplate template, Icon image) {
  image.saveResizedPng(
      template.size, '$WEB_DEFAULT_FAVICON_DIR${template.name}');
}
