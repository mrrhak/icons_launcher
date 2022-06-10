part of icons_launcher_cli;

final androidIcons = <AndroidMipMapIconTemplate>[
  AndroidMipMapIconTemplate(directoryName: 'mipmap-mdpi', size: 48),
  AndroidMipMapIconTemplate(directoryName: 'mipmap-hdpi', size: 72),
  AndroidMipMapIconTemplate(directoryName: 'mipmap-xhdpi', size: 96),
  AndroidMipMapIconTemplate(directoryName: 'mipmap-xxhdpi', size: 144),
  AndroidMipMapIconTemplate(directoryName: 'mipmap-xxxhdpi', size: 192),
];

final adaptiveIcons = <AndroidMipMapIconTemplate>[
  AndroidMipMapIconTemplate(directoryName: 'mipmap-mdpi', size: 108),
  AndroidMipMapIconTemplate(directoryName: 'mipmap-hdpi', size: 162),
  AndroidMipMapIconTemplate(directoryName: 'mipmap-xhdpi', size: 216),
  AndroidMipMapIconTemplate(directoryName: 'mipmap-xxhdpi', size: 324),
  AndroidMipMapIconTemplate(directoryName: 'mipmap-xxxhdpi', size: 432),
];

void _createAndroidIcons({required String imagePath}) {
  CliLogger.info('Creating Android icons...');

  final image = decodeImage(File(imagePath).readAsBytesSync());
  if (image == null) {
    CliLogger.error('The file $imagePath could not be read.',
        level: CliLoggerLevel.two);
    exit(1);
  }

  for (final template in androidIcons) {
    _saveImageAndroid(template, image, ANDROID_ICON_FILE_NAME);
  }
  CliLogger.success(
    'Generated launcher icon images',
    level: CliLoggerLevel.two,
  );

  _createPlayStoreIcon(image);
  _updateAndroidManifestIconLauncher();
}

void _saveImageAndroid(
  AndroidMipMapIconTemplate template,
  Image image,
  String fileName,
) {
  final resizedImage = createResizedImage(template.size, image);

  // When the flavor value is not specified we will place all the data inside the main directory.
  // However if the flavor value is specified, we need to place the data in the correct directory.
  // Default: android/app/src/main/res/
  // With a flavor: android/app/src/[flavor name]/res/
  final file = File(
    '${_flavorHelper.androidResFolder}${template.directoryName}/$fileName',
  );
  file.createSync(recursive: true);
  file.writeAsBytesSync(encodePng(resizedImage));
}

void _createPlayStoreIcon(Image image) {
  final template = AndroidMipMapIconTemplate(
    directoryName: _flavorHelper.androidResFolder,
    size: 512,
  );
  final Image resizedImage = createResizedImage(template.size, image);

  final file =
      File('${template.directoryName}/$ANDROID_PLAYSTORE_ICON_FILE_NAME');
  file.createSync(recursive: true);
  file.writeAsBytesSync(encodePng(resizedImage));
}

void _updateAndroidManifestIconLauncher() {
  final androidManifestFile = File(ANDROID_MANIFEST_FILE);
  final androidManifestString = androidManifestFile.readAsStringSync();
  final manifestLines = androidManifestString.split('\n');

  final androidManifestUpdated = manifestLines.map((String line) {
    if (line.contains('android:icon')) {
      // Using RegExp replace the value of android:icon to point to the new icon
      // anything but a quote of any length: [^"]*
      // an escaped quote: \\" (escape slash, because it exists regex)
      // quote, no quote / quote with things behind : \"[^"]*
      // repeat as often as wanted with no quote at start: [^"]*(\"[^"]*)*
      // escaping the slash to place in string: [^"]*(\\"[^"]*)*"
      // result: any string which does only include escaped quotes
      return line.replaceAll(RegExp(r'android:icon="[^"]*(\\"[^"]*)*"'),
          'android:icon="@mipmap/$ANDROID_ICON_NAME"');
    } else {
      return line;
    }
  }).toList();

  androidManifestFile.writeAsStringSync(androidManifestUpdated.join('\n'));
  CliLogger.success(
    'Updated android manifest launcher icon',
    level: CliLoggerLevel.two,
  );
}

void _createAndroidAdaptiveIcon({
  required String background,
  required String foreground,
  String? round,
}) {
  String message = 'Creating Android adaptive icons...';
  if (round != null) {
    message = 'Creating Android adaptive icons with round...';
  }
  CliLogger.info(message);

  _createAdaptiveForeground(adaptiveIcons, foreground);
  _createAdaptiveBackground(adaptiveIcons, background);
  if (round != null) {
    _createAdaptiveRound(androidIcons, round);
  } else {
    _removeAndroidManifestIconLauncherRound();
  }
}

void _createAdaptiveBackground(
  List<AndroidMipMapIconTemplate> adaptiveIcons,
  String background,
) {
  // Check background is hexa color or image
  if (isValidHexaCode(background)) {
    _handleColorsXmlFile(background);
    _createIcLauncherColorXmlFile();
  } else {
    try {
      final file = File(background).readAsBytesSync();
      final backgroundImage = decodeImage(file);
      if (backgroundImage == null) {
        CliLogger.error(
          'The file $background could not be read.',
          level: CliLoggerLevel.two,
        );
        exit(1);
      }

      for (final template in adaptiveIcons) {
        _saveImageAndroid(
          template,
          backgroundImage,
          ANDROID_ADAPTIVE_BACKGROUND_ICON_FILE_NAME,
        );
      }
      CliLogger.success(
        'Generated adaptive background images',
        level: CliLoggerLevel.two,
      );
      _createIcLauncherMipMapXmlFile();
    } catch (e) {
      CliLogger.error(
        'Incorrect `$background` of `adaptive_background_color` or `adaptive_background_image`',
        level: CliLoggerLevel.two,
      );
      exit(1);
    }
  }
}

void _createAdaptiveForeground(
  List<AndroidMipMapIconTemplate> adaptiveIcons,
  String foreground,
) {
  final foregroundImage = decodeImage(File(foreground).readAsBytesSync());
  if (foregroundImage == null) {
    CliLogger.error(
      'The file $foreground could not be read.',
      level: CliLoggerLevel.two,
    );
    exit(1);
  }

  for (final template in adaptiveIcons) {
    _saveImageAndroid(
      template,
      foregroundImage,
      ANDROID_ADAPTIVE_FOREGROUND_ICON_FILE_NAME,
    );
  }
  CliLogger.success(
    'Generated adaptive foreground images',
    level: CliLoggerLevel.two,
  );
}

void _createAdaptiveRound(
  List<AndroidMipMapIconTemplate> adaptiveIcons,
  String round,
) {
  final roundImage = decodeImage(File(round).readAsBytesSync());
  if (roundImage == null) {
    CliLogger.error(
      'The file $round could not be read.',
      level: CliLoggerLevel.two,
    );
    exit(1);
  }

  for (final template in adaptiveIcons) {
    _saveImageAndroid(
      template,
      roundImage,
      ANDROID_ADAPTIVE_ROUND_ICON_FILE_NAME,
    );
  }
  CliLogger.success(
    'Generated adaptive round images',
    level: CliLoggerLevel.two,
  );
  _createIcLauncherRoundMipMapXmlFile();
  _createAndroidManifestIconLauncherRound();
}

void _handleColorsXmlFile(String backgroundColor) {
  final File colorsXml =
      File('${_flavorHelper.androidResFolder}$ANDROID_COLOR_FILE');
  if (colorsXml.existsSync()) {
    CliLogger.success(
      'Updated colors.xml with color `$backgroundColor`',
      level: CliLoggerLevel.two,
    );
    _updateColorsFile(colorsXml, backgroundColor);
  } else {
    CliLogger.success(
      'Created colors.xml with color `$backgroundColor`',
      level: CliLoggerLevel.two,
    );
    _createColorsFile(backgroundColor);
  }
}

void _createColorsFile(String backgroundColor) {
  String color = backgroundColor;

  if ((color.length == 4 || color.length == 7) && color.length != 9) {
    color = '#FF' + backgroundColor.replaceAll('#', '');
  } else {
    CliLogger.error(
      'Incorrect `$backgroundColor` of `adaptive_background_color`',
      level: CliLoggerLevel.two,
    );
    exit(1);
  }

  final file = File('${_flavorHelper.androidResFolder}$ANDROID_COLOR_FILE');
  file.createSync(recursive: true);
  file.writeAsStringSync(getColorXmlContent(color));
}

void _updateColorsFile(File colorsXml, String backgroundColor) {
  String color = backgroundColor;

  if ((color.length == 4 || color.length == 7) && color.length != 9) {
    color = '#FF' + backgroundColor.replaceAll('#', '');
  } else {
    CliLogger.error(
      'Incorrect `$backgroundColor` of `adaptive_background_color`',
      level: CliLoggerLevel.two,
    );
    exit(1);
  }

  final List<String> lines = colorsXml.readAsLinesSync();
  bool foundExisting = false;
  for (int x = 0; x < lines.length; x++) {
    String line = lines[x];
    if (line.contains('name="ic_launcher_background"')) {
      foundExisting = true;
      // replace anything between tags which does not contain another tag
      line = line.replaceAll(RegExp(r'>([^><]*)<'), '>${color.toUpperCase()}<');
      lines[x] = line;
      break;
    }
  }

  if (!foundExisting) {
    lines.insert(lines.length - 1,
        '\t<color name="ic_launcher_background">${color.toUpperCase()}</color>');
  }
  colorsXml.writeAsStringSync(lines.join('\n'));
}

void _createIcLauncherColorXmlFile() {
  final icLauncherXml = File(
      '${_flavorHelper.androidResFolder}$ANDROID_ADAPTIVE_XML_DIR/$ANDROID_ADAPTIVE_XML_FILE_NAME');
  icLauncherXml.createSync(recursive: true);
  icLauncherXml.writeAsStringSync(IC_LAUNCHER_BACKGROUND_COLOR_XML);
  CliLogger.success(
    'Created `$ANDROID_ADAPTIVE_XML_FILE_NAME`',
    level: CliLoggerLevel.two,
  );
}

void _createIcLauncherMipMapXmlFile() {
  final icLauncherXml = File(
      '${_flavorHelper.androidResFolder}$ANDROID_ADAPTIVE_XML_DIR/$ANDROID_ADAPTIVE_XML_FILE_NAME');
  icLauncherXml.createSync(recursive: true);
  icLauncherXml.writeAsStringSync(IC_LAUNCHER_MIP_MAP_XML);
  CliLogger.success(
    'Created `$ANDROID_ADAPTIVE_XML_FILE_NAME`',
    level: CliLoggerLevel.two,
  );
}

// void _createIcLauncherRoundColorXmlFile() {
//   final icLauncherXml = File(
//       '${_flavorHelper.androidResFolder}$ANDROID_ADAPTIVE_XML_DIR/$ANDROID_ADAPTIVE_ROUND_XML_FILE_NAME');
//   icLauncherXml.createSync(recursive: true);
//   icLauncherXml.writeAsStringSync(IC_LAUNCHER_ROUND_BACKGROUND_COLOR_XML);
//   CliLogger.success(
//     'Created `$ANDROID_ADAPTIVE_ROUND_XML_FILE_NAME`',
//     level: CliLoggerLevel.two,
//   );
// }

void _createIcLauncherRoundMipMapXmlFile() {
  final icLauncherXml = File(
      '${_flavorHelper.androidResFolder}$ANDROID_ADAPTIVE_XML_DIR/$ANDROID_ADAPTIVE_ROUND_XML_FILE_NAME');
  icLauncherXml.createSync(recursive: true);
  icLauncherXml.writeAsStringSync(IC_LAUNCHER_ROUND_MIP_MAP_XML);
  CliLogger.success(
    'Created `$ANDROID_ADAPTIVE_ROUND_XML_FILE_NAME`',
    level: CliLoggerLevel.two,
  );
}

void _createAndroidManifestIconLauncherRound() {
  final androidManifestFile = File(ANDROID_MANIFEST_FILE);
  final androidManifestString = androidManifestFile.readAsStringSync();
  final manifestLines = androidManifestString.split('\n');

  final index =
      manifestLines.indexWhere((line) => line.contains('android:roundIcon'));
  if (index != -1) {
    final lineUpdated = manifestLines.elementAt(index).replaceAll(
          RegExp(r'android:roundIcon="[^"]*(\\"[^"]*)*"'),
          'android:roundIcon="@mipmap/$ANDROID_ADAPTIVE_ROUND_ICON_NAME"',
        );
    manifestLines.replaceRange(index, index + 1, [lineUpdated]);
    androidManifestFile.writeAsStringSync(manifestLines.join('\n'));
    CliLogger.success(
      'Updated `android:roundIcon` to manifest',
      level: CliLoggerLevel.two,
    );
  } else {
    final index =
        manifestLines.indexWhere((line) => line.contains('android:icon'));
    if (index != -1) {
      final lineUpdated = manifestLines
          .elementAt(index)
          .replaceAll(RegExp(r'android:icon="[^"]*(\\"[^"]*)*"'), '''
android:icon="@mipmap/$ANDROID_ICON_NAME"
\t\tandroid:roundIcon="@mipmap/$ANDROID_ADAPTIVE_ROUND_ICON_NAME"''');

      manifestLines.replaceRange(index, index + 1, [lineUpdated]);
      androidManifestFile.writeAsStringSync(manifestLines.join('\n'));
      CliLogger.success(
        'Updated `android:roundIcon` to manifest',
        level: CliLoggerLevel.two,
      );
    }
  }
}

void _removeAndroidManifestIconLauncherRound() {
  final androidManifestFile = File(ANDROID_MANIFEST_FILE);
  final androidManifestString = androidManifestFile.readAsStringSync();
  final manifestLines = androidManifestString.split('\n');

  final index =
      manifestLines.indexWhere((line) => line.contains('android:roundIcon'));
  if (index != -1) {
    final lineUpdated = manifestLines
        .elementAt(index)
        .replaceAll(RegExp(r'android:roundIcon="[^"]*(\\"[^"]*)*"'), '');
    manifestLines.replaceRange(index, index + 1, [lineUpdated]);
    androidManifestFile.writeAsStringSync(manifestLines.join('\n'));
    print('   ⚡ Removed `android:roundIcon` from manifest');
  }
}
