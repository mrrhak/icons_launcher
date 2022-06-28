import '../src/version.dart';

const String START_MESSAGE = '''\n
╔════════════════════════════════════════════════════╗
║             ✨✨  ICONS LAUNCHER  ✨✨             ║
╠════════════════════════════════════════════════════╣
║                Version: $packageVersion               ║
╚════════════════════════════════════════════════════╝
\n''';

const String END_MESSAGE = '''\n
==> GENERATE LAUNCHER ICONS SUCCESSFULLY <==
            ❤️   THANK YOU! ❤️
''';

const String FLUTTER_SDK_GRADLE_FILE =
    '/packages/flutter_tools/gradle/flutter.gradle';
const String ANDROID_LOCAL_PROPERTIES = 'android/local.properties';
const String ANDROID_GRADLE_FILE = 'android/app/build.gradle';

const String ANDROID_COLOR_FILE = 'values/colors.xml';

const String ANDROID_MANIFEST_FILE = 'android/app/src/main/AndroidManifest.xml';

const String ANDROID_ICON_NAME = 'ic_launcher';

const String ANDROID_ICON_FILE_NAME = '$ANDROID_ICON_NAME.png';

const String ANDROID_PLAYSTORE_ICON_NAME = 'ic_launcher-playstore';

const String ANDROID_PLAYSTORE_ICON_FILE_NAME =
    '$ANDROID_PLAYSTORE_ICON_NAME.png';

const String ANDROID_ADAPTIVE_ROUND_ICON_NAME = 'ic_launcher_round';

const String ANDROID_ADAPTIVE_ROUND_ICON_FILE_NAME =
    '$ANDROID_ADAPTIVE_ROUND_ICON_NAME.png';

const String ANDROID_ADAPTIVE_FOREGROUND_ICON_NAME = 'ic_launcher_foreground';

const String ANDROID_ADAPTIVE_FOREGROUND_ICON_FILE_NAME =
    '$ANDROID_ADAPTIVE_FOREGROUND_ICON_NAME.png';

const String ANDROID_ADAPTIVE_BACKGROUND_ICON_NAME = 'ic_launcher_background';

const String ANDROID_ADAPTIVE_BACKGROUND_ICON_FILE_NAME =
    '$ANDROID_ADAPTIVE_BACKGROUND_ICON_NAME.png';

const String ANDROID_ADAPTIVE_XML_DIR = 'mipmap-anydpi-v26';

const String ANDROID_ADAPTIVE_XML_FILE_NAME = '$ANDROID_ICON_NAME.xml';

const String ANDROID_ADAPTIVE_ROUND_XML_FILE_NAME =
    '$ANDROID_ADAPTIVE_ROUND_ICON_NAME.xml';

const String IC_LAUNCHER_BACKGROUND_COLOR_XML = '''
<?xml version="1.0" encoding="utf-8"?>
<adaptive-icon xmlns:android="http://schemas.android.com/apk/res/android">
  <background android:drawable="@color/ic_launcher_background"/>
  <foreground android:drawable="@mipmap/ic_launcher_foreground"/>
</adaptive-icon>
''';

const String IC_LAUNCHER_MIP_MAP_XML = '''
<?xml version="1.0" encoding="utf-8"?>
<adaptive-icon xmlns:android="http://schemas.android.com/apk/res/android">
  <background android:drawable="@mipmap/ic_launcher_background"/>
  <foreground android:drawable="@mipmap/ic_launcher_foreground"/>
</adaptive-icon>
''';

const String IC_LAUNCHER_ROUND_BACKGROUND_COLOR_XML = '''
<?xml version="1.0" encoding="utf-8"?>
<adaptive-icon xmlns:android="http://schemas.android.com/apk/res/android">
  <background android:drawable="@color/ic_launcher_background"/>
  <foreground android:drawable="@mipmap/ic_launcher_foreground"/>
</adaptive-icon>
''';

const String IC_LAUNCHER_ROUND_MIP_MAP_XML = '''
<?xml version="1.0" encoding="utf-8"?>
<adaptive-icon xmlns:android="http://schemas.android.com/apk/res/android">
  <background android:drawable="@mipmap/ic_launcher_background"/>
  <foreground android:drawable="@mipmap/ic_launcher_foreground"/>
</adaptive-icon>
''';

const String IOS_CONFIG_FILE = 'ios/Runner.xcodeproj/project.pbxproj';

const String IOS_DEFAULT_ICON_NAME = 'Icon-App';

const String WEB_DEFAULT_FAVICON_DIR = 'web/';

const String WEB_DEFAULT_ICON_DIR = 'web/icons/';

const String MACOS_DEFAULT_APP_ICON_DIR =
    'macos/Runner/Assets.xcassets/AppIcon.appiconset/';
const String MACOS_ASSET_DIR = 'macos/Runner/Assets.xcassets/';
const String MACOS_CONFIG_FILE = 'macos/Runner.xcodeproj/project.pbxproj';
const String MACOS_DEFAULT_ICON_NAME = 'app_icon';
const String MACOS_DEFAULT_ICON_FILE_NAME = '$MACOS_DEFAULT_ICON_NAME.png';

const String WINDOWS_DEFAULT_ICON_DIR = 'windows/runner/resources/';

const String WINDOWS_DEFAULT_ICON_NAME = 'app_icon';

const String WINDOWS_DEFAULT_ICON_FILE_NAME = '$WINDOWS_DEFAULT_ICON_NAME.ico';

const String LINUX_DEFAULT_ICON_DIR = 'snap/gui/';

const String LINUX_DEFAULT_ICON_NAME = 'app_icon';

const String LINUX_DEFAULT_ICON_FILE_NAME = '$LINUX_DEFAULT_ICON_NAME.png';
