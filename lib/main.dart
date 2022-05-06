import 'package:args/args.dart';
import 'package:icons_launcher/constants.dart';
import 'package:icons_launcher/custom_exceptions.dart';
import 'package:icons_launcher/src/android.dart' as android_icons_launcher;
import 'package:icons_launcher/src/ios.dart' as ios_icons_launcher;
import 'package:icons_launcher/src/linux.dart' as linux_icons_launcher;
import 'package:icons_launcher/src/macos.dart' as macos_icons_launcher;
import 'package:icons_launcher/src/web.dart' as web_icons_launcher;
import 'package:icons_launcher/src/windows.dart' as windows_icons_launcher;
import 'package:path/path.dart' as path;
import 'package:universal_io/io.dart';
import 'package:yaml/yaml.dart';

const String fileOption = 'file';
const String helpFlag = 'help';
const String defaultConfigFile = 'icons_launcher.yaml';
const String flavorConfigFilePattern = r'^icons_launcher-(.*).yaml$';
String flavorConfigFile(String flavor) => 'icons_launcher-$flavor.yaml';

/// Returns a list of all the flavors found in the config file.
List<String> getFlavors() {
  final List<String> flavors = [];
  for (var item in Directory('.').listSync()) {
    if (item is File) {
      final name = path.basename(item.path);
      final match = RegExp(flavorConfigFilePattern).firstMatch(name);
      if (match != null) {
        flavors.add(match.group(1)!);
      }
    }
  }
  return flavors;
}

/// Creates icons from the arguments passed to the program.
Future<void> createIconsFromArguments(List<String> arguments) async {
  print(introMessage());
  final ArgParser parser = ArgParser(allowTrailingOptions: true);
  parser.addFlag(helpFlag, abbr: 'h', help: 'Usage help', negatable: false);
  // Make default null to differentiate when it is explicitly set
  parser.addOption(fileOption,
      abbr: 'f', help: 'Config file (default: $defaultConfigFile)');
  final ArgResults argResults = parser.parse(arguments);

  if (argResults[helpFlag]) {
    stdout.writeln('Generates icons for iOS and Android');
    stdout.writeln(parser.usage);
    exit(0);
  }

  // Flavors management
  final flavors = getFlavors();
  final hasFlavors = flavors.isNotEmpty;

  // Load the config file
  final Map<String, dynamic>? yamlConfig =
      loadConfigFileFromArgResults(argResults, verbose: true);

  if (yamlConfig == null) {
    throw const NoConfigFoundException();
  }

  // Create icons
  if (!hasFlavors) {
    try {
      await createIconsFromConfig(yamlConfig);
      print('\n✓ Successfully generated launcher icons');
    } catch (e) {
      stderr.writeln('\n✕ Could not generate launcher icons');
      stderr.writeln(e);
      exit(2);
    }
  } else {
    try {
      for (String flavor in flavors) {
        print('\nFlavor: $flavor');
        final Map<String, dynamic> yamlConfig =
            loadConfigFile(flavorConfigFile(flavor), flavorConfigFile(flavor));
        await createIconsFromConfig(yamlConfig, flavor);
      }
      print('\n✓ Successfully generated launcher icons for flavors');
    } catch (e) {
      stderr.writeln('\n✕ Could not generate launcher icons for flavors');
      stderr.writeln(e);
      exit(2);
    }
  }
}

/// Loads the config file from the arguments passed to the program.
/// Generate launcher icons base on config file.
Future<void> createIconsFromConfig(Map<String, dynamic> config,
    [String? flavor]) async {
  if (!isImagePathInConfig(config)) {
    throw const InvalidConfigException(errorMissingImagePath);
  }
  if (!hasPlatformConfig(config)) {
    throw const InvalidConfigException(errorMissingPlatform);
  }

  if (isNeedingNewAndroidIcon(config) || hasAndroidAdaptiveConfig(config)) {
    final int minSdk = android_icons_launcher.minSdk();
    if (minSdk == 0) {
      throw const InvalidConfigException(errorMissingMinSdk);
    }
    if (minSdk < 26 &&
        hasAndroidAdaptiveConfig(config) &&
        !hasAndroidConfig(config)) {
      throw const InvalidConfigException(errorMissingRegularAndroid);
    }
  }

  if (isNeedingNewAndroidIcon(config)) {
    android_icons_launcher.createDefaultIcons(config, flavor);
  }
  if (hasAndroidAdaptiveConfig(config)) {
    android_icons_launcher.createAdaptiveIcons(config, flavor);
  }
  if (isNeedingNewIOSIcon(config)) {
    ios_icons_launcher.createIcons(config, flavor);
  }

  if (isNeedingNewMacOSIcon(config)) {
    macos_icons_launcher.createIcons(config, flavor);
  }

  if (isNeedingNewWindowsIcon(config)) {
    windows_icons_launcher.createIcons(config, flavor);
  }

  if (isNeedingNewLinuxIcon(config)) {
    linux_icons_launcher.createIcons(config, flavor);
  }

  if (isNeedingNewWebIcon(config)) {
    web_icons_launcher.createIcons(config, flavor);
  }
}

/// Loads the config file from the arguments passed to the program.
Map<String, dynamic>? loadConfigFileFromArgResults(ArgResults argResults,
    {bool verbose = false}) {
  final String? configFile = argResults[fileOption];
  final String? fileOptionResult = argResults[fileOption];

  // if icon is given, try to load icon
  if (configFile != null && configFile != defaultConfigFile) {
    try {
      return loadConfigFile(configFile, fileOptionResult);
    } catch (e) {
      if (verbose) {
        stderr.writeln(e);
      }

      return null;
    }
  }

  // If none set try icons_launcher.yaml first then pubspec.yaml
  // for compatibility
  try {
    return loadConfigFile(defaultConfigFile, fileOptionResult);
  } catch (e) {
    // Try pubspec.yaml for compatibility
    if (configFile == null) {
      try {
        return loadConfigFile('pubspec.yaml', fileOptionResult);
      } catch (_) {}
    }

    // if nothing got returned, print error
    if (verbose) {
      stderr.writeln(e);
    }
  }

  return null;
}

/// Load the config file from the given path.
Map<String, dynamic> loadConfigFile(String path, String? fileOptionResult) {
  final File file = File(path);
  final String yamlString = file.readAsStringSync();
  // ignore: always_specify_types
  final Map yamlMap = loadYaml(yamlString);

  if (!(yamlMap['flutter_icons'] is Map)) {
    stderr.writeln(NoConfigFoundException('Check that your config file '
        '`${fileOptionResult ?? defaultConfigFile}`'
        ' has a `flutter_icons` section'));
    exit(1);
  }

  // yamlMap has the type YamlMap, which has several unwanted side effects
  final Map<String, dynamic> config = <String, dynamic>{};
  for (MapEntry<dynamic, dynamic> entry in yamlMap['flutter_icons'].entries) {
    config[entry.key] = entry.value;
  }

  return config;
}

/// Checks if the config image path.
bool isImagePathInConfig(Map<String, dynamic> flutterIconsConfig) {
  return flutterIconsConfig.containsKey('image_path') ||
      (flutterIconsConfig.containsKey('image_path_android') &&
          flutterIconsConfig.containsKey('image_path_ios'));
}

/// Checks if the config platform.
bool hasPlatformConfig(Map<String, dynamic> flutterIconsConfig) {
  return hasAndroidConfig(flutterIconsConfig) ||
      hasIOSConfig(flutterIconsConfig);
}

/// Checks if the config has android.
bool hasAndroidConfig(Map<String, dynamic> iconsLauncher) {
  return iconsLauncher.containsKey('android');
}

/// Checks if the config need android.
bool isNeedingNewAndroidIcon(Map<String, dynamic> iconsLauncherConfig) {
  return hasAndroidConfig(iconsLauncherConfig) &&
      iconsLauncherConfig['android'] != false;
}

/// Checks if the config has android adaptive.
bool hasAndroidAdaptiveConfig(Map<String, dynamic> iconsLauncherConfig) {
  return isNeedingNewAndroidIcon(iconsLauncherConfig) &&
      iconsLauncherConfig.containsKey('adaptive_icon_background') &&
      iconsLauncherConfig.containsKey('adaptive_icon_foreground');
}

/// Checks if the config has ios.
bool hasIOSConfig(Map<String, dynamic> iconsLauncherConfig) {
  return iconsLauncherConfig.containsKey('ios');
}

/// Checks if the config need ios.
bool isNeedingNewIOSIcon(Map<String, dynamic> iconsLauncherConfig) {
  return hasIOSConfig(iconsLauncherConfig) &&
      iconsLauncherConfig['ios'] != false;
}

/// Checks if the config has macos.
bool hasMacOSConfig(Map<String, dynamic> iconsLauncherConfig) {
  return iconsLauncherConfig.containsKey('macos');
}

/// Checks if the config need macos.
bool isNeedingNewMacOSIcon(Map<String, dynamic> iconsLauncherConfig) {
  return hasMacOSConfig(iconsLauncherConfig) &&
      iconsLauncherConfig['macos'] != false;
}

/// Checks if the config has windows.
bool hasWindowsConfig(Map<String, dynamic> iconsLauncherConfig) {
  return iconsLauncherConfig.containsKey('windows');
}

/// Checks if the config need windows.
bool isNeedingNewWindowsIcon(Map<String, dynamic> iconsLauncherConfig) {
  return hasWindowsConfig(iconsLauncherConfig) &&
      iconsLauncherConfig['windows'] != false;
}

/// Checks if the config has linux.
bool hasLinuxConfig(Map<String, dynamic> iconsLauncherConfig) {
  return iconsLauncherConfig.containsKey('linux');
}

/// Checks if the config need linux.
bool isNeedingNewLinuxIcon(Map<String, dynamic> iconsLauncherConfig) {
  return hasLinuxConfig(iconsLauncherConfig) &&
      iconsLauncherConfig['linux'] != false;
}

/// Checks if the config has web.
bool hasWebConfig(Map<String, dynamic> iconsLauncherConfig) {
  return iconsLauncherConfig.containsKey('web');
}

/// Checks if the config need linux.
bool isNeedingNewWebIcon(Map<String, dynamic> iconsLauncherConfig) {
  return hasWebConfig(iconsLauncherConfig) &&
      iconsLauncherConfig['web'] != false;
}
