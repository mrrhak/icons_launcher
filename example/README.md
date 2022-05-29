# Installation
```sh
flutter pub add --dev icons_launcher
```

# How to use

- Add config to `pubspec.yaml` or `create icons_launcher.yaml` at root of project.

```yaml
flutter_icons:
  image_path: 'assets/ic_logo_border.png'
  ios: true
  android: true
```

- Use different images for each platform

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

- After configured now you can run generation
  
```sh
flutter pub get
flutter pub run icons_launcher:create
```
Or with custom yaml file (like example for [Flavor App](https://github.com/mrrhak/icons_launcher/tree/master/example/flavor_app))

```sh
flutter pub get
flutter pub run icons_launcher:create -f <your config file name here>
```
