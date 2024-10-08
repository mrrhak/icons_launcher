# Installation
```sh
flutter pub add --dev icons_launcher
```

# How to use

- Add config to `pubspec.yaml` or `create icons_launcher.yaml` at root of project.

```yaml
icons_launcher:
  image_path: 'assets/ic_logo_radius.png'
  platforms:
    android:
      enable: true
    ios:
      enable: true
```

- Use different images for each platform

```yaml
icons_launcher:
  image_path: 'assets/ic_logo_radius.png'
  platforms:
    android:
      enable: true
      image_path: 'assets/ic_logo_radius.png'
      notification_image: "assets/ic_foreground.png"
      # adaptive_background_color: '#ffffff'
      adaptive_background_image: 'assets/ic_background.png'
      adaptive_foreground_image: 'assets/ic_foreground.png'
      adaptive_round_image: 'assets/ic_logo_round.png'
      adaptive_monochrome_image: 'assets/ic_black_white.png'
    ios:
      enable: true
      image_path: 'assets/ic_logo_rectangle_light.png'
      # For iOS 18+ (support dark and tinted)
      dark_path: "assets/ic_logo_rectangle_dark.png"
      tinted_path: "assets/ic_logo_rectangle_tinted.png"
    web:
      enable: true
      image_path: 'assets/ic_logo_radius.png'
      favicon_path: 'assets/ic_logo_round.png'
    macos:
      enable: false
      image_path: 'assets/ic_logo_radius.png'
    windows:
      enable: false
      image_path: 'assets/ic_logo_radius.png'
    linux:
      enable: false
      image_path: 'assets/ic_logo_radius.png'
```

After configured, now you can run generation
  
```sh
flutter pub get
dart run icons_launcher:create
```
Or with custom yaml file

```sh
flutter pub get
dart run icons_launcher:create --path <your config file name here>
```

Or flavor app ([Example](https://github.com/mrrhak/icons_launcher/tree/master/example/flavor_app))

```sh
flutter pub get
dart icons_launcher:create --flavor <your flavor>
```
