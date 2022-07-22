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
  icons_launcher: ^2.0.0-beta.3

icons_launcher:
  image_path: 'assets/ic_logo_border.png'
  ios: true
  android: true
```

#### Method 2: create icons_launcher.yaml at project root

```yaml
icons_launcher:
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
flutter pub run icons_launcher:create --path <your config file name here>
```

NOTE: If you are not using the existing `pubspec.yaml` your config file must still be located in the same directory as it.

If you encounter any issues [please report them here](https://github.com/mrrhak/icons_launcher/issues).

In the above configuration, the package is setup to replace the existing launcher icons in both the Android and iOS project.

---

## Attributes

Shown below is the full list of attributes which you can specify within your Icons Launcher configuration.

| Option | Type | Default | Description |
| --- | --- | --- | --- |
| `android` | Boolean | `false` | Override the default existing of android |
| `ios` | Boolean | `false` | Override the default existing of ios |
| `web` | Boolean | `false` | Override the default existing of web |
| `macos` | Boolean | `false` | Override the default existing of macos |
| `windows` | Boolean | `false` | Override the default existing of windows |
| `linux` | Boolean | `false` | Override the default existing of linux |
| `image_path` | String | `null` | The image file path which you want to use as the app launcher icon |
| `image_path_android` | String | `null` | The image file path specific for Android platform (optional - if not defined then the _image_path_ is used) |
| `image_path_ios` | String | `null` | The image file path specific for iOS platform (optional - if not defined then the _image_path_ is used) |
| `image_path_web` | String | `null` | The image file path specific for Web platform (optional - if not defined then the _image_path_ is used) |
| `favicon_path_web` | String | `null` | The image file path specific for Web platform (optional - if not defined then the _image_path_ is used) |
| `image_path_macos` | String | `null` | The image file path specific for macOS platform (optional - if not defined then the _image_path_ is used) |
| `image_path_windows` | String | `null` | The image file path specific for Windows platform (optional - if not defined then the _image_path_ is used) |
| `image_path_linux` | String | `null` | The image file path specific for Linux platform (optional - if not defined then the _image_path_ is used) |
| `color_adaptive_background` | String | `null` | The color (E.g. _"#ffffff"_) used to fill out the background of the adaptive icon |
| `image_adaptive_background` | String | `null` | The image asset (E.g. _"assets/ic_background.png"_) used to fill out the background of the adaptive icon |
| `image_adaptive_foreground` | String | `null` | The image asset used for the icon foreground of the adaptive icon |
| `image_adaptive_round` | String | `null` | The image asset used for the round icon of the adaptive icon (optional) |

### Note:
- _Android adaptive icon will generate if you provide `image_adaptive_background` or `color_adaptive_background` and `image_adaptive_foreground`._
- _`image_adaptive_round` is optional, if you provide you must provide two config above also, the plugin will modify your `AndroidMainifest.xml` to add `android:roundIcon="@mipmap/ic_launcher_round` and create a new file `ic_launcher_round.xml` to` mipmap-anydpi-v26`_
- _iOS icons should [fill the entire image](https://stackoverflow.com/questions/26014461/black-border-on-my-ios-icon) and not contain transparent borders._

---
## Flavor support

Create a Icons Launcher configuration file for your flavor. The config file is called `icons_launcher-<flavor>.yaml` by replacing `<flavor>` by the name of your desired flavor.

Example: `icons_launcher-dev.yaml`

Run with flavor:
```sh
flutter pub get
flutter pub run icons_launcher:create --flavor dev
```

The configuration file format is the same.

---
## Example

### Use in pubspec.yaml

```yaml
dev_dependencies:
  icons_launcher: ^2.0.0-beta.3

icons_launcher:
  # image_path: 'assets/ic_logo_border.png'
  image_path_android: 'assets/ic_logo_border.png'
  image_path_ios: 'assets/ic_logo_rectangle.png'
  image_path_macos: 'assets/ic_logo_border.png'
  image_path_windows: 'assets/ic_logo_border.png'
  image_path_linux: 'assets/ic_logo_border.png'
  image_path_web: 'assets/ic_logo_border.png'
  favicon_path_web: 'assets/ic_logo_round.png'
  image_adaptive_background: 'assets/ic_background.png'
  image_adaptive_foreground: 'assets/ic_foreground.png' 
  image_adaptive_round: 'assets/ic_logo_round.png' #! (Optional)
  ios: true
  android: true
  macos: false
  windows: false
  linux: false
  web: false
```

### Or use in custom yaml (icons_launcher.yaml)

```yaml
icons_launcher:
  # image_path: 'assets/ic_logo_border.png'
  image_path_android: 'assets/ic_logo_border.png'
  image_path_ios: 'assets/ic_logo_rectangle.png'
  image_path_macos: 'assets/ic_logo_border.png'
  image_path_windows: 'assets/ic_logo_border.png'
  image_path_linux: 'assets/ic_logo_border.png'
  image_path_web: 'assets/ic_logo_border.png'
  favicon_path_web: 'assets/ic_logo_round.png'
  image_adaptive_background: 'assets/ic_background.png'
  image_adaptive_foreground: 'assets/ic_foreground.png' 
  image_adaptive_round: 'assets/ic_logo_round.png' #! (Optional)
  ios: true
  android: true
  macos: false
  windows: false
  linux: false
  web: false
```
