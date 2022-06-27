part of icons_launcher_cli;

void _createMacOSIcons({required String imagePath}) {
  CliLogger.info('Creating macOS icons...');

  final image = Icon.loadFile(imagePath);
  if (image == null) {
    CliLogger.error('The file $imagePath could not be read.',
        level: CliLoggerLevel.two);
    exit(1);
  }

  final macosIcons = <MacOSIconTemplate>[
    MacOSIconTemplate(name: '_16', size: 16),
    MacOSIconTemplate(name: '_32', size: 32),
    MacOSIconTemplate(name: '_64', size: 64),
    MacOSIconTemplate(name: '_128', size: 128),
    MacOSIconTemplate(name: '_256', size: 256),
    MacOSIconTemplate(name: '_512', size: 512),
    MacOSIconTemplate(name: '_1024', size: 1024),
  ];

  for (final template in macosIcons) {
    _saveImageMacOS(template, image);
  }

  CliLogger.success('Generated app icon images', level: CliLoggerLevel.two);
}

void _saveImageMacOS(MacOSIconTemplate template, Icon image) {
  final filePath =
      '$MACOS_DEFAULT_APP_ICON_DIR$MACOS_DEFAULT_ICON_NAME${template.name}.png';
  image.saveResizedPng(template.size, filePath);
}
