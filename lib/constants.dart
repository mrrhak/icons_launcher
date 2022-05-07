const String flutterSdkGradleFile =
    '/packages/flutter_tools/gradle/flutter.gradle';
String androidMainFolder(String? flavor) =>
    "android/app/src/${flavor ?? 'main'}/";
String androidResFolder(String? flavor) =>
    "android/app/src/${flavor ?? 'main'}/res/";
String androidColorsFile(String? flavor) =>
    "android/app/src/${flavor ?? 'main'}/res/values/colors.xml";
const String androidLocalProperties = 'android/local.properties';
const String androidManifestFile = 'android/app/src/main/AndroidManifest.xml';
const String androidGradleFile = 'android/app/build.gradle';
const String androidFileName = 'ic_launcher.png';
const String androidRoundFileName = 'ic_launcher_round.png';
const String androidAdaptiveForegroundFileName = 'ic_launcher_foreground.png';
const String androidAdaptiveBackgroundFileName = 'ic_launcher_background.png';
const String androidPlayStoreFileName = 'ic_launcher-playstore.png';
String androidAdaptiveXmlFolder(String? flavor) =>
    androidResFolder(flavor) + 'mipmap-anydpi-v26/';
const String androidDefaultIconName = 'ic_launcher';
const String androidDefaultRoundIconName = 'ic_launcher_round';

const String iosDefaultIconFolder =
    'ios/Runner/Assets.xcassets/AppIcon.appiconset/';
const String iosAssetFolder = 'ios/Runner/Assets.xcassets/';
const String iosConfigFile = 'ios/Runner.xcodeproj/project.pbxproj';
const String iosDefaultIconName = 'Icon-App';

const String macosDefaultIconFolder =
    'macos/Runner/Assets.xcassets/AppIcon.appiconset/';
const String macosAssetFolder = 'macos/Runner/Assets.xcassets/';
const String macosConfigFile = 'macos/Runner.xcodeproj/project.pbxproj';
const String macosDefaultIconName = 'app_icon';

const String windowsDefaultIconFolder = 'windows/Runner/resources/';
const String windowsDefaultIconName = 'app_icon';

const String linuxDefaultIconFolder = 'snap/gui/';
const String linuxDefaultIconName = 'app_icon';

const String webDefaultFaviconFolder = 'web/';
const String webDefaultIconFolder = 'web/icons/';

const String errorMissingImagePath =
    'Missing "image_path" or "image_path_android" + "image_path_ios" within configuration';
const String errorMissingPlatform =
    'No platform specified within config to generate icons for.';
const String errorMissingRegularAndroid =
    'Adaptive icon config found but no regular Android config. '
    'Below API 26 the regular Android config is required';
const String errorIncorrectIconName =
    'The icon name must contain only lowercase a-z, 0-9, or underscore: '
    'E.g. "ic_my_new_icon"';
const String errorMissingMinSdk =
    'Cannot not find minSdkVersion from android/app/build.gradle or android/local.properties'
    'Specify minSdkVersion in either android/app/build.gradle or android/local.properties';

String introMessage() {
  return '''\n
═════════════════════════════════════════════
      ✨  ICONS LAUNCHER STARTING  ✨
                   v1.1.5
═════════════════════════════════════════════\n''';
}
