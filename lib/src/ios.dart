part of '../cli_commands.dart';

/// Generates a list of IosIconTemplates according to the parameters:
///
/// [size] is the image size @1x scale to use in pixels.
/// [sizeName] if not provided will use the naming scheme: '\<size>x\<size>',
/// where \<size> is the rounded [size] value.
/// [scales] are the different size multiples for which we will generate images.
/// [idiom] is the device family name to use within the Asset Catalog's
/// description of each icon generated. default: universal
List<IosIconTemplate> _createIosTemplates(
    {required double size,
    String? sizeName,
    required List<int> scales,
    String? idiom}) {
  final templates = <IosIconTemplate>[];
  sizeName ??= '${size.round()}x${size.round()}';
  for (var scale in scales) {
    final scaledSize = scale == 0 ? size.round() : (size * scale).round();

    templates.add(IosIconTemplate(
      sizeName: sizeName,
      scaledSize: scaledSize,
      scale: scale,
      idiom: idiom ?? 'universal',
    ));
  }

  return templates;
}

/// Start create ios icons
void createIosIcons({required String imagePath}) {
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

  // https://developer.apple.com/design/human-interface-guidelines/app-icons
  final iosIcons = <IosIconTemplate>[
    ..._createIosTemplates(size: 20, scales: [2, 3]),
    // Settings on iPhone, iPad Pro, iPad, iPad mini (58, 87)
    ..._createIosTemplates(size: 29, scales: [2, 3]),
    // Notifications on iPhone, iPad Pro, iPad, iPad mini (76, 114)
    ..._createIosTemplates(size: 38, scales: [2, 3]),
    // Spotlight on iPhone, iPad Pro, iPad, iPad mini (80, 120)
    ..._createIosTemplates(size: 40, scales: [2, 3]),
    // Home Screen on iPhone (120, 180)
    ..._createIosTemplates(size: 60, scales: [2, 3]),
    ..._createIosTemplates(size: 64, scales: [2, 3]),
    ..._createIosTemplates(size: 68, scales: [2]),
    // Home Screen on iPad, iPad mini (152)
    ..._createIosTemplates(size: 76, scales: [2]),
    // Home Screen on iPad Pro (167)
    ..._createIosTemplates(size: 83.5, sizeName: '83.5x83.5', scales: [2]),
    ..._createIosTemplates(size: 1024, scales: [0]),
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
    images: iosIcons,
    assetPath: _flavorHelper.iOSAssetsAppIconFolder,
  ).saveContentsJson();
}

/// Save ios image
void _saveImageIos(IosIconTemplate template, Icon image) {
  final filePath =
      '${_flavorHelper.iOSAssetsAppIconFolder}${template.filename}';
  image.saveResizedPng(template.scaledSize, filePath);
}
