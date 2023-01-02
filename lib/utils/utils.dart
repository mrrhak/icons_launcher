import 'package:universal_io/io.dart';

/// Checks if the config file contains a `platform`
bool hasPlatformConfig(Map<String, dynamic> config) {
  final bool isHasPlatforms = config.containsKey('platforms');
  if (isHasPlatforms) {
    final platforms = config['platforms'] as Map<String, dynamic>;
    final bool isHasPlatformSpecific = isNeedingNewAndroidIcon(platforms) ||
        isNeedingNewIosIcon(platforms) ||
        isNeedingNewMacOSIcon(platforms) ||
        isNeedingNewWindowsIcon(platforms) ||
        isNeedingNewWebIcon(platforms) ||
        isNeedingNewLinuxIcon(platforms);

    return isHasPlatformSpecific;
  }
  return false;
}

/// Checks if the config has android.
bool hasAndroidConfig(Map<String, dynamic> platforms) {
  return platforms.containsKey('android');
}

/// Checks if the config need android.
bool isNeedingNewAndroidIcon(Map<String, dynamic> platforms) {
  return hasAndroidConfig(platforms) && platforms['android']['enable'] == true;
}

/// Checks if the config has android adaptive.
bool hasAndroidAdaptiveConfig(Map<String, dynamic> platforms) {
  return isNeedingNewAndroidIcon(platforms) &&
      (platforms['android'].containsKey('adaptive_background_image') ||
          platforms['android'].containsKey('adaptive_background_color')) &&
      platforms['android'].containsKey('adaptive_foreground_image');
}

/// Checks if the config has ios.
bool hasIosConfig(Map<String, dynamic> platforms) {
  return platforms.containsKey('ios');
}

/// Checks if the config need ios.
bool isNeedingNewIosIcon(Map<String, dynamic> platforms) {
  return hasIosConfig(platforms) && platforms['ios']['enable'] == true;
}

/// Checks if the config has macos.
bool hasMacOSConfig(Map<String, dynamic> platforms) {
  return platforms.containsKey('macos');
}

/// Checks if the config need macos.
bool isNeedingNewMacOSIcon(Map<String, dynamic> platforms) {
  return hasMacOSConfig(platforms) && platforms['macos']['enable'] == true;
}

/// Checks if the config has windows.
bool hasWindowsConfig(Map<String, dynamic> platforms) {
  return platforms.containsKey('windows');
}

/// Checks if the config need windows.
bool isNeedingNewWindowsIcon(Map<String, dynamic> platforms) {
  return hasWindowsConfig(platforms) && platforms['windows']['enable'] == true;
}

/// Checks if the config has linux.
bool hasLinuxConfig(Map<String, dynamic> platforms) {
  return platforms.containsKey('linux');
}

/// Checks if the config need linux.
bool isNeedingNewLinuxIcon(Map<String, dynamic> platforms) {
  return hasLinuxConfig(platforms) && platforms['linux']['enable'] == true;
}

/// Checks if the config has web.
bool hasWebConfig(Map<String, dynamic> platforms) {
  return platforms.containsKey('web');
}

/// Checks if the config need linux.
bool isNeedingNewWebIcon(Map<String, dynamic> platforms) {
  return hasWebConfig(platforms) && platforms['web']['enable'] == true;
}

/// Checks if the config has chrome extension.
bool hasChromeExtensionConfig(Map<String, dynamic> platforms) {
  return platforms.containsKey('chrome_extension');
}

/// Checks if the config need chrome extension.
bool isNeedingNewChromeExtensionIcon(Map<String, dynamic> platforms) {
  return hasChromeExtensionConfig(platforms) &&
      platforms['chrome_extension']['enable'] == true;
}

/// Checking color code
bool isValidHexaCode(String hexaCode) {
  if (hexaCode[0] != '#') {
    return false;
  }

  if (!(hexaCode.length == 4 || hexaCode.length == 7)) {
    return false;
  }

  for (var i = 1; i < hexaCode.length; i++) {
    if (!((hexaCode[i].codeUnitAt(0) <= '0'.codeUnitAt(0) &&
            hexaCode[i].codeUnitAt(0) <= 9) ||
        (hexaCode[i].codeUnitAt(0) >= 'a'.codeUnitAt(0) &&
            hexaCode[i].codeUnitAt(0) <= 'f'.codeUnitAt(0)) ||
        (hexaCode[i].codeUnitAt(0) >= 'A'.codeUnitAt(0) ||
            hexaCode[i].codeUnitAt(0) <= 'F'.codeUnitAt(0)))) {
      return false;
    }
  }

  return true;
}

/// Checking valid image file
bool isImageFile(String fileName) {
  return fileName.endsWith('.png') ||
      fileName.endsWith('.jpg') ||
      fileName.endsWith('.jpeg');
}

/// Get color xml content
String getColorXmlContent(String color) {
  return '''
<?xml version="1.0" encoding="utf-8"?>
<resources>
  <color name="ic_launcher_background">${color.toUpperCase()}</color>
</resources>
''';
}

/// Delete file
bool deleteFile(String filePath) {
  try {
    final file = File(filePath);
    file.deleteSync(recursive: true);
    return true;
  } catch (e) {
    return false;
  }
}

/// Remove directory
bool removeDir(String dirPath) {
  try {
    final dir = Directory(dirPath);
    dir.deleteSync(recursive: true);
    return true;
  } catch (_) {
    return false;
  }
}
