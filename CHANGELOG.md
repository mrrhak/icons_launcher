# Changelog

## 2.1.6
- Add default Android min SDK
- Add CONTRIBUTING.md
- Update Dart Analysis

## 2.1.5
- Update lints suggestion
- Update README.md
  
## 2.1.4

- Adds pub topics to package metadata
- Updates minimum supported SDK version to Dart 3
- Upgrade dependencies

## 2.1.3

- Fix round icons on android and ability to use without monochrome ([#35](https://github.com/mrrhak/icons_launcher/pull/35))

## 2.1.2

- Fixed android monochrome icon is smaller and blurred ([#32](https://github.com/mrrhak/icons_launcher/pull/32))

## 2.1.1

- Bump Dart SDK lower bound to <4.0.0 to support Dart 3
- Update doc command to use `dart run` instead of `flutter pub run` that deprecated
- Upgrade dependencies

## 2.1.0

- Added new support android material 3 monochrome icons ([#28](https://github.com/mrrhak/icons_launcher/pull/28))
- Upgrade dependencies

## 2.0.7

- Added funding URLs
- Added screenshots
- Upgrade dependencies

## 2.0.6

- Fixed always overwrite `.desktop` file of Linux platform ([#23](https://github.com/mrrhak/icons_launcher/issues/23))
- Update a dependency to the latest release

## 2.0.5

- Flutter 3.3
- Improve pub analytic

## 2.0.4

- Fixed android config validation ([#22](https://github.com/mrrhak/icons_launcher/issues/22))

## 2.0.3

- Fixed missing generate Contents.json for ios and macos ([#20](https://github.com/mrrhak/icons_launcher/issues/20))

## 2.0.2

- Fixed generate playstore icon wrong location ([#19](https://github.com/mrrhak/icons_launcher/issues/19))
- Fixed android adaptive round icon not remove ([#18](https://github.com/mrrhak/icons_launcher/issues/18))

## 2.0.1

- Fixed bug with `adaptive_background_color` and `adaptive_round_image` on android thanks to [Carapacik](https://github.com/mrrhak/icons_launcher/pull/17)
- Improve config validation

## 2.0.0

- Add web custom favicon support
- ## Config breaking changes:

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

## 2.0.0-beta.2

- Fixed auto remove image alpha channel for iOS platform to follow AppStore guideline
- Fixed iOS flavor
- Improved pub score
- Improved log

## 2.0.0-beta.1

- Rewrite and improve flavor support
- New flavor script (E.g. `icons_launcher-dev.yaml`)
  ```sh
  flutter pub run icons_launcher:create --flavor dev
  ```
- Add new config
  - `color_adaptive_background`
- ## Breaking changes:

  - Rename runner from `icons_launcher:main` to `icons_launcher:create`

    ```sh
    flutter pub run icons_launcher:create
    ```

  - Rename config from `flutter_icons:` to `icons_launcher:`

    ```yaml
    icons_launcher:
      image_path: "icon.png"
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
