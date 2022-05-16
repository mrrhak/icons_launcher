<div align="center">
  <h1 align="center">✨ Icons Launcher ✨</h1>
  <p align="center">
  A command-line tool that simplifies the task of updating your Flutter app's launcher icon. Full flexibility allows you to only update the launcher icon for specific platforms as needed.
 </p>
</div>

<div align="center">
  <a href="https://pub.dartlang.org/packages/icons_launcher">
    <img src="https://img.shields.io/pub/v/icons_launcher?label=Pub&logo=dart"
      alt="Pub Package" />
  </a>
  <a href="https://github.com/mrrhak/icons_launcher"><img src="https://img.shields.io/github/stars/mrrhak/icons_launcher.svg?style=flat&logo=github&colorB=deeppink&label=Stars" alt="Star on Github"></a>
  <a href="https://github.com/mrrhak/icons_launcher"><img src="https://img.shields.io/github/forks/mrrhak/icons_launcher?color=orange&label=Forks&logo=github" alt="Forks on Github"></a>
  <!-- <a href="https://github.com/mrrhak/icons_launcher"><img src="https://img.shields.io/github/watchers/mrrhak/icons_launcher?color=teal&label=Watchers&logo=github" alt="Watchers on Github"></a> -->
  <a href="https://github.com/mrrhak/icons_launcher/graphs/contributors">
    <img src="https://img.shields.io/github/contributors/mrrhak/icons_launcher.svg?style=flat&logo=github&colorB=yellow&label=Contributors"
      alt="Contributors" />
  </a>
  <a href="https://github.com/mrrhak/icons_launcher/actions?query=workflow%3A">
    <img src="https://github.com/mrrhak/icons_launcher/actions/workflows/main.yml/badge.svg"
      alt="Build Status" />
  </a>
  <a href="https://github.com/mrrhak/icons_launcher">
    <img src="https://img.shields.io/github/languages/code-size/mrrhak/icons_launcher?logo=github&color=blue&label=Size"
      alt="Code size" />
  </a>
  <a href="https://opensource.org/licenses/MIT">
    <img src="https://img.shields.io/github/license/mrrhak/icons_launcher?label=License&color=red&logo=Leanpub"
      alt="License: MIT" />
  </a>
  <a href="https://pub.dev/packages/icons_launcher">
    <img src="https://img.shields.io/badge/Platform-Android%20|%20iOS%20|%20Web%20|%20macOS%20|%20Windows%20|%20Linux%20-blue.svg?logo=flutter"
      alt="Platform" />
  </a>
</div>

---

<p align="center">
  <img src="https://raw.githubusercontent.com/mrrhak/icons_launcher/master/assets/icons_launcher_preview.png" width="500" alt="icons launcher preview"/>
</p>

### **Platform Support**

| Android |   iOS   |  MacOS  |   Web   |  Linux  | Windows |
| :-----: | :-----: | :-----: | :-----: | :-----: | :-----: |
|    ✔️   |   ✔️   |   ✔️   |   ✔️    |   ✔️   |   ✔️    |



## Guide

### 1. Setup the config file

Add your Icons Launcher configuration to your `pubspec.yaml` or create a new config file called `icons_launcher.yaml`.

An example is shown below. More complex examples [here](https://github.com/mrrhak/icons_launcher/tree/master/example).

#### Method 1: use with pubspec.yaml

```yaml
dev_dependencies:
  icons_launcher: ^1.1.8

flutter_icons:
  image_path: 'assets/ic_logo_border.png'
  ios: true
  android: true
```

#### Method 2: create icons_launcher.yaml at project root

```yaml
flutter_icons:
  image_path: 'assets/ic_logo_border.png'
  ios: true
  android: true
```

### 2. Run the package

After setting up the configuration, all that is left to do is run the package:

```sh
flutter pub get
flutter pub run icons_launcher:create
```

If you name your configuration file something other than `icons_launcher.yaml` or `pubspec.yaml` you will need to specify the name of the file when running the package.

```sh
flutter pub get
flutter pub run icons_launcher:create -f <your config file name here>
```

NOTE: If you are not using the existing `pubspec.yaml` your config file must still be located in the same directory as it.

If you encounter any issues [please report them here](https://github.com/mrrhak/icons_launcher/issues).

In the above configuration, the package is setup to replace the existing launcher icons in both the Android and iOS project.

---

## Attributes

Shown below is the full list of attributes which you can specify within your Icons Launcher configuration.

- `android`/`ios`/`web`/`macos`/`windows`/`linux`
  - `true`: Override the default existing Flutter launcher icon for the platform specified
  - `false`: Ignore making launcher icons for this platform
  - `icon/path/here.png`: This will generate a new launcher icons for the platform with the name you specify, without removing the old default existing icon launcher.

- `image_path`: The location of the icon image file which you want to use as the app launcher icon

- `image_path_android`: The location of the icon image file specific for Android platform (optional - if not defined then the image_path is used)

- `image_path_ios`: The location of the icon image file specific for iOS platform (optional - if not defined then the image_path is used)

- `image_path_macos`: The location of the icon image file specific for MacOS platform (optional - if not defined then the image_path is used)

- `image_path_windows`: The location of the icon image file specific for Windows platform (optional - if not defined then the image_path is used)

- `image_path_linux`: The location of the icon image file specific for Linux platform (optional - if not defined then the image_path is used)

- `image_path_web`: The location of the icon image file specific for Web platform (optional - if not defined then the image_path is used)

The next three attributes are only used when generating Android adaptive launcher icon ([Read more](https://developer.android.com/guide/practices/ui_guidelines/icon_design_adaptive))

- `adaptive_icon_background`: The color (E.g. `"#ffffff"`) or image asset (E.g. `"assets/ic_background.png"`) which will
be used to fill out the background of the adaptive icon.

- `adaptive_icon_foreground`: The image asset which will be used for the icon foreground of the adaptive icon

- `adaptive_icon_round`: The image asset which will be used for the round icon of the adaptive icon (optional)

#### Note:
- _Android adaptive icon will generate if you provide `adaptive_icon_background` and `adaptive_icon_foreground`._
- _`adaptive_icon_round` is optional, if you provide you must provide two config above also, the plugin will modify your `AndroidMainifest.xml` to add `android:roundIcon="@mipmap/ic_launcher_round` and create a new file `ic_launcher_round.xml` to` mipmap-anydpi-v26`_
- _iOS icons should [fill the entire image](https://stackoverflow.com/questions/26014461/black-border-on-my-ios-icon) and not contain transparent borders._

---
## Flavor support

Create a Icons Launcher configuration file for your flavor. The config file is called `icons_launcher-<flavor>.yaml` by replacing `<flavor>` by the name of your desired flavor.

The configuration file format is the same.

---
## Example

### Use in pubspec.yaml

```yaml
dev_dependencies:
  icons_launcher: ^1.1.8

flutter_icons:
  # image_path: 'assets/ic_logo_border.png'
  image_path_android: 'assets/ic_logo_border.png'
  image_path_ios: 'assets/ic_logo_rectangle.png'
  image_path_macos: 'assets/ic_logo_border.png'
  image_path_windows: 'assets/ic_logo_border.png'
  image_path_linux: 'assets/ic_logo_border.png'
  image_path_web: 'assets/ic_logo_border.png'
  adaptive_icon_background: 'assets/ic_background.png'
  adaptive_icon_foreground: 'assets/ic_foreground.png' 
  adaptive_icon_round: 'assets/ic_logo_round.png' #! (Optional)
  remove_alpha_ios: false
  remove_alpha_macos: false
  ios: true
  android: true
  macos: false
  windows: false
  linux: false
  web: false
```

### Or use in custom yaml (icons_launcher.yaml)

```yaml
flutter_icons:
  # image_path: 'assets/ic_logo_border.png'
  image_path_android: 'assets/ic_logo_border.png'
  image_path_ios: 'assets/ic_logo_rectangle.png'
  image_path_macos: 'assets/ic_logo_border.png'
  image_path_windows: 'assets/ic_logo_border.png'
  image_path_linux: 'assets/ic_logo_border.png'
  image_path_web: 'assets/ic_logo_border.png'
  adaptive_icon_background: 'assets/ic_background.png'
  adaptive_icon_foreground: 'assets/ic_foreground.png' 
  adaptive_icon_round: 'assets/ic_logo_round.png' #! (Optional)
  remove_alpha_ios: false
  remove_alpha_macos: false
  ios: true
  android: true
  macos: false
  windows: false
  linux: false
  web: false
```

---

  <h6 align="center" style="font-size: 8px;">
  
  _This package is forked from <a href="https://pub.dev/packages/flutter_launcher_icons">flutter_launcher_icons</a> which includes bugs fixed & adds more platform support._
  </h6>

