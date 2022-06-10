import 'package:image/image.dart';

/// Checks if the config file contains a `platform`
bool hasPlatformConfig(Map<String, dynamic> config) {
  return isNeedingNewAndroidIcon(config) ||
      isNeedingNewIOSIcon(config) ||
      isNeedingNewMacOSIcon(config) ||
      isNeedingNewWindowsIcon(config) ||
      isNeedingNewWebIcon(config) ||
      isNeedingNewLinuxIcon(config);
}

/// Checks if the config has android.
bool hasAndroidConfig(Map<String, dynamic> config) {
  return config.containsKey('android');
}

/// Checks if the config need android.
bool isNeedingNewAndroidIcon(Map<String, dynamic> config) {
  return hasAndroidConfig(config) && config['android'] == true;
}

/// Checks if the config has android adaptive.
bool hasAndroidAdaptiveConfig(Map<String, dynamic> config) {
  return isNeedingNewAndroidIcon(config) &&
      (config.containsKey('adaptive_background_image') ||
          config.containsKey('adaptive_background_color')) &&
      config.containsKey('adaptive_foreground_image');
}

/// Checks if the config has ios.
bool hasIosConfig(Map<String, dynamic> config) {
  return config.containsKey('ios');
}

/// Checks if the config need ios.
bool isNeedingNewIOSIcon(Map<String, dynamic> config) {
  return hasIosConfig(config) && config['ios'] == true;
}

/// Checks if the config has macos.
bool hasMacOSConfig(Map<String, dynamic> config) {
  return config.containsKey('macos');
}

/// Checks if the config need macos.
bool isNeedingNewMacOSIcon(Map<String, dynamic> config) {
  return hasMacOSConfig(config) && config['macos'] == true;
}

/// Checks if the config has windows.
bool hasWindowsConfig(Map<String, dynamic> config) {
  return config.containsKey('windows');
}

/// Checks if the config need windows.
bool isNeedingNewWindowsIcon(Map<String, dynamic> config) {
  return hasWindowsConfig(config) && config['windows'] == true;
}

/// Checks if the config has linux.
bool hasLinuxConfig(Map<String, dynamic> config) {
  return config.containsKey('linux');
}

/// Checks if the config need linux.
bool isNeedingNewLinuxIcon(Map<String, dynamic> config) {
  return hasLinuxConfig(config) && config['linux'] == true;
}

/// Checks if the config has web.
bool hasWebConfig(Map<String, dynamic> config) {
  return config.containsKey('web');
}

/// Checks if the config need linux.
bool isNeedingNewWebIcon(Map<String, dynamic> config) {
  return hasWebConfig(config) && config['web'] == true;
}

/// Handle resizing images
Image createResizedImage(int iconSize, Image image) {
  if (image.width >= iconSize) {
    return copyResize(
      image,
      width: iconSize,
      height: iconSize,
      interpolation: Interpolation.average,
    );
  } else {
    return copyResize(
      image,
      width: iconSize,
      height: iconSize,
      interpolation: Interpolation.linear,
    );
  }
}

/// Checking color code
bool isValidHexaCode(String hexaCode) {
  if (hexaCode[0] != '#') {
    return false;
  }

  if (!(hexaCode.length == 4 || hexaCode.length == 7)) {
    return false;
  }

  for (var i = 1; i < hexaCode.length; i++)
    if (!((hexaCode[i].codeUnitAt(0) <= '0'.codeUnitAt(0) &&
            hexaCode[i].codeUnitAt(0) <= 9) ||
        (hexaCode[i].codeUnitAt(0) >= 'a'.codeUnitAt(0) &&
            hexaCode[i].codeUnitAt(0) <= 'f'.codeUnitAt(0)) ||
        (hexaCode[i].codeUnitAt(0) >= 'A'.codeUnitAt(0) ||
            hexaCode[i].codeUnitAt(0) <= 'F'.codeUnitAt(0)))) {
      return false;
    }

  return true;
}

/// Checking valid image file
bool isImageFile(String fileName) {
  return fileName.endsWith('.png') ||
      fileName.endsWith('.jpg') ||
      fileName.endsWith('.jpeg');
}

String getColorXmlContent(String color) {
  return '''
<?xml version="1.0" encoding="utf-8"?>
<resources>
  <color name="ic_launcher_background">${color.toUpperCase()}</color>
</resources>
''';
}
