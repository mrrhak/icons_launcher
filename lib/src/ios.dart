part of '../cli_commands.dart';

/// Generates a list of IosIconTemplates according to the parameters:
///
/// [size] is the image size @1x scale to use in pixels.
/// [sizeName] if not provided will use the naming scheme: '\<size>x\<size>',
/// where \<size> is the rounded [size] value.
/// [scales] are the different size multiples for which we will generate images.
/// [idiom] is the device family name to use within the Asset Catalog's
/// [platform] is the platform name to use within the
/// [appearances] are the different appearances
/// description of each icon generated. default: universal
List<IosIconTemplate> _createIosTemplates({
  required double size,
  String? sizeName,
  required List<int> scales,
  String? idiom,
  String? platform,
  List<IconAppearance>? appearances,
}) {
  final templates = <IosIconTemplate>[];
  sizeName ??= '${size.round()}x${size.round()}';
  for (var scale in scales) {
    final scaledSize = scale == 0 ? size.round() : (size * scale).round();

    templates.add(IosIconTemplate(
      sizeName: sizeName,
      scaledSize: scaledSize,
      scale: scale,
      idiom: idiom ?? 'universal',
      platform: platform,
      appearances: appearances,
    ));
  }

  return templates;
}

/// Start create ios icons
void createIosIcons({
  required String imagePath,
  final String? darkPath,
  final String? tintedPath,
}) {
  CliLogger.info('Creating iOS icons...');

  final image = Icon.loadFile(imagePath);
  if (image == null) {
    CliLogger.error(
      'The file $imagePath could not be read.',
      level: CliLoggerLevel.two,
    );
    exit(1);
  }

  if (image.hasAlpha) {
    CliLogger.warning('App icon for iOS/iPadOS not support alpha channel',
        level: CliLoggerLevel.two);
    image.removeAlpha();
    CliLogger.success('Removed alpha channel from icon',
        level: CliLoggerLevel.two);
  }

  Icon? darkImage;
  if (darkPath != null) {
    darkImage = Icon.loadFile(darkPath);
    if (darkImage == null) {
      CliLogger.error('The file $darkPath could not be read.',
          level: CliLoggerLevel.two);
      exit(1);
    }
  }

  Icon? tintedImage;
  if (tintedPath != null) {
    tintedImage = Icon.loadFile(tintedPath);
    if (tintedImage == null) {
      CliLogger.error('The file $tintedPath could not be read.',
          level: CliLoggerLevel.two);
      exit(1);
    }
  }

  // https://developer.apple.com/design/human-interface-guidelines/app-icons
  final iosIcons = <IosIconTemplate>[
    ..._createIosTemplates(
      size: 20,
      platform: 'ios',
      idiom: 'universal',
      scales: [2, 3],
    ),
    ..._createIosTemplates(
      size: 29,
      platform: 'ios',
      idiom: 'universal',
      scales: [2, 3],
    ),
    ..._createIosTemplates(
      size: 38,
      platform: 'ios',
      idiom: 'universal',
      scales: [2, 3],
    ),
    ..._createIosTemplates(
      size: 40,
      platform: 'ios',
      idiom: 'universal',
      scales: [2, 3],
    ),
    ..._createIosTemplates(
      size: 60,
      platform: 'ios',
      idiom: 'universal',
      scales: [2, 3],
    ),
    ..._createIosTemplates(
      size: 64,
      platform: 'ios',
      idiom: 'universal',
      scales: [2, 3],
    ),
    ..._createIosTemplates(
      size: 68,
      platform: 'ios',
      idiom: 'universal',
      scales: [2],
    ),
    ..._createIosTemplates(
      size: 76,
      platform: 'ios',
      idiom: 'universal',
      scales: [2],
    ),
    ..._createIosTemplates(
      size: 83.5,
      platform: 'ios',
      idiom: 'universal',
      sizeName: '83.5x83.5',
      scales: [2],
    ),
    ..._createIosTemplates(
      size: 1024,
      platform: 'ios',
      idiom: 'universal',
      scales: [1],
    ),
  ];

  final iosDarkIcons = <IosIconTemplate>[
    ..._createIosTemplates(
      size: 20,
      platform: 'ios',
      idiom: 'universal',
      scales: [2, 3],
      appearances: [IconAppearance(appearance: 'luminosity', value: 'dark')],
    ),
    ..._createIosTemplates(
      size: 29,
      platform: 'ios',
      idiom: 'universal',
      scales: [2, 3],
      appearances: [IconAppearance(appearance: 'luminosity', value: 'dark')],
    ),
    ..._createIosTemplates(
      size: 38,
      platform: 'ios',
      idiom: 'universal',
      scales: [2, 3],
      appearances: [IconAppearance(appearance: 'luminosity', value: 'dark')],
    ),
    ..._createIosTemplates(
      size: 40,
      platform: 'ios',
      idiom: 'universal',
      scales: [2, 3],
      appearances: [IconAppearance(appearance: 'luminosity', value: 'dark')],
    ),
    ..._createIosTemplates(
      size: 60,
      platform: 'ios',
      idiom: 'universal',
      scales: [2, 3],
      appearances: [IconAppearance(appearance: 'luminosity', value: 'dark')],
    ),
    ..._createIosTemplates(
      size: 64,
      platform: 'ios',
      idiom: 'universal',
      scales: [2, 3],
      appearances: [IconAppearance(appearance: 'luminosity', value: 'dark')],
    ),
    ..._createIosTemplates(
      size: 68,
      platform: 'ios',
      idiom: 'universal',
      scales: [2],
      appearances: [IconAppearance(appearance: 'luminosity', value: 'dark')],
    ),
    ..._createIosTemplates(
      size: 76,
      platform: 'ios',
      idiom: 'universal',
      scales: [2],
      appearances: [IconAppearance(appearance: 'luminosity', value: 'dark')],
    ),
    ..._createIosTemplates(
      size: 83.5,
      platform: 'ios',
      idiom: 'universal',
      sizeName: '83.5x83.5',
      scales: [2],
      appearances: [IconAppearance(appearance: 'luminosity', value: 'dark')],
    ),
    ..._createIosTemplates(
      size: 1024,
      platform: 'ios',
      idiom: 'universal',
      scales: [1],
      appearances: [IconAppearance(appearance: 'luminosity', value: 'dark')],
    ),
  ];

  final iosTintedIcons = <IosIconTemplate>[
    ..._createIosTemplates(
      size: 20,
      platform: 'ios',
      idiom: 'universal',
      scales: [2, 3],
      appearances: [IconAppearance(appearance: 'luminosity', value: 'tinted')],
    ),
    ..._createIosTemplates(
      size: 29,
      platform: 'ios',
      idiom: 'universal',
      scales: [2, 3],
      appearances: [IconAppearance(appearance: 'luminosity', value: 'tinted')],
    ),
    ..._createIosTemplates(
      size: 38,
      platform: 'ios',
      idiom: 'universal',
      scales: [2, 3],
      appearances: [IconAppearance(appearance: 'luminosity', value: 'tinted')],
    ),
    ..._createIosTemplates(
      size: 40,
      platform: 'ios',
      idiom: 'universal',
      scales: [2, 3],
      appearances: [IconAppearance(appearance: 'luminosity', value: 'tinted')],
    ),
    ..._createIosTemplates(
      size: 60,
      platform: 'ios',
      idiom: 'universal',
      scales: [2, 3],
      appearances: [IconAppearance(appearance: 'luminosity', value: 'tinted')],
    ),
    ..._createIosTemplates(
      size: 64,
      platform: 'ios',
      idiom: 'universal',
      scales: [2, 3],
      appearances: [IconAppearance(appearance: 'luminosity', value: 'tinted')],
    ),
    ..._createIosTemplates(
      size: 68,
      platform: 'ios',
      idiom: 'universal',
      scales: [2],
      appearances: [IconAppearance(appearance: 'luminosity', value: 'tinted')],
    ),
    ..._createIosTemplates(
      size: 76,
      platform: 'ios',
      idiom: 'universal',
      scales: [2],
      appearances: [IconAppearance(appearance: 'luminosity', value: 'tinted')],
    ),
    ..._createIosTemplates(
      size: 83.5,
      platform: 'ios',
      idiom: 'universal',
      sizeName: '83.5x83.5',
      scales: [2],
      appearances: [IconAppearance(appearance: 'luminosity', value: 'tinted')],
    ),
    ..._createIosTemplates(
      size: 1024,
      platform: 'ios',
      idiom: 'universal',
      scales: [1],
      appearances: [IconAppearance(appearance: 'luminosity', value: 'tinted')],
    ),
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
  CliLogger.success('Generated app light icons', level: CliLoggerLevel.two);

  // https://github.com/fluttercommunity/flutter_launcher_icons/pull/569/files
  if (darkImage != null) {
    final darkFilenames = <String>{};
    for (final template in iosDarkIcons) {
      // Multiple icon variants can use the same file, so check if we already
      // created it.
      if (darkFilenames.contains(template.filename) == false) {
        darkFilenames.add(template.filename);
        _saveImageIos(template, darkImage);
      }
    }

    CliLogger.success('Generated app dark icons', level: CliLoggerLevel.two);
  }

  if (tintedImage != null) {
    final tintedFilenames = <String>{};
    for (final template in iosTintedIcons) {
      // Multiple icon variants can use the same file, so check if we already
      // created it.
      if (tintedFilenames.contains(template.filename) == false) {
        tintedFilenames.add(template.filename);
        _saveImageIos(template, tintedImage);
      }
    }

    CliLogger.success('Generated app tinted icons', level: CliLoggerLevel.two);
  }

  AppleAppIconType(
    images: iosIcons,
    darkImages: darkImage != null ? iosDarkIcons : null,
    tintedImages: tintedImage != null ? iosTintedIcons : null,
    assetPath: _flavorHelper.iOSAssetsAppIconFolder,
  ).saveContentsJson();
}

/// Save ios image
void _saveImageIos(IosIconTemplate template, Icon image) {
  final filePath =
      '${_flavorHelper.iOSAssetsAppIconFolder}${template.filename}';
  image.saveResizedPng(template.scaledSize, filePath);
}
