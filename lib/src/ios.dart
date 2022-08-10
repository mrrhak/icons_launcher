part of icons_launcher_cli;

/// Generates a list of IosIconTemplates according to the parameters:
///
/// [size] is the image size @1x scale to use in pixels.
/// [sizeName] if not provided will use the naming scheme: '\<size>x\<size>',
/// where \<size> is the rounded [size] value.
/// [scales] are the different size multiples for which we will generate images.
/// [idiom] is the device family name to use within the Asset Catalog's
/// description of each icon generated.
List<IosIconTemplate> _createIosTemplates(
    {required double size,
    String? sizeName,
    required List<int> scales,
    required String idiom}) {
  final templates = <IosIconTemplate>[];
  sizeName ??= '${size.round()}x${size.round()}';
  for (int scale in scales) {
    final scaledSize = (size * scale).round();
    templates.add(IosIconTemplate(
        sizeName: sizeName,
        scaledSize: scaledSize,
        scale: scale,
        idiom: idiom));
  }
  return templates;
}

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
    ..._createIosTemplates(size: 20, scales: [2, 3], idiom: 'iphone'),
    ..._createIosTemplates(size: 29, scales: [1, 2, 3], idiom: 'iphone'),
    ..._createIosTemplates(size: 40, scales: [2, 3], idiom: 'iphone'),
    ..._createIosTemplates(size: 60, scales: [2, 3], idiom: 'iphone'),
    ..._createIosTemplates(size: 20, scales: [1, 2], idiom: 'ipad'),
    ..._createIosTemplates(size: 29, scales: [1, 2], idiom: 'ipad'),
    ..._createIosTemplates(size: 40, scales: [1, 2], idiom: 'ipad'),
    ..._createIosTemplates(size: 76, scales: [1, 2], idiom: 'ipad'),
    ..._createIosTemplates(
        size: 83.5, sizeName: '83.5x83.5', scales: [2], idiom: 'ipad'),
    ..._createIosTemplates(size: 1024, scales: [1], idiom: 'ios-marketing'),
    // The following sizes are only for iOS 6.1 or earlier, which flutter does
    // not support re:
    // https://developer.apple.com/library/archive/qa/qa1686/_index.html
    //..._createIosTemplates(size: 57, scales: [1, 2], idiom: 'iphone'),
    //..._createIosTemplates(size: 50, scales: [1, 2], idiom: 'ipad'),
    //..._createIosTemplates(size: 72, scales: [1, 2], idiom: 'ipad'),
  ];

  final filenames = <String>{};
  for (final template in iosIcons) {
    // Multiple icon variants can use the same file, so check if we already
    // created it.
    if (filenames.contains(template.filename) == false) {
      filenames.add(template.filename);
      _saveImageIos(template, image);
    }
  }
  CliLogger.success('Generated app icon images', level: CliLoggerLevel.two);
  AppleAppIconType(
          images: iosIcons, assetPath: _flavorHelper.iOSAssetsAppIconFolder)
      .saveContentsJson();
}

/// Save ios image
void _saveImageIos(IosIconTemplate template, Icon image) {
  final filePath =
      '${_flavorHelper.iOSAssetsAppIconFolder}${template.filename}';
  image.saveResizedPng(template.scaledSize, filePath);
}
