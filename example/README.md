# Installation (2.0.0-beta.2)
```sh
flutter pub add --dev icons_launcher
```

# How to use

- Add config to `pubspec.yaml` or `create icons_launcher.yaml` at root of project.

```yaml
icons_launcher:
  image_path: 'assets/ic_logo_border.png'
  ios: true
  android: true
```

- Use different images for each platform

```yaml
icons_launcher:
  image_path: 'assets/ic_logo_border.png'
  # image_path_android: 'assets/ic_logo_border.png'
  # image_path_ios: 'assets/ic_logo_rectangle.png'
  # image_path_macos: 'assets/ic_logo_border.png'
  # image_path_windows: 'assets/ic_logo_border.png'
  # image_path_linux: 'assets/ic_logo_border.png'
  # image_path_web: 'assets/ic_logo_border.png'
  # color_adaptive_background: '#ffffff'
  image_adaptive_background: 'assets/ic_background.png'
  image_adaptive_foreground: 'assets/ic_foreground.png'
  image_adaptive_round: 'assets/ic_logo_round.png'
  android: true
  ios: true
  web: true
  macos: false
  windows: false
  linux: false
```

After configured, now you can run generation
  
```sh
flutter pub get
flutter pub run icons_launcher:create
```
Or with custom yaml file

```sh
flutter pub get
flutter pub run icons_launcher:create --path <your config file name here>
```

Or flavor app ([Example](https://github.com/mrrhak/icons_launcher/tree/master/example/flavor_app))

```sh
flutter pub get
flutter pub run icons_launcher:create --flavor <your flavor>
```
