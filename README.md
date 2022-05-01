<div align="center">
  <h1 align="center">✨ Icons Launcher ✨</h1>

  ###### This package fork from [Flutter Launcher Icons](https://pub.dev/packages/flutter_launcher_icons)
</div>


<div align="center">
  <a href="https://flutter.dev">
    <img src="https://img.shields.io/badge/Platform-Flutter-02569B?logo=flutter"
      alt="Platform" />
  </a>
  <a href="https://pub.dartlang.org/packages/icons_launcher">
    <img src="https://img.shields.io/pub/v/icons_launcher?label=Pub&logo=dart"
      alt="Pub Package" />
  </a>
  <a href="https://github.com/mrrhak/icons_launcher"><img src="https://img.shields.io/github/stars/mrrhak/icons_launcher.svg?style=flat&logo=github&colorB=deeppink&label=stars" alt="Star on Github"></a>
  <a href="https://github.com/mrrhak/icons_launcher/graphs/contributors">
    <img src="https://img.shields.io/github/contributors/mrrhak/icons_launcher.svg?style=flat&logo=github&colorB=yellow"
      alt="Contributors" />
  </a>
  <a href="https://github.com/mrrhak/icons_launcher/actions?query=workflow%3A">
    <img src="https://github.com/mrrhak/icons_launcher/actions/workflows/main.yml/badge.svg"
      alt="Build Status" />
  </a>
  <a href="https://opensource.org/licenses/MIT">
    <img src="https://img.shields.io/github/license/mrrhak/icons_launcher?color=red&logo=Leanpub"
      alt="License: MIT" />
  </a>
</div>

### <strong>Platform Support</strong>

| Android | iOS | MacOS | Web | Linux | Windows |
| :-----: | :-: | :---: | :-: | :---: | :-----: |
|   ✔️   | ✔️  |   ✔️  |  ✔️ |  ✔️  |    ✔️  |


A command-line tool which simplifies the task of updating your Flutter app's icon launcher. Fully flexible, allowing you to choose what platform you wish to update the icon launcher for and if you want.

Want to see older changes? Be sure to check out the [Changelog](https://github.com/mrrhak/icons_launcher/blob/master/CHANGELOG.md).

---
## Guide

#### 1. Setup the config file

Add your Icons Launcher configuration to your `pubspec.yaml` or create a new config file called `icons_launcher.yaml`.
An example is shown below. More complex examples [here](https://github.com/mrrhak/icons_launcher/tree/master/example).

##### Method 1: use with pubspec.yaml
```yaml
dev_dependencies:
  icons_launcher: "^1.1.1"

flutter_icons:
  android: true
  ios: true
  image_path: "assets/icon/icon.png"
```

##### Method 2: create icons_launcher.yaml at project root
```yaml
flutter_icons:
  android: true
  ios: true
  image_path: "assets/icon/icon.png"
```

#### 2. Run the package

After setting up the configuration, all that is left to do is run the package.

```
flutter pub get
flutter pub run icons_launcher:main
```

If you name your configuration file something other than `icons_launcher.yaml` or `pubspec.yaml` you will need to specify
the name of the file when running the package.

```
flutter pub get
flutter pub run icons_launcher:main -f <your config file name here>
```

Note: If you are not using the existing `pubspec.yaml` ensure that your config file is located in the same directory as it.

If you encounter any issues [please report them here](https://github.com/mrrhak/icons_launcher/issues).


In the above configuration, the package is setup to replace the existing launcher icons in both the Android and iOS project.

---

## Attributes

Shown below is the full list of attributes which you can specify within your Icons Launcher configuration.

- `android`/`ios`/`web`/`macos`/`windows`/`linux`
  - `true`: Override the default existing Flutter launcher icon for the platform specified
  - `false`: Ignore making launcher icons for this platform
  - `icon/path/here.png`: This will generate a new launcher icons for the platform with the name you specify, without removing the old default existing icon launcher.

- `image_path`: The location of the icon image file which you want to use as the app icon launcher

- `image_path_android`: The location of the icon image file specific for Android platform (optional - if not defined then the image_path is used)

- `image_path_ios`: The location of the icon image file specific for iOS platform (optional - if not defined then the image_path is used)

- `image_path_macos`: The location of the icon image file specific for MacOS platform (optional - if not defined then the image_path is used)

- `image_path_windows`: The location of the icon image file specific for Windows platform (optional - if not defined then the image_path is used)

- `image_path_linux`: The location of the icon image file specific for Linux platform (optional - if not defined then the image_path is used)
- 
- `image_path_web`: The location of the icon image file specific for Web platform (optional - if not defined then the image_path is used)

The next two attributes are only used when generating Android icon launcher

- `adaptive_icon_background`: The color (E.g. `"#ffffff"`) or image asset (E.g. `"assets/images/christmas-background.png"`) which will
be used to fill out the background of the adaptive icon.

- `adaptive_icon_foreground`: The image asset which will be used for the icon foreground of the adaptive icon

_Note: iOS icons should [fill the entire image](https://stackoverflow.com/questions/26014461/black-border-on-my-ios-icon) and not contain transparent borders._

---
## Flavor support

Create a Icons Launcher configuration file for your flavor. The config file is called `icons_launcher-<flavor>.yaml` by replacing `<flavor>` by the name of your desired flavor.

The configuration file format is the same.

---
## Example

### Use in pubspec.yaml
```yaml
dev_dependencies:
  icons_launcher: "^1.1.1"

flutter_icons:
  image_path_android: "assets/images/icon-1024x1024.png"
  image_path_ios: "assets/images/icon-1024x1024.png"
  image_path_macos: 'assets/images/icon-710x599.png'
  image_path_windows: 'assets/images/icon-710x599.png'
  image_path_linux: 'assets/images/icon-710x599.png'
  image_path_web: 'assets/images/icon-1024x1024.png'
  adaptive_icon_background: "assets/images/christmas-background.png"
  adaptive_icon_foreground: "assets/images/icon-foreground-432x432.png"
  android: true
  ios: true
  remove_alpha_ios: true
  macos: true
  remove_alpha_macos: true
  windows: true
  linux: true
  web: true
```

### Use in custom yaml (icons_launcher.yaml)

```yaml
flutter_icons:
  image_path_android: "assets/images/icon-1024x1024.png"
  image_path_ios: "assets/images/icon-1024x1024.png"
  image_path_macos: 'assets/images/icon-710x599.png'
  image_path_windows: 'assets/images/icon-710x599.png'
  image_path_linux: 'assets/images/icon-710x599.png'
  image_path_web: 'assets/images/icon-1024x1024.png'
  adaptive_icon_background: "assets/images/christmas-background.png"
  adaptive_icon_foreground: "assets/images/icon-foreground-432x432.png"
  android: true
  ios: true
  remove_alpha_ios: true
  macos: true
  remove_alpha_macos: true
  windows: true
  linux: true
  web: true
```

---

<p align="center">Maintained by <a href="https://mrrhak.com">Mrr Hak</a></p>
<p align="center" style="font-size: 56px">💙</p>
