# Changelog

## 2.0.0-beta.1
 - Rewrite and improve flavor support
 - New flavor script (E.g. `icons_launcher-dev.yaml`)
     ```sh
     flutter pub run icons_launcher:create --flavor dev
     ```
 - Add new config
   - `color_adaptive_background`
 - ## Breaking changes:
   - Rename runner from `icons_launcher:main` to  `icons_launcher:create`

      ```sh
      flutter pub run icons_launcher:create
      ```
   - Rename config from `flutter_icons:` to `icons_launcher:`

      ```yaml
      icons_launcher:
        image_path: 'icon.png'
        android: true
      ```
   - Rename config option:
     - from `adaptive_icon_background` to `image_adaptive_background`
     - from `adaptive_icon_foreground` to `image_adaptive_foreground`
     - from `adaptive_icon_round` to `image_adaptive_round`
   - Config option removed
     - `remove_alpha_ios`
     - `remove_alpha_macos`

## 1.2.1
 - Fixed bug windows platform icon list embedded

## 1.2.0
 - Improve windows platform to highest quality icon with multiple sizes embedded ([Feature request](https://github.com/mrrhak/icons_launcher/issues/8))

## 1.1.9
 - Fixed platform config checking ([#7](https://github.com/mrrhak/icons_launcher/issues/7))
 - Update example app

## 1.1.8
 - Fixed generate windows launcher icon from linux system ([#5](https://github.com/mrrhak/icons_launcher/issues/5))
 - Deprecated `icons_launcher:main`. Use `icons_launcher:create` instead.
 - Update README.md

## 1.1.7
 - Fixed image preview path

## 1.1.6
 - Fixed generate incorrect android xml file when use background color ([#4](https://github.com/mrrhak/icons_launcher/issues/4))
 - Fixed create android `ic_launcher.xml` and `ic_launcher_round.xml`
 - Update README.md

## 1.1.5
 - Fixed issue with pub.dev analysis

## 1.1.4
 - Fixed android adaptive icon ([#3](https://github.com/mrrhak/icons_launcher/issues/3))
 - Android files are generated to `mipmap` instead of `drawable` follow Android Studio
 - New android config `image_adaptive_round`
 - New `ic_launcher-playstore.png` is generated in main folder
 - Update example app
 - Update README.md

## 1.1.3
 - Fixed linux
 - Improve grammar and formatting ([#1](https://github.com/mrrhak/icons_launcher/pull/1))
 - Update README.md

## 1.1.2
 - Update README.md

## 1.1.1
 - Fixed web support
   - Replace `'dart:io'` with `universal_io`

## 1.1.0
 - Add web support

## 1.0.1
 - Provide documentation

## 1.0.0

- Initial version
