part of icons_launcher_cli;

/// Flavor helper class
class _FlavorHelper {
  _FlavorHelper(this._flavor) {
    if (_flavor != null) {
      _androidResFolder = 'android/app/src/$_flavor/res/';
      _iOSFlavorName = _flavor!.capitalize();
    } else {
      _androidResFolder = 'android/app/src/main/res/';
      _iOSFlavorName = '';
    }
  }

  // Android related path values
  final String? _flavor;
  late String _androidResFolder;

  /// Get flavor name
  String? get flavor {
    return _flavor;
  }

  /// Get Android res folder
  String get androidResFolder {
    return _androidResFolder;
  }

  /// Get Android drawable folder
  String get androidDrawableFolder {
    return '${_androidResFolder}drawable/';
  }

  /// Get Android night drawable folder
  String get androidNightDrawableFolder {
    return '${_androidResFolder}drawable-night/';
  }

  /// Get Android launcher background color XML file
  String get androidLaunchBackgroundFile {
    return '${androidDrawableFolder}launch_background.xml';
  }

  /// Get Android launcher dark background color XML file
  String get androidLaunchDarkBackgroundFile {
    return '${androidNightDrawableFolder}launch_background.xml';
  }

  /// Get Android style XML file
  String get androidStylesFile {
    return '${_androidResFolder}values/styles.xml';
  }

  /// Get Android night style XML file
  String get androidNightStylesFile {
    return '${_androidResFolder}values-night/styles.xml';
  }

  /// Get Android v31 style XML file
  String get androidV31StylesFile {
    return '${_androidResFolder}values-v31/styles.xml';
  }

  /// Get Android v31 night style XML file
  String get androidV31StylesNightFile {
    return '${_androidResFolder}values-night-v31/styles.xml';
  }

  /// Get Android v21 drawable folder
  String get androidV21DrawableFolder {
    return '${_androidResFolder}drawable-v21/';
  }

  /// Get Android v21 launcher background XML file
  String get androidV21LaunchBackgroundFile {
    return '${androidV21DrawableFolder}launch_background.xml';
  }

  /// Get Android v21 night drawable folder
  String get androidNightV21DrawableFolder {
    return '${_androidResFolder}drawable-night-v21/';
  }

  /// Get Android v21 launcher dark background XML file
  String get androidV21LaunchDarkBackgroundFile {
    return '${androidNightV21DrawableFolder}launch_background.xml';
  }

  /// Get Android manifest file
  String get androidManifestFile {
    return 'android/app/src/main/AndroidManifest.xml';
  }

  // iOS related values
  late String? _iOSFlavorName;

  /// Get iOS flavor name
  String? get iOSFlavorName {
    return _iOSFlavorName;
  }

  /// Get iOS assets app icon folder
  String get iOSAssetsAppIconFolder {
    return 'ios/Runner/Assets.xcassets/${_flavor ?? ''}AppIcon.appiconset/';
  }

  /// Get iOS assets launch image folder
  String get iOSAssetsLaunchImageFolder {
    return 'ios/Runner/Assets.xcassets/LaunchImage$_iOSFlavorName.imageset/';
  }

  /// Get iOS assets branding image folder
  String get iOSAssetsBrandingImageFolder {
    return 'ios/Runner/Assets.xcassets/BrandingImage$_iOSFlavorName.imageset/';
  }

  /// Get iOS launch storyboard file
  String get iOSLaunchScreenStoryboardFile {
    return 'ios/Runner/Base.lproj/$iOSLaunchScreenStoryboardName.storyboard';
  }

  /// Get iOS launch storyboard name
  String get iOSLaunchScreenStoryboardName {
    return 'LaunchScreen$_iOSFlavorName';
  }

  /// Get iOS info.plist file
  String get iOSInfoPlistFile {
    return 'ios/Runner/Info.plist';
  }

  /// Get iOS assets background folder
  String get iOSAssetsLaunchImageBackgroundFolder {
    return 'ios/Runner/Assets.xcassets/LaunchBackground$_iOSFlavorName.imageset/';
  }

  /// Get iOS launch image name
  String get iOSLaunchImageName {
    if (_iOSFlavorName == null) {
      return 'LaunchImage';
    } else {
      return 'LaunchImage$_iOSFlavorName';
    }
  }

  /// Get iOS branding image name
  String get iOSBrandingImageName {
    if (_iOSFlavorName == null) {
      return 'BrandingImage';
    } else {
      return 'BrandingImage$_iOSFlavorName';
    }
  }

  /// Get iOS launch background name
  String get iOSLaunchBackgroundName {
    if (_iOSFlavorName == null) {
      return 'LaunchBackground';
    } else {
      return 'LaunchBackground$_iOSFlavorName';
    }
  }
}

extension StringExtension on String {
  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }
}
