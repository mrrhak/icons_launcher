import 'package:icons_launcher/constants.dart';
import 'package:icons_launcher/main.dart' as main_dart;
import 'package:icons_launcher/src/android.dart' as android;
import 'package:icons_launcher/src/ios.dart' as ios;
import 'package:test/test.dart';
import 'package:universal_io/io.dart';
import 'package:yaml/yaml.dart';

// Unit tests for main.dart
void main() {
  test('Version checker', () {
    // Read yaml config file
    final File file = File('pubspec.yaml');
    final String content = file.readAsStringSync();
    final Map yaml = loadYaml(content);

    // Read message constant
    final message = introMessage();
    expect(message, contains(yaml['version']));
  });

  test('Android icon list is correct size', () {
    expect(android.androidIcons.length, 5);
  });

  test('Adaptive foreground icons icon list is correct size', () {
    expect(android.adaptiveForegroundIcons.length, 5);
  });

  test('iOS icon list is correct size', () {
    expect(ios.iosIcons.length, 21);
  });

  test(
      'iOS image list used to generate Contents.json for icon directory is correct size',
      () {
    expect(ios.createImageList('blah').length, 25);
  });

  test('pubspec.yaml file exists', () async {
    const String path = 'test/config/icons_launcher_test_pubspec.yaml';
    final Map<String, dynamic> config = main_dart.loadConfigFile(path, null);
    expect(config.length, isNotNull);
  });

  test('Incorrect pubspec.yaml path throws correct error message', () async {
    const String incorrectPath = 'test/config/test_pubspec.yam';
    expect(() => main_dart.loadConfigFile(incorrectPath, null),
        throwsA(const TypeMatcher<FileSystemException>()));
  });

  test('image_path is in config', () {
    final Map<String, dynamic> flutterIconsConfig = <String, dynamic>{
      'image_path': 'assets/ic_logo_border.png',
      'android': true,
      'ios': true
    };
    expect(main_dart.isImagePathInConfig(flutterIconsConfig), true);
    final Map<String, dynamic> flutterIconsConfigAndroid = <String, dynamic>{
      'image_path_android': 'assets/images/icon-710x599.png',
      'android': true,
      'ios': true
    };
    expect(main_dart.isImagePathInConfig(flutterIconsConfigAndroid), false);
    final Map<String, dynamic> flutterIconsConfigBoth = <String, dynamic>{
      'image_path_android': 'assets/ic_logo_border.png',
      'image_path_ios': 'assets/ic_logo_rectangle.png',
      'image_path_macos': 'assets/ic_logo_border.png',
      'image_path_windows': 'assets/ic_logo_border.png',
      'image_path_linux': 'assets/ic_logo_border.png',
      'image_path_web': 'assets/ic_logo_border.png',
      'adaptive_icon_background': 'assets/ic_background.png',
      'adaptive_icon_foreground': 'assets/ic_foreground.png',
      'adaptive_icon_round': 'assets/ic_logo_round.png',
      'remove_alpha_ios': false,
      'remove_alpha_macos': false,
      'ios': true,
      'android': true,
      'macos': false,
      'windows': false,
      'linux': false,
      'web': false
    };
    expect(main_dart.isImagePathInConfig(flutterIconsConfigBoth), true);
  });

  test('At least one platform is in config file', () {
    final Map<String, dynamic> flutterIconsConfig = <String, dynamic>{
      'image_path': 'assets/ic_logo_border.png',
      'android': true,
      'ios': true
    };
    expect(main_dart.hasPlatformConfig(flutterIconsConfig), true);
  });

  test('No platform specified in config', () {
    final Map<String, dynamic> flutterIconsConfig = <String, dynamic>{
      'image_path': 'assets/ic_logo_border.png'
    };
    expect(main_dart.hasPlatformConfig(flutterIconsConfig), false);
  });

  test('No new Android icon needed - android: false', () {
    final Map<String, dynamic> flutterIconsConfig = <String, dynamic>{
      'image_path': 'assets/ic_logo_border.png',
      'android': false,
      'ios': true
    };
    expect(main_dart.isNeedingNewAndroidIcon(flutterIconsConfig), false);
  });

  test('No new Android icon needed - no Android config', () {
    final Map<String, dynamic> flutterIconsConfig = <String, dynamic>{
      'image_path': 'assets/ic_logo_border.png',
      'ios': true
    };
    expect(main_dart.isNeedingNewAndroidIcon(flutterIconsConfig), false);
  });

  test('No new iOS icon needed - ios: false', () {
    final Map<String, dynamic> flutterIconsConfig = <String, dynamic>{
      'image_path': 'assets/ic_logo_border.png',
      'android': true,
      'ios': false
    };
    expect(main_dart.isNeedingNewIOSIcon(flutterIconsConfig), false);
  });

  test('No new iOS icon needed - no iOS config', () {
    final Map<String, dynamic> flutterIconsConfig = <String, dynamic>{
      'image_path': 'assets/ic_logo_border.png',
      'android': true
    };
    expect(main_dart.isNeedingNewIOSIcon(flutterIconsConfig), false);
  });
}
