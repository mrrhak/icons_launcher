part of '../cli_commands.dart';

/// Android icons template
final androidIcons = <AndroidMipMapIconTemplate>[
  AndroidMipMapIconTemplate(directoryName: 'mipmap-mdpi', size: 48),
  AndroidMipMapIconTemplate(directoryName: 'mipmap-hdpi', size: 72),
  AndroidMipMapIconTemplate(directoryName: 'mipmap-xhdpi', size: 96),
  AndroidMipMapIconTemplate(directoryName: 'mipmap-xxhdpi', size: 144),
  AndroidMipMapIconTemplate(directoryName: 'mipmap-xxxhdpi', size: 192),
];

/// Android adaptive icons template
final adaptiveIcons = <AndroidMipMapIconTemplate>[
  AndroidMipMapIconTemplate(directoryName: 'mipmap-mdpi', size: 108),
  AndroidMipMapIconTemplate(directoryName: 'mipmap-hdpi', size: 162),
  AndroidMipMapIconTemplate(directoryName: 'mipmap-xhdpi', size: 216),
  AndroidMipMapIconTemplate(directoryName: 'mipmap-xxhdpi', size: 324),
  AndroidMipMapIconTemplate(directoryName: 'mipmap-xxxhdpi', size: 432),
];

/// Android notification icons template
final notificationIcons = <AndroidMipMapIconTemplate>[
  AndroidMipMapIconTemplate(directoryName: 'drawable-mdpi', size: 24),
  AndroidMipMapIconTemplate(directoryName: 'drawable-hdpi', size: 36),
  AndroidMipMapIconTemplate(directoryName: 'drawable-xhdpi', size: 48),
  AndroidMipMapIconTemplate(directoryName: 'drawable-xxhdpi', size: 72),
  AndroidMipMapIconTemplate(directoryName: 'drawable-xxxhdpi', size: 96),
];

/// Start create Android icons
void createAndroidIcons({required String imagePath}) {
  CliLogger.info('Creating Android icons...');

  final image = Icon.loadFile(imagePath);
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

/// Save the image to the Android directory
void _saveImageAndroid(
  AndroidMipMapIconTemplate template,
  Icon image,
  String fileName,
) {
  // When the flavor value is not specified we will place all the data inside the main directory.
  // However if the flavor value is specified, we need to place the data in the correct directory.
  // Default: android/app/src/main/res/
  // With a flavor: android/app/src/[flavor name]/res/
  final filePath =
      '${_flavorHelper.androidResFolder}${template.directoryName}/$fileName';
  image.saveResizedPng(template.size, filePath);
}

/// Create the play store icon
void _createPlayStoreIcon(Icon image) {
  final template = AndroidMipMapIconTemplate(
    directoryName: _flavorHelper.androidMainFolder,
    size: 512,
  );
  image.saveResizedPng(
    template.size,
    '${template.directoryName}/$ANDROID_PLAYSTORE_ICON_FILE_NAME',
  );
}

/// Update the Android manifest with the new launcher icon
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

/// Start android adaptive icons
void createAndroidAdaptiveIcon({
  required String background,
  required String foreground,
  String? round,
  String? monochrome,
}) {
  var message = 'Creating Android adaptive icons...';
  if (round != null) {
    message = 'Creating Android adaptive icons with round...';
  }
  CliLogger.info(message);

  _createAdaptiveForeground(adaptiveIcons, foreground);
  _createAdaptiveBackground(adaptiveIcons, background, monochrome);
  if (round != null) {
    _createAdaptiveRound(
        androidIcons, round, isValidHexaCode(background), monochrome != null);
  } else {
    _removeAdaptiveRound(androidIcons);
  }
  if (monochrome != null) {
    _createAdaptiveMonochrome(adaptiveIcons, monochrome);
  } else {
    _removeAdaptiveMonochrome(adaptiveIcons);
  }
}

/// Create the adaptive background
void _createAdaptiveBackground(
  List<AndroidMipMapIconTemplate> adaptiveIcons,
  String background, [
  String? monochrome,
]) {
  // Check background is hexa color or image
  if (isValidHexaCode(background)) {
    _handleColorsXmlFile(background);
    _createIcLauncherColorXmlFile(monochrome != null);
  } else {
    try {
      final backgroundImage = Icon.loadFile(background);
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
      _createIcLauncherMipMapXmlFile(monochrome != null);
    } catch (e) {
      CliLogger.error(
        'Incorrect `$background` of `adaptive_background_color` or `adaptive_background_image`',
        level: CliLoggerLevel.two,
      );
      exit(1);
    }
  }
}

/// Create the adaptive foreground
void _createAdaptiveForeground(
  List<AndroidMipMapIconTemplate> adaptiveIcons,
  String foreground,
) {
  final foregroundImage = Icon.loadFile(foreground);
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

/// Create the adaptive round
void _createAdaptiveRound(
  List<AndroidMipMapIconTemplate> adaptiveIcons,
  String round,
  bool backgroundIsColor,
  bool hasMonochrome,
) {
  final roundImage = Icon.loadFile(round);
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
  _createIcLauncherRoundMipMapXmlFile(backgroundIsColor, hasMonochrome);
  _createAndroidManifestIconLauncherRound();
  CliLogger.success(
    'Generated adaptive round images',
    level: CliLoggerLevel.two,
  );
}

/// Remove the adaptive round
void _removeAdaptiveRound(List<AndroidMipMapIconTemplate> adaptiveIcons) {
  for (final template in adaptiveIcons) {
    final filePath =
        '${_flavorHelper.androidResFolder}${template.directoryName}/$ANDROID_ADAPTIVE_ROUND_ICON_FILE_NAME';
    deleteFile(filePath);
  }
  _removeAndroidManifestIconLauncherRound();
  _removeIcLauncherRoundMipMapXmlFile();
  CliLogger.success(
    'Removed adaptive round images',
    level: CliLoggerLevel.two,
  );
}

/// Create the adaptive monochrome icon
void _createAdaptiveMonochrome(
  List<AndroidMipMapIconTemplate> adaptiveIcons,
  String monochrome,
) {
  final monochromeImage = Icon.loadFile(monochrome);
  if (monochromeImage == null) {
    CliLogger.error(
      'The file $monochrome could not be read.',
      level: CliLoggerLevel.two,
    );
    exit(1);
  }

  // Convert to grayscale
  monochromeImage.convertToGrayscale();

  for (final template in adaptiveIcons) {
    _saveImageAndroid(
      template,
      monochromeImage,
      ANDROID_ADAPTIVE_MONOCHROME_ICON_FILE_NAME,
    );
  }
  CliLogger.success(
    'Generated adaptive monochrome images',
    level: CliLoggerLevel.two,
  );
}

/// Remove the adaptive monochrome icon
void _removeAdaptiveMonochrome(List<AndroidMipMapIconTemplate> templateIcons) {
  for (final template in adaptiveIcons) {
    final filePath =
        '${_flavorHelper.androidResFolder}${template.directoryName}/$ANDROID_ADAPTIVE_MONOCHROME_ICON_FILE_NAME';
    deleteFile(filePath);
  }
  CliLogger.success(
    'Removed adaptive monochrome images',
    level: CliLoggerLevel.two,
  );
}

/// Start android adaptive icons
void createAndroidNotificationIcon(String notification) {
  var message = 'Creating Android notification icons...';
  CliLogger.info(message);
  _createNotificationIcon(notificationIcons, notification);
}

/// Create the notification icon
void _createNotificationIcon(
  List<AndroidMipMapIconTemplate> templateIcons,
  String notification,
) {
  final notificationImage = Icon.loadFile(notification);
  if (notificationImage == null) {
    CliLogger.error(
      'The file $notificationImage could not be read.',
      level: CliLoggerLevel.two,
    );
    exit(1);
  }

  // Convert to white
  notificationImage.convertToWhite();

  for (final template in templateIcons) {
    _saveImageAndroid(
      template,
      notificationImage,
      ANDROID_NOTIFICATION_ICON_FILE_NAME,
    );
  }
  CliLogger.success(
    'Generated notification images',
    level: CliLoggerLevel.two,
  );
}

/// Handle colors.xml file
void _handleColorsXmlFile(String backgroundColor) {
  final colorsXml =
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

/// Create colors.xml file
void _createColorsFile(String backgroundColor) {
  var color = backgroundColor;

  if ((color.length == 4 || color.length == 7) && color.length != 9) {
    color = '#FF${backgroundColor.replaceAll('#', '')}';
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

// Update colors.xml file
void _updateColorsFile(File colorsXml, String backgroundColor) {
  var color = backgroundColor;

  if ((color.length == 4 || color.length == 7) && color.length != 9) {
    color = '#FF${backgroundColor.replaceAll('#', '')}';
  } else {
    CliLogger.error(
      'Incorrect `$backgroundColor` of `adaptive_background_color`',
      level: CliLoggerLevel.two,
    );
    exit(1);
  }

  final lines = colorsXml.readAsLinesSync();
  var foundExisting = false;
  for (var x = 0; x < lines.length; x++) {
    var line = lines[x];
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

/// Create ic_launcher_color.xml file
void _createIcLauncherColorXmlFile(bool hasMonochrome) {
  final icLauncherXml = File(
      '${_flavorHelper.androidResFolder}$ANDROID_ADAPTIVE_XML_DIR/$ANDROID_ADAPTIVE_XML_FILE_NAME');
  icLauncherXml.createSync(recursive: true);
  icLauncherXml.writeAsStringSync(hasMonochrome
      ? IC_LAUNCHER_BACKGROUND_COLOR_XML
      : IC_LAUNCHER_BACKGROUND_COLOR_NO_MONOCHROME_XML);
  CliLogger.success(
    'Created `$ANDROID_ADAPTIVE_XML_FILE_NAME`',
    level: CliLoggerLevel.two,
  );
}

/// Create ic luncher xml file
void _createIcLauncherMipMapXmlFile(bool hasMonochrome) {
  final icLauncherXml = File(
      '${_flavorHelper.androidResFolder}$ANDROID_ADAPTIVE_XML_DIR/$ANDROID_ADAPTIVE_XML_FILE_NAME');
  icLauncherXml.createSync(recursive: true);
  icLauncherXml.writeAsStringSync(hasMonochrome
      ? IC_LAUNCHER_MIP_MAP_XML
      : IC_LAUNCHER_MIP_MAP_NO_MONOCHROME_XML);
  CliLogger.success(
    'Created `$ANDROID_ADAPTIVE_XML_FILE_NAME`',
    level: CliLoggerLevel.two,
  );
}

/// Create ic_launcher_round.xml file
void _createIcLauncherRoundMipMapXmlFile(
    bool backgroundIsColor, bool hasMonochrome) {
  final icLauncherXml = File(
      '${_flavorHelper.androidResFolder}$ANDROID_ADAPTIVE_XML_DIR/$ANDROID_ADAPTIVE_ROUND_XML_FILE_NAME');
  String contents;
  if (backgroundIsColor) {
    if (hasMonochrome) {
      contents = IC_LAUNCHER_ROUND_BACKGROUND_COLOR_XML;
    } else {
      contents = IC_LAUNCHER_ROUND_BACKGROUND_COLOR_NO_MONOCHROME_XML;
    }
  } else {
    if (hasMonochrome) {
      contents = IC_LAUNCHER_ROUND_MIP_MAP_XML;
    } else {
      contents = IC_LAUNCHER_ROUND_MIP_MAP_NO_MONOCHROME_XML;
    }
  }
  icLauncherXml.createSync(recursive: true);
  icLauncherXml.writeAsStringSync(contents);
  CliLogger.success(
    'Created `$ANDROID_ADAPTIVE_ROUND_XML_FILE_NAME`',
    level: CliLoggerLevel.two,
  );
}

/// Remove ic_launcher_round.xml file
void _removeIcLauncherRoundMipMapXmlFile() {
  final icRoundLauncherXmlPath =
      '${_flavorHelper.androidResFolder}$ANDROID_ADAPTIVE_XML_DIR/$ANDROID_ADAPTIVE_ROUND_XML_FILE_NAME';
  deleteFile(icRoundLauncherXmlPath);
  CliLogger.success(
    'Removed `$ANDROID_ADAPTIVE_ROUND_XML_FILE_NAME`',
    level: CliLoggerLevel.two,
  );
}

/// Create android manifest icon launcher round
void _createAndroidManifestIconLauncherRound() {
  final androidManifestFile = File(ANDROID_MANIFEST_FILE);
  final androidManifestString = androidManifestFile.readAsStringSync();
  final manifestLines = androidManifestString.split('\n');

  final index =
      manifestLines.indexWhere((line) => line.contains('android:roundIcon'));
  if (index != -1) {
    final lineUpdated = manifestLines.elementAt(index).replaceAll(
          RegExp(r'android:roundIcon="[^"]*(\\"[^"]*)*"'),
          'android:roundIcon="@mipmap/$ANDROID_ADAPTIVE_ROUND_XML_FILE_NAME_WITHOUT_EXTENSION"',
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
\t\tandroid:roundIcon="@mipmap/$ANDROID_ADAPTIVE_ROUND_XML_FILE_NAME_WITHOUT_EXTENSION"''');

      manifestLines.replaceRange(index, index + 1, [lineUpdated]);
      androidManifestFile.writeAsStringSync(manifestLines.join('\n'));
      CliLogger.success(
        'Created `android:roundIcon` to manifest',
        level: CliLoggerLevel.two,
      );
    }
  }
}

/// Remove android manifest icon launcher round
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
    CliLogger.success('Removed `android:roundIcon` from manifest',
        level: CliLoggerLevel.two);
  }
}

/// Retrieves the minSdk value
int _minSdk() {
  String? minSdkValue;

  final androidGradleFile = File(ANDROID_GRADLE_FILE);
  final List<String> androidLines =
      androidGradleFile.existsSync() ? androidGradleFile.readAsLinesSync() : [];

  //! First try -> app/build.gradle file
  const androidLineKey = 'minSdkVersion';
  minSdkValue = _getLineValueNumber(androidLines, androidLineKey);

  //! Second try -> app/build.gradle file
  if (minSdkValue == null) {
    const newAndroidLineKey = 'minSdk =';
    minSdkValue = _getLineValueNumber(androidLines, newAndroidLineKey);
  }

  //! Third try -> app/build.gradle.kts file
  if (minSdkValue == null) {
    final androidGradleKtsFile = File(ANDROID_GRADLE_KTS_FILE);
    final List<String> androidKtsLines = androidGradleKtsFile.existsSync()
        ? androidGradleKtsFile.readAsLinesSync()
        : [];
    const androidKotlinLineKey = 'minSdk =';
    minSdkValue = _getLineValueNumber(androidKtsLines, androidKotlinLineKey);
  }

  //! Fourth try -> local.properties
  if (minSdkValue == null) {
    final localLines = File(ANDROID_LOCAL_PROPERTIES).readAsLinesSync();
    const localKey = 'flutter.minSdkVersion=';
    minSdkValue = _getLineValueNumber(localLines, localKey);
  }

  //! Fifth try -> flutter.gradle file (default flutter sdk)
  if (minSdkValue == null) {
    final gradleFile = '${_flutterSdk()}$FLUTTER_SDK_GRADLE_FILE';
    final flutterLines = File(gradleFile).readAsLinesSync();
    const flutterLineKey = 'minSdkVersion =';
    minSdkValue = _getLineValueNumber(flutterLines, flutterLineKey);
  }

  if (minSdkValue != null) return int.tryParse(minSdkValue) ?? 0;
  return ANDROID_DEFAULT_MIN_SDK;
}

/// Retrieves the flutter sdk path
String _flutterSdk() {
  final lines = File(ANDROID_LOCAL_PROPERTIES).readAsLinesSync();
  const key = 'flutter.sdk=';
  for (var line in lines) {
    if (line.contains(key)) {
      if (line.contains('//') && line.indexOf('//') < line.indexOf(key)) {
        // This line is commented
        continue;
      }
      // Remove the key and return the flutter sdk path
      return line.replaceAll(key, '').trim();
    }
  }
  return '';
}

/// Retrieves the string number only
String? _getLineValueNumber(List<String> lines, String key) {
  for (var line in lines) {
    if (line.contains(key)) {
      if (line.contains('//') && line.indexOf('//') < line.indexOf(key)) {
        // This line is commented
        continue;
      }
      final value = line.replaceAll(RegExp(r'[^\d]'), '').trim();
      if (value.isNotEmpty) {
        return value;
      }
    }
  }
  return null;
}
