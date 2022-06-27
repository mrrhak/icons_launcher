part of icons_launcher_cli;

/// Start create ios icons
void _createIosIcons({required String imagePath}) {
  CliLogger.info('Creating iOS icons...');

  final image = Icon.loadFile(imagePath);
  if (image == null) {
    CliLogger.error('The file $imagePath could not be read.',
        level: CliLoggerLevel.two);
    exit(1);
  }

  if (image.hasAlpha) {
    CliLogger.warning('App icon for iOS/iPadOS not support alpha channel',
        level: CliLoggerLevel.two);
    image.removeAlpha();
    CliLogger.success('Removed alpha channel from icon',
        level: CliLoggerLevel.two);
  }

  final iosIcons = <IosIconTemplate>[
    IosIconTemplate(name: '-20x20@1x', size: 20),
    IosIconTemplate(name: '-20x20@2x', size: 40),
    IosIconTemplate(name: '-20x20@3x', size: 60),
    IosIconTemplate(name: '-29x29@1x', size: 29),
    IosIconTemplate(name: '-29x29@2x', size: 58),
    IosIconTemplate(name: '-29x29@3x', size: 87),
    IosIconTemplate(name: '-40x40@1x', size: 40),
    IosIconTemplate(name: '-40x40@2x', size: 80),
    IosIconTemplate(name: '-40x40@3x', size: 120),
    IosIconTemplate(name: '-50x50@1x', size: 50),
    IosIconTemplate(name: '-50x50@2x', size: 100),
    IosIconTemplate(name: '-57x57@1x', size: 57),
    IosIconTemplate(name: '-57x57@2x', size: 114),
    IosIconTemplate(name: '-60x60@2x', size: 120),
    IosIconTemplate(name: '-60x60@3x', size: 180),
    IosIconTemplate(name: '-72x72@1x', size: 72),
    IosIconTemplate(name: '-72x72@2x', size: 144),
    IosIconTemplate(name: '-76x76@1x', size: 76),
    IosIconTemplate(name: '-76x76@2x', size: 152),
    IosIconTemplate(name: '-83.5x83.5@2x', size: 167),
    IosIconTemplate(name: '-1024x1024@1x', size: 1024),
  ];

  for (final template in iosIcons) {
    _saveImageIos(template, image);
  }

  CliLogger.success('Generated app icon images', level: CliLoggerLevel.two);
}

/// Save ios image
void _saveImageIos(IosIconTemplate template, Icon image) {
  final filePath =
      '$IOS_DEFAULT_ICON_DIR$IOS_DEFAULT_ICON_NAME${template.name}.png';
  image.saveResizedPng(template.size, filePath);
}
