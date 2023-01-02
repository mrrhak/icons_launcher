part of icons_launcher_cli;

/// Start create chrome extension icons
void _createChromeExtensionIcons({required String imagePath}) {
  CliLogger.info('Creating Chrome Extension icons...');
  final image = Icon.loadFile(imagePath);
  if (image == null) {
    CliLogger.error('The file $imagePath could not be read.',
        level: CliLoggerLevel.two);
    exit(1);
  }
  final webIcons = <WebIconTemplate>[
    WebIconTemplate(name: 'icon16.png', size: 16),
    WebIconTemplate(name: 'icon32.png', size: 32),
    WebIconTemplate(name: 'icon48.png', size: 48),
    WebIconTemplate(name: 'icon128.png', size: 128),
  ];

  for (final template in webIcons) {
    _saveImageWeb(template, image);
  }
  CliLogger.success('Generated icon images', level: CliLoggerLevel.two);
}
