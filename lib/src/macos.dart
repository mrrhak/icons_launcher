part of '../cli_commands.dart';

/// Generates templates according to the parameters:
///
/// [size] is the image size @1x scale to use in pixels.
/// [scales] are the different size multiples for which we will generate images.
List<MacOSIconTemplate> _createMacTemplates(
    {required int size, required List<int> scales}) {
  final templates = <MacOSIconTemplate>[];
  for (var scale in scales) {
    templates.add(MacOSIconTemplate(
        sizeName: '${size}x$size',
        scaledSize: size * scale,
        scale: scale,
        idiom: 'mac'));
  }
  return templates;
}

/// Start create macos icons
void createMacOSIcons({required String imagePath}) {
  CliLogger.info('Creating macOS icons...');

  final image = Icon.loadFile(imagePath);
  if (image == null) {
    CliLogger.error('The file $imagePath could not be read.',
        level: CliLoggerLevel.two);
    exit(1);
  }

  final macosIcons = <MacOSIconTemplate>[
    ..._createMacTemplates(size: 16, scales: [1, 2]),
    ..._createMacTemplates(size: 32, scales: [1, 2]),
    ..._createMacTemplates(size: 128, scales: [1, 2]),
    ..._createMacTemplates(size: 256, scales: [1, 2]),
    ..._createMacTemplates(size: 512, scales: [1, 2]),
  ];

  final filenames = <String>{};
  for (final template in macosIcons) {
    if (filenames.contains(template.filename) == false) {
      filenames.add(template.filename);
      _saveImageMacOS(template, image);
    }
  }
  CliLogger.success('Generated app icon images', level: CliLoggerLevel.two);
  AppleAppIconType(
          images: macosIcons, assetPath: _flavorHelper.macOSAssetsAppIconFolder)
      .saveContentsJson();
}

/// Save macos image
void _saveImageMacOS(MacOSIconTemplate template, Icon image) {
  final filePath =
      '${_flavorHelper.macOSAssetsAppIconFolder}${template.filename}';
  image.saveResizedPng(template.scaledSize, filePath);
}
