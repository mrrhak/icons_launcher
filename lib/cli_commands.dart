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
part 'src/chrome_extension.dart';

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
    CliLogger.error('Please add a `platforms` target to your config file.');
    exit(1);
  }
  final List<String> errors = <String>[];
  final globalImagePath =
      _checkImageExists(config: config, parameter: 'image_path');
  final platforms = config['platforms'] as Map<String, dynamic>;

  // ANDROID
  if (isNeedingNewAndroidIcon(platforms)) {
    final androidConfig = platforms['android'] as Map<String, dynamic>;
    final androidImagePath =
        _checkImageExists(config: androidConfig, parameter: 'image_path') ??
            globalImagePath;
    if (androidImagePath == null) {
      errors.add('Please add a `image_path` for Android to your config file.');
    }

    if (androidConfig.containsKey('adaptive_foreground_image') &&
        !androidConfig.containsKey('adaptive_background_image') &&
        !androidConfig.containsKey('adaptive_background_color')) {
      errors.add(
          'Please add an `adaptive_background_image` or `adaptive_background_color` for Android to your config file.');
    }

    if (!androidConfig.containsKey('adaptive_foreground_image') &&
        (androidConfig.containsKey('adaptive_background_image') ||
            androidConfig.containsKey('adaptive_background_color'))) {
      errors.add(
          'Please add an `adaptive_foreground_image` for Android to your config file.');
    }

    if (androidConfig.containsKey('adaptive_background_image') &&
        androidConfig.containsKey('adaptive_background_color')) {
      errors.add('Your Android platform can not contain both '
          '`adaptive_background_image` and `adaptive_background_color`.');
    }
  }

  // IOS
  if (isNeedingNewIosIcon(platforms)) {
    final iosConfig = platforms['ios'] as Map<String, dynamic>;
    final iosImagePath =
        _checkImageExists(config: iosConfig, parameter: 'image_path') ??
            globalImagePath;
    if (iosImagePath == null) {
      errors.add('Please add a `image_path` for IOS to your config file.');
    }
  }

  // MACOS
  if (isNeedingNewMacOSIcon(platforms)) {
    final macosConfig = platforms['macos'] as Map<String, dynamic>;
    final macosImagePath =
        _checkImageExists(config: macosConfig, parameter: 'image_path') ??
            globalImagePath;
    if (macosImagePath == null) {
      errors.add('Please add a `image_path` for MacOS to your config file.');
    }
  }

  // WEB
  if (isNeedingNewWebIcon(platforms)) {
    final webConfig = platforms['web'] as Map<String, dynamic>;
    final webImagePath =
        _checkImageExists(config: webConfig, parameter: 'image_path') ??
            globalImagePath;
    if (webImagePath == null) {
      errors.add('Please add a `image_path` for Web to your config file.');
    }
  }

  // WINDOWS
  if (isNeedingNewWindowsIcon(platforms)) {
    final windowsConfig = platforms['windows'] as Map<String, dynamic>;
    final windowsImagePath =
        _checkImageExists(config: windowsConfig, parameter: 'image_path') ??
            globalImagePath;
    if (windowsImagePath == null) {
      errors.add('Please add a `image_path` for Windows to your config file.');
    }
  }

  // LINUX
  if (isNeedingNewLinuxIcon(platforms)) {
    final linuxConfig = platforms['linux'] as Map<String, dynamic>;
    final linuxImagePath =
        _checkImageExists(config: linuxConfig, parameter: 'image_path') ??
            globalImagePath;
    if (linuxImagePath == null) {
      errors.add('Please add a `image_path` for Linux to your config file.');
    }
  }

  // CHROME EXTENSION
  if (isNeedingNewChromeExtensionIcon(platforms)) {
    final chromeExtensionConfig =
        platforms['chrome_extension'] as Map<String, dynamic>;
    final chromeExtensionImagePath = _checkImageExists(
            config: chromeExtensionConfig, parameter: 'image_path') ??
        globalImagePath;
    if (chromeExtensionImagePath == null) {
      errors.add(
          'Please add a `image_path` for Chrome Extension to your config file.');
    }
  }

  if (errors.isNotEmpty) {
    errors.forEach(CliLogger.error);
    exit(1);
  }
}

/// Create icons base on config
void _createIconsByConfig(Map<String, dynamic> config) {
  // Global image path
  final imagePath = _checkImageExists(config: config, parameter: 'image_path');
  final platforms = config['platforms'] as Map<String, dynamic>;

  String? imagePathAndroid = imagePath;
  if (isNeedingNewAndroidIcon(platforms)) {
    final newImagePath = _checkImageExists(
      config: platforms['android'],
      parameter: 'image_path',
    );
    if (newImagePath != null) {
      imagePathAndroid = newImagePath;
    }
    if (imagePathAndroid == null) {
      CliLogger.error('Could not find image path for Android');
      exit(1);
    }
  }

  String? imagePathIos = imagePath;
  if (isNeedingNewIosIcon(platforms)) {
    final newImagePath = _checkImageExists(
      config: platforms['ios'],
      parameter: 'image_path',
    );
    if (newImagePath != null) {
      imagePathIos = newImagePath;
    }
    if (imagePathIos == null) {
      CliLogger.error('Could not find image path for iOS');
      exit(1);
    }
  }

  String? imagePathMacos = imagePath;
  if (isNeedingNewMacOSIcon(platforms)) {
    final newImagePath = _checkImageExists(
      config: platforms['macos'],
      parameter: 'image_path',
    );
    if (newImagePath != null) {
      imagePathMacos = newImagePath;
    }
    if (imagePathMacos == null) {
      CliLogger.error('Could not find image path for macOS');
      exit(1);
    }
  }

  String? imagePathWindows = imagePath;
  if (isNeedingNewWindowsIcon(platforms)) {
    final newImagePath = _checkImageExists(
      config: platforms['windows'],
      parameter: 'image_path',
    );
    if (newImagePath != null) {
      imagePathWindows = newImagePath;
    }
    if (imagePathWindows == null) {
      CliLogger.error('Could not find image path for Windows');
      exit(1);
    }
  }

  String? imagePathLinux = imagePath;
  if (isNeedingNewLinuxIcon(platforms)) {
    final newImagePath = _checkImageExists(
      config: platforms['linux'],
      parameter: 'image_path',
    );
    if (newImagePath != null) {
      imagePathLinux = newImagePath;
    }
    if (imagePathLinux == null) {
      CliLogger.error('Could not find image path for Linux');
      exit(1);
    }
  }

  String? imagePathWeb = imagePath;
  if (isNeedingNewWebIcon(platforms)) {
    final newImagePath = _checkImageExists(
      config: platforms['web'],
      parameter: 'image_path',
    );
    if (newImagePath != null) {
      imagePathWeb = newImagePath;
    }
    if (imagePathWeb == null) {
      CliLogger.error('Could not find image path for Web');
      exit(1);
    }
  }

  String? faviconPathWeb = imagePathWeb;
  if (isNeedingNewWebIcon(platforms)) {
    final newImagePath = _checkImageExists(
      config: platforms['web'],
      parameter: 'favicon_path',
    );
    if (newImagePath != null) {
      faviconPathWeb = newImagePath;
    }
  }

  String? adaptiveBgImage;
  if (isNeedingNewAndroidIcon(platforms)) {
    final newImagePath = _checkImageExists(
      config: platforms['android'],
      parameter: 'adaptive_background_image',
    );
    if (newImagePath != null) {
      adaptiveBgImage = newImagePath;
    }
  }

  String? adaptiveFgImage;
  if (isNeedingNewAndroidIcon(platforms)) {
    final newImagePath = _checkImageExists(
      config: platforms['android'],
      parameter: 'adaptive_foreground_image',
    );
    if (newImagePath != null) {
      adaptiveFgImage = newImagePath;
    }
  }

  String? adaptiveRoundImage;
  if (isNeedingNewAndroidIcon(platforms)) {
    final newImagePath = _checkImageExists(
      config: platforms['android'],
      parameter: 'adaptive_round_image',
    );
    if (newImagePath != null) {
      adaptiveRoundImage = newImagePath;
    }
  }

  String? chromeExtensionImagePath;
  if (isNeedingNewChromeExtensionIcon(platforms)) {
    final newImagePath = _checkImageExists(
      config: platforms['chrome_extension'],
      parameter: 'image_path',
    );
    if (newImagePath != null) {
      chromeExtensionImagePath = newImagePath;
    }
  }

  //! Android
  if (isNeedingNewAndroidIcon(platforms)) {
    if (imagePathAndroid != null) {
      _createAndroidIcons(imagePath: imagePathAndroid);
    }

    String? adaptiveBg;
    if (platforms['android'].containsKey('adaptive_background_color')) {
      final adaptiveBgColor =
          platforms['android']['adaptive_background_color'].toString();
      adaptiveBg = adaptiveBgColor;
    } else if (adaptiveBgImage != null) {
      adaptiveBg = adaptiveBgImage;
    }

    //! Android Adaptive
    final isAdaptiveIconExists = adaptiveBg != null && adaptiveFgImage != null;
    if (hasAndroidAdaptiveConfig(platforms) && isAdaptiveIconExists) {
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
  }

  //! iOS
  if (isNeedingNewIosIcon(platforms) && imagePathIos != null) {
    _createIosIcons(imagePath: imagePathIos);
  }

  //! macOS
  if (isNeedingNewMacOSIcon(platforms) && imagePathMacos != null) {
    _createMacOSIcons(imagePath: imagePathMacos);
  }

  //! Web
  if (isNeedingNewWebIcon(platforms)) {
    if (imagePathWeb != null) {
      _createWebIcons(imagePath: imagePathWeb);
    }
    if (faviconPathWeb != null) {
      _createWebFavicon(imagePath: faviconPathWeb);
    }
  }

  //! Windows
  if (isNeedingNewWindowsIcon(platforms) && imagePathWindows != null) {
    _createWindowsIcons(imagePath: imagePathWindows);
  }

  //! Linux
  if (isNeedingNewLinuxIcon(platforms) && imagePathLinux != null) {
    _createLinuxIcons(imagePath: imagePathLinux);
  }

  //! Chrome Extension
  if (isNeedingNewChromeExtensionIcon(platforms) &&
      chromeExtensionImagePath != null) {
    _createChromeExtensionIcons(imagePath: chromeExtensionImagePath);
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
