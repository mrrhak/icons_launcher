<div align="center">
  <h1 align="center" style="font-size: 50px;">✨ Icons Launcher ✨</h1>
  <p align="center">
  A command-line tool that simplifies the task of updating your Flutter app's launcher icon. Full flexibility allows you to only update the launcher icon for specific platforms as needed.
 </p>
</div>

<div align="center">
   <!--  Donations -->
  <a href="https://ko-fi.com/mrrhak">
    <img width="300" src="https://user-images.githubusercontent.com/26390946/161375567-9e14cd0e-1675-4896-a576-a449b0bcd293.png">
  </a>
  <div align="center">
    <a href="https://www.buymeacoffee.com/mrrhak">
      <img width="150" alt="buymeacoffee" src="https://user-images.githubusercontent.com/26390946/161375563-69c634fd-89d2-45ac-addd-931b03996b34.png">
    </a>
    <a href="https://ko-fi.com/mrrhak">
      <img width="150" alt="Ko-fi" src="https://user-images.githubusercontent.com/26390946/161375565-e7d64410-bbcf-4a28-896b-7514e106478e.png">
    </a>
  </div>
  <!--  Donations -->
</div>

<div align="center">
  <a href="https://pub.dartlang.org/packages/icons_launcher">
    <img src="https://img.shields.io/pub/v/icons_launcher?label=Pub&logo=dart"
      alt="Pub Package" />
  </a>
  <a href="https://pub.dartlang.org/packages/icons_launcher/score">
    <img src="https://img.shields.io/pub/points/icons_launcher?label=Score&logo=dart"
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
    <img src="https://github.com/mrrhak/icons_launcher/actions/workflows/format-analyze-test.yml/badge.svg"
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

### Platform Support

| Android | iOS | macOS | Web | Linux | Windows |
| :-----: | :-: | :---: | :-: | :---: | :-----: |
|   ✅    | ✅  |  ✅   | ✅  |  ✅   |   ✅    |

## Guide

### 1. Setup the config file

Add your Icons Launcher configuration to your `pubspec.yaml` or create a new config file called `icons_launcher.yaml`.

An example is shown below. More complex examples [here](https://github.com/mrrhak/icons_launcher/tree/master/example).

#### Add config to `pubspec.yaml` or create a separate `icons_launcher.yaml`

```yaml
icons_launcher:
  image_path: "assets/ic_logo_border.png"
  platforms:
    android:
      enable: true
    ios:
      enable: true
```

### 2. Run the package

After setting up the configuration, all that is left to do is run the package:

```sh
flutter pub get
dart run icons_launcher:create
```

If you name your configuration file something other than `icons_launcher.yaml` or `pubspec.yaml` you will need to specify the name of the file when running the package.

```sh
flutter pub get
dart run icons_launcher:create --path <your config file name here>
```

> **Note**
> 
> If you are not using the existing `pubspec.yaml` your config file must still be located in the same directory as it.

If you encounter any issues [please report them here](https://github.com/mrrhak/icons_launcher/issues).

In the above configuration, the package is setup to replace the existing launcher icons in both the Android and iOS project.

---

## Attributes

Shown below is the full list of attributes which you can specify within your Icons Launcher configuration.

| Icons Launcher Option | Type   | Default | Description                                  |
| --------------------- | ------ | ------- | -------------------------------------------- |
| `image_path`          | String | `null`  | The image file path                          |
| `platforms`           | Object | `null`  | Use for specific platforms to generate icons |

---

| Platforms Option | Type   | Default | Description                       |
| ---------------- | ------ | ------- | --------------------------------- |
| `android`        | Object | `null`  | Use for specific Android platform |
| `ios`            | Object | `null`  | Use for specific iOS platform     |
| `macos`          | Object | `null`  | Use for specific macOS platform   |
| `windows`        | Object | `null`  | Use for specific Windows platform |
| `web`            | Object | `null`  | Use for specific Web platform     |
| `linux`          | Object | `null`  | Use for specific Linux platform   |

| Android Option              | Type    | Default | Description                                                          |
| --------------------------- | ------- | ------- | -------------------------------------------------------------------- |
| `enable`                    | Boolean | `false` | Use for enable Android platform                                      |
| `image_path`                | String  | `null`  | The image file path                                                  |
| `adaptive_background_color` | String  | `null`  | Color for fill out the background of the adaptive icon (_"#ffffff"_) |
| `adaptive_background_image` | String  | `null`  | Image for fill out the background of the adaptive icon               |
| `adaptive_foreground_image` | String  | `null`  | Image for the icon foreground of the adaptive icon                   |
| `adaptive_round_image`      | String  | `null`  | Image for the round icon of the adaptive icon (optional)             |
| `adaptive_monochrome_image` | String  | `null`  | Image for the monochrome version of the adaptive icon (optional)     |

| iOS Option   | Type    | Default | Description                 |
| ------------ | ------- | ------- | --------------------------- |
| `enable`     | Boolean | `false` | Use for enable iOS platform |
| `image_path` | String  | `null`  | The image file path         |

| Web Option     | Type    | Default | Description                 |
| -------------- | ------- | ------- | --------------------------- |
| `enable`       | Boolean | `false` | Use for enable Web platform |
| `image_path`   | String  | `null`  | The image file path         |
| `favicon_path` | String  | `null`  | The image file path         |

| macOS Option | Type    | Default | Description                   |
| ------------ | ------- | ------- | ----------------------------- |
| `enable`     | Boolean | `false` | Use for enable macOS platform |
| `image_path` | String  | `null`  | The image file path           |

| Windows Option | Type    | Default | Description                     |
| -------------- | ------- | ------- | ------------------------------- |
| `enable`       | Boolean | `false` | Use for enable Windows platform |
| `image_path`   | String  | `null`  | The image file path             |

| Linux Option | Type    | Default | Description                   |
| ------------ | ------- | ------- | ----------------------------- |
| `enable`     | Boolean | `false` | Use for enable Linux platform |
| `image_path` | String  | `null`  | The image file path           |

---

## Flavor support

Create a Icons Launcher configuration file for your flavor. The config file is called `icons_launcher-<flavor>.yaml` by replacing `<flavor>` by the name of your desired flavor.

Example: `icons_launcher-dev.yaml`

Run with flavor:

```sh
flutter pub get
dart run icons_launcher:create --flavor dev
```

The configuration file format is the same.

---

## Example

```yaml
icons_launcher:
  image_path: "assets/ic_logo_border.png"
  platforms:
    android:
      enable: true
      image_path: "assets/ic_logo_border.png"
      # adaptive_background_color: '#ffffff'
      adaptive_background_image: "assets/ic_background.png"
      adaptive_foreground_image: "assets/ic_foreground.png"
      adaptive_round_image: "assets/ic_logo_round.png"
      adaptive_monochrome_image: "assets/ic_logo_monochrome.png"
    ios:
      enable: true
      image_path: "assets/ic_logo_rectangle.png"
    web:
      enable: true
      image_path: "assets/ic_logo_border.png"
      favicon_path: "assets/ic_logo_round.png"
    macos:
      enable: false
      image_path: "assets/ic_logo_border.png"
    windows:
      enable: false
      image_path: "assets/ic_logo_border.png"
    linux:
      enable: false
      image_path: "assets/ic_logo_border.png"
```
