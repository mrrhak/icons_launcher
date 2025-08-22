# flavor_app

Demo of `icons_launcher` using flavors.

## Getting Started

First: `flutter pub get`

Then generate `dev`, `stage` and `prod` flavors with the commands:
```
dart run icons_launcher:create --flavor dev
dart run icons_launcher:create --flavor stage
dart run icons_launcher:create --flavor prod

# Or
dart run icons_launcher:create --flavors dev,stage,prod
```

## Run with flavor
### Run with `dev` flavor
```
flutter run --flavor dev
```

### Run with `stage` flavor
```
flutter run --flavor stage
```

### Run with `prod` flavor
```
flutter run --flavor prod
```
