library icons_launcher_cli;

import 'package:icons_launcher/utils/cli_logger.dart';
import 'package:icons_launcher/utils/constants.dart';
import 'package:icons_launcher/utils/icon.dart';
import 'package:path/path.dart' as p;
import 'package:universal_io/io.dart';
import 'package:yaml/yaml.dart';
import 'utils/template.dart';
import 'utils/utils.dart';
part 'utils/flavor_helper.dart';
part 'src/android.dart';
part 'src/ios.dart';
part 'src/macos.dart';
part 'src/web.dart';
part 'src/windows.dart';
part 'src/linux.dart';

late _FlavorHelper _flavorHelper;

/// Create launcher icons
void createLauncherIcons({String? path, String? flavor}) {
  if (flavor != null) {
    print('📱  Flavor $flavor detected! (Android, iOS)\n');
  }
  _flavorHelper = _FlavorHelper(flavor);
  final config = _getConfig(configFile: path);
  _checkConfig(config);
  _createIconsByConfig(config);
}

/// Get config file
Map<String, dynamic> _getConfig({String? configFile}) {
  String filePath;
  if (configFile != null) {
    if (File(configFile).existsSync()) {
      filePath = configFile;
    } else {
      CliLogger.error('The config file `$configFile` was not found.');
      exit(1);
    }
  } else if (_flavorHelper.flavor != null) {
    filePath = 'icons_launcher-${_flavorHelper.flavor}.yaml';
  } else if (File('icons_launcher.yaml').existsSync()) {
    filePath = 'icons_launcher.yaml';
  } else {
    filePath = 'pubspec.yaml';
  }

  final Map yamlMap = loadYaml(File(filePath).readAsStringSync()) as Map;

  if (yamlMap['icons_launcher'] is! Map) {
    CliLogger.error(
        "Your $filePath file does not contain a 'icons_launcher' section.");
    exit(1);
  }

  // yamlMap has the type YamlMap, which has several unwanted side effects
  return _yamlToMap(yamlMap['icons_launcher'] as YamlMap);
}

/// Convert yaml to map
Map<String, dynamic> _yamlToMap(YamlMap yamlMap) {
  final Map<String, dynamic> map = <String, dynamic>{};
  for (final MapEntry<dynamic, dynamic> entry in yamlMap.entries) {
    if (entry.value is YamlList) {
      final list = <String>[];
      for (final value in entry.value as YamlList) {
        if (value is String) {
          list.add(value);
        }
      }
      map[entry.key as String] = list;
    } else if (entry.value is YamlMap) {
      map[entry.key as String] = _yamlToMap(entry.value as YamlMap);
    } else {
      map[entry.key as String] = entry.value;
    }
  }
  return map;
}

/// Validate config options
void _checkConfig(Map<String, dynamic> config) {
  if (!hasPlatformConfig(config)) {
    CliLogger.error('Please add a `platform` target to your config file.');
    exit(1);
  }

  if (config.containsKey('image_adaptive_foreground') &&
      !config.containsKey('image_adaptive_background') &&
      !config.containsKey('color_adaptive_background')) {
    CliLogger.error(
        'Please add an `image_adaptive_background` or `color_adaptive_background` to your config file.');
    exit(1);
  }

  if (!config.containsKey('image_adaptive_foreground') &&
      (config.containsKey('image_adaptive_background') ||
          config.containsKey('color_adaptive_background'))) {
    CliLogger.error(
        'Please add an `image_adaptive_foreground` to your config file.');
    exit(1);
  }

  if (config.containsKey('image_adaptive_background') &&
      config.containsKey('color_adaptive_background')) {
    CliLogger.error('Your `icons_launcher` section can not contain both a '
        '`image_adaptive_background` and `color_adaptive_background`.');
    exit(1);
  }

  final imagePath = _checkImageExists(config: config, parameter: 'image_path');
  final imagePathAndroid =
      _checkImageExists(config: config, parameter: 'image_path_android') ??
          imagePath;
  final imagePathIos =
      _checkImageExists(config: config, parameter: 'image_path_ios') ??
          imagePath;
  final imagePathMacos =
      _checkImageExists(config: config, parameter: 'image_path_macos') ??
          imagePath;
  final imagePathWindows =
      _checkImageExists(config: config, parameter: 'image_path_windows') ??
          imagePath;
  final imagePathLinux =
      _checkImageExists(config: config, parameter: 'image_path_linux') ??
          imagePath;
  final imagePathWeb =
      _checkImageExists(config: config, parameter: 'image_path_web') ??
          imagePath;

  final List<String> errors = <String>[];
  if (isNeedingNewAndroidIcon(config) && imagePathAndroid == null) {
    errors.add('Could not find image path for Android');
  }
  if (isNeedingNewIOSIcon(config) && imagePathIos == null) {
    errors.add('Could not find image path for iOS');
  }
  if (isNeedingNewMacOSIcon(config) && imagePathMacos == null) {
    errors.add('Could not find image path for macOS');
  }
  if (isNeedingNewWindowsIcon(config) && imagePathWindows == null) {
    errors.add('Could not find image path for Windows');
  }
  if (isNeedingNewLinuxIcon(config) && imagePathLinux == null) {
    errors.add('Could not find image path for Linux');
  }
  if (isNeedingNewWebIcon(config) && imagePathWeb == null) {
    errors.add('Could not find image path for Web');
  }

  if (errors.isNotEmpty) {
    errors.forEach(CliLogger.error);
    exit(1);
  }
}

/// Create icons base on config
void _createIconsByConfig(Map<String, dynamic> config) {
  final imagePath = _checkImageExists(config: config, parameter: 'image_path');
  final imagePathAndroid =
      _checkImageExists(config: config, parameter: 'image_path_android') ??
          imagePath;
  final imagePathIos =
      _checkImageExists(config: config, parameter: 'image_path_ios') ??
          imagePath;
  final imagePathMacos =
      _checkImageExists(config: config, parameter: 'image_path_macos') ??
          imagePath;
  final imagePathWindows =
      _checkImageExists(config: config, parameter: 'image_path_windows') ??
          imagePath;
  final imagePathLinux =
      _checkImageExists(config: config, parameter: 'image_path_linux') ??
          imagePath;
  final imagePathWeb =
      _checkImageExists(config: config, parameter: 'image_path_web') ??
          imagePath;
  final faviconPathWeb =
      _checkImageExists(config: config, parameter: 'favicon_path_web') ??
          imagePath;
  final adaptiveBgImage =
      _checkImageExists(config: config, parameter: 'image_adaptive_background');
  final adaptiveFgImage =
      _checkImageExists(config: config, parameter: 'image_adaptive_foreground');
  final adaptiveRoundImage =
      _checkImageExists(config: config, parameter: 'image_adaptive_round');

  //! Android
  if (isNeedingNewAndroidIcon(config) && imagePathAndroid != null) {
    _createAndroidIcons(imagePath: imagePathAndroid);
  }

  String? adaptiveBg;
  if (config.containsKey('color_adaptive_background')) {
    final adaptiveBgColor = config['color_adaptive_background'].toString();
    adaptiveBg = adaptiveBgColor;
  } else if (adaptiveBgImage != null) {
    adaptiveBg = adaptiveBgImage;
  }

  //! Android Adaptive
  final isAdaptiveIconExists = adaptiveBg != null && adaptiveFgImage != null;
  if (hasAndroidAdaptiveConfig(config) && isAdaptiveIconExists) {
    final int minSdk = _minSdk();
    if (minSdk == 0) {
      CliLogger.error(
          'Can not find minSdk from android/app/build.gradle or android/local.properties',
          level: CliLoggerLevel.two);
      exit(1);
    }
    if (minSdk < 26 && imagePathAndroid == null) {
      CliLogger.error(
          'Adaptive icon config found but no regular Android config. API 26 the regular Android config is required',
          level: CliLoggerLevel.two);
      exit(1);
    }
    _createAndroidAdaptiveIcon(
      background: adaptiveBg,
      foreground: adaptiveFgImage,
      round: adaptiveRoundImage,
    );
  }

  //! iOS
  if (isNeedingNewIOSIcon(config) && imagePathIos != null) {
    _createIosIcons(imagePath: imagePathIos);
  }

  //! macOS
  if (isNeedingNewMacOSIcon(config) && imagePathMacos != null) {
    _createMacOSIcons(imagePath: imagePathMacos);
  }

  //! Web
  if (isNeedingNewWebIcon(config)) {
    if (imagePathWeb != null) {
      _createWebIcons(imagePath: imagePathWeb);
    }
    if (faviconPathWeb != null) {
      _createWebFavicon(imagePath: faviconPathWeb);
    }
  }

  //! Windows
  if (isNeedingNewWindowsIcon(config) && imagePathWindows != null) {
    _createWindowsIcons(imagePath: imagePathWindows);
  }

  //! Linux
  if (isNeedingNewLinuxIcon(config) && imagePathLinux != null) {
    _createLinuxIcons(imagePath: imagePathLinux);
  }
}

/// Check image exists
String? _checkImageExists({
  required Map<String, dynamic> config,
  required String parameter,
}) {
  final String? image = config[parameter]?.toString();
  if (image != null) {
    if (image.isNotEmpty && !File(image).existsSync()) {
      CliLogger.error(
        'The file "$image" set as the parameter "$parameter" was not found.',
      );
      exit(1);
    }

    final imageExtension = p.extension(image).toLowerCase();
    if (imageExtension != '.png' &&
        imageExtension != '.jpg' &&
        imageExtension != '.jpeg') {
      CliLogger.error(
        'Unsupported file format: $image  Your image must be a JPG, JPEG or PNG file.',
      );
      exit(1);
    }
  }

  return image == '' ? null : image;
}
